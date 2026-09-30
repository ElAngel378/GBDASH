"""Decodes a song from a FamiStudio (ca65) export as used by Famidash into rows.

The exporter's byte format is interpreted exactly like famistudio_advance_channel in
famidash-main/LIB/asm/famistudio_ca65.s (FamiTracker tempo, delayed notes/cuts,
release notes, volume track + slides, pitch track, slides, vibrato, arpeggio, duty).

decode(path, song_index) -> Song with:
    step_ntsc      FamiTracker tempo step (8.8 per frame)
    channels[5]    list of rows; each row is a dict with optional keys
                   note (int, 0 = stop), release (True), inst (int), vol (0..15),
                   speed (int), slide (from, to), duty (0..3), arp_env / pitch_env (label)
    loop_row       row index the song loops back to
    instruments    list of (vol_env, arp_env, duty_env, pitch_env) label names
    envelopes      {label: [values...], release index, loop index}
"""
import re
from pathlib import Path


class Asm:
    def __init__(self, text):
        self.data = []            # flat list of (kind, value): ('b', int) or ('w', label|int)
        self.labels = {}
        for line in text.splitlines():
            line = line.split(';', 1)[0].strip()
            if not line:
                continue
            m = re.match(r'^(@?\w+):\s*(.*)$', line)
            if m:
                self.labels[m.group(1)] = len(self.data)
                line = m.group(2).strip()
                if not line:
                    continue
            m = re.match(r'^\.(byte|word)\s+(.*)$', line)
            if not m:
                continue
            for item in m.group(2).split(','):
                item = item.strip()
                if not item:
                    continue
                if m.group(1) == 'byte':
                    try:
                        self.data.append(('b', self._num(item)))
                    except ValueError:
                        self.data.append(('b', 0))   # e.g. $00+.lobyte(FAMISTUDIO_DPCM_PTR)
                else:
                    try:
                        self.data.append(('w', self._num(item)))
                    except ValueError:
                        self.data.append(('w', item))

    @staticmethod
    def _num(s):
        s = s.strip()
        if s.startswith('$'):
            return int(s[1:], 16)
        if s.startswith('<') or s.startswith('>'):
            raise ValueError(s)
        return int(s)

    def byte(self, pos):
        k, v = self.data[pos]
        assert k == 'b', (pos, k, v)
        return v

    def word_label(self, pos):
        return self.data[pos][1]


class Song:
    pass


def envelope(asm, label):
    """-> (values per frame after the release byte, release index, loop index)"""
    pos = asm.labels[label]
    release = asm.byte(pos)
    vals, loop = [], None
    i = pos + 1
    idx = 1
    raw = []
    while True:
        b = asm.byte(i)
        raw.append(b)
        if b >= 0x80:
            vals.append(b - 192)
        elif b == 0:
            loop = asm.byte(i + 1)
            break
        else:
            # repeat previous value b more times
            vals.extend([vals[-1] if vals else 0] * b)
        i += 1
        if len(vals) > 400:
            break
    return vals, release, loop


def decode(path, song_index):
    text = Path(path).read_text()
    asm = Asm(text)
    base = asm.labels[[k for k in asm.labels if k.startswith('music_data_')][0]]
    # header: byte count, word instruments, word samples-5, then per song 5 words + 2 words
    song_pos = base + 3 + song_index * 7
    ch_labels = [asm.word_label(song_pos + c) for c in range(5)]
    song = Song()
    song.step_ntsc = asm.data[song_pos + 5][1]
    song.step_pal = asm.data[song_pos + 6][1]

    inst_pos = asm.labels['@instruments']
    song.instruments = []
    p = inst_pos
    while p < len(asm.data) and asm.data[p][0] == 'w' and isinstance(asm.data[p][1], str) and asm.data[p][1].startswith('@env'):
        song.instruments.append(tuple(asm.data[p + k][1] for k in range(4)))
        p += 4
    song.envelopes = {}
    for inst in song.instruments:
        for e in inst:
            if e not in song.envelopes:
                song.envelopes[e] = envelope(asm, e)

    song.channels = []
    song.loop_rows = []
    for ch, lab in enumerate(ch_labels):
        rows, loop_row = decode_channel(asm, lab, song)
        song.channels.append(rows)
        song.loop_rows.append(loop_row)
    return song


def decode_channel(asm, label, song, max_rows=20000):
    ptr = asm.labels[label]
    repeat = 0
    ref_len = 0
    ret = None
    rows = []
    seen_loop = None
    loop_row = 0
    loop_targets = {}   # data position -> row index when first reached (main stream)
    while len(rows) < max_rows:
        if repeat:
            repeat -= 1
            rows.append({})
            continue
        if ref_len == 0:
            if ptr in loop_targets and seen_loop == ptr:
                loop_row = loop_targets[ptr]
                break
            loop_targets.setdefault(ptr, len(rows))
        row = {}
        y = ptr
        while True:
            b = asm.byte(y)
            y += 1
            if b >= 0x80:
                v = (b & 0x7f)
                if v & 1:
                    repeat = v >> 1
                    break
                row['inst'] = v >> 1
                continue
            if b < 0x40:
                row['note'] = 0 if b == 0 else b + 12
                break
            if b >= 0x70:
                row['vol'] = b & 15
                continue
            op = b & 0x3f
            if op == 0x00:      # extended note
                row['note'] = asm.byte(y); y += 1
                break
            elif op == 0x01:    # set reference
                n = asm.byte(y)
                lab = asm.word_label(y + 1)
                ret = y + 2     # the reference word takes one data slot here
                ref_len = n
                y = asm.labels[lab]
                continue
            elif op == 0x02:    # loop
                lab = asm.word_label(y)
                seen_loop = asm.labels[lab]
                y = asm.labels[lab]
                ptr = y
                row = None
                break
            elif op == 0x03:
                row['no_attack'] = True
                continue
            elif op == 0x04:
                row['end'] = True
                continue
            elif op == 0x05:
                row['release'] = True
                break
            elif op == 0x06:
                row['speed'] = asm.byte(y); y += 1
                continue
            elif op == 0x07:
                row['note_delay'] = asm.byte(y); y += 1
                continue
            elif op == 0x08:
                row['cut_delay'] = asm.byte(y); y += 1
                continue
            elif op == 0x09:
                row['pitch_env'] = asm.word_label(y); y += 1
                continue
            elif op == 0x0a:
                row['pitch_env'] = None
                continue
            elif op == 0x0b:
                row['arp_env'] = asm.word_label(y); y += 1
                continue
            elif op == 0x0c:
                row['arp_env'] = None
                continue
            elif op == 0x0d:
                row['arp_reset'] = True
                continue
            elif op == 0x0e:
                row['fine_pitch'] = asm.byte(y); y += 1
                continue
            elif op == 0x0f:
                row['duty'] = asm.byte(y); y += 1
                continue
            elif op == 0x10:
                step = asm.byte(y); frm = asm.byte(y + 1); to = asm.byte(y + 2)
                y += 3
                row['slide'] = (step, frm, to)
                row['note'] = to
                break
            elif op == 0x11:
                row['vol_slide'] = (asm.byte(y), asm.byte(y + 1)); y += 2
                continue
            else:
                raise ValueError("unknown opcode %02x at %d" % (b, y - 1))
        if row is None:
            continue  # loop jump, re-read at the loop target
        rows.append(row)
        ptr = y
        if ref_len:
            ref_len -= 1
            if ref_len == 0:
                ptr = ret
    return rows, loop_row


if __name__ == "__main__":
    import sys
    s = decode(sys.argv[1], int(sys.argv[2]))
    print("step", s.step_ntsc, "rows per channel", [len(c) for c in s.channels], "loop", s.loop_rows)
    used = set()
    for c in s.channels:
        for r in c:
            if 'inst' in r:
                used.add(r['inst'])
    print("instruments used", sorted(used))
