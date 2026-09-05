import wave
import numpy as np

def convert_wav(filename, target_blocks):
    with wave.open(filename, 'rb') as w:
        raw = np.frombuffer(w.readframes(w.getnframes()), dtype=np.uint8)
    target_samples = target_blocks * 32
    if len(raw) < target_samples:
        padded = np.full(target_samples, 128, dtype=np.uint8)
        padded[:len(raw)] = raw
        raw = padded
    else:
        raw = np.copy(raw[:target_samples])
    # Smooth tail without uint8 overflow
    for i in range(32):
        val = int(raw[target_samples - 32 + i])
        smoothed = int((val * (31 - i) + 128 * (i + 1)) / 32)
        raw[target_samples - 32 + i] = smoothed
    nibbles = np.clip(np.round(raw.astype(float) * 15.0 / 255.0).astype(int), 0, 15)
    bytes_out = ((nibbles[0::2] << 4) | (nibbles[1::2] & 0x0F)).astype(np.uint8)
    return bytes_out

play_bytes = convert_wav('scratch/play_sound_trimmed.wav', 200)
quit_bytes = convert_wav('scratch/quit_sound_trimmed.wav', 175)

with open('src/sfx/sfx_data.c', 'w') as f:
    f.write('#pragma bank 220\n')
    f.write('#include <gb/gb.h>\n')
    f.write('#include "sfx_data.h"\n\n')
    f.write(f'const uint8_t play_sound_data[{len(play_bytes)}] = {{\n')
    for i in range(0, len(play_bytes), 16):
        chunk = play_bytes[i:i+16]
        f.write('    ' + ', '.join(f'0x{b:02X}' for b in chunk) + ',\n')
    f.write('};\n\n')
    f.write(f'const uint8_t quit_sound_data[{len(quit_bytes)}] = {{\n')
    for i in range(0, len(quit_bytes), 16):
        chunk = quit_bytes[i:i+16]
        f.write('    ' + ', '.join(f'0x{b:02X}' for b in chunk) + ',\n')
    f.write('};\n')

with open('include/sfx_data.h', 'w') as f:
    f.write('#ifndef SFX_DATA_H\n#define SFX_DATA_H\n\n')
    f.write('#include <gb/gb.h>\n\n')
    f.write('#define BANK_SFX_DATA 220\n\n')
    f.write(f'#define PLAY_SOUND_LEN {len(play_bytes)}\n')
    f.write(f'extern const uint8_t play_sound_data[{len(play_bytes)}];\n\n')
    f.write(f'#define QUIT_SOUND_LEN {len(quit_bytes)}\n')
    f.write(f'extern const uint8_t quit_sound_data[{len(quit_bytes)}];\n\n')
    f.write('#endif\n')

print('Generated successfully!')
