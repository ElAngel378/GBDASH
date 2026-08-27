#pragma bank 20
#include <gb/gb.h>
#include <gbdk/incbin.h>

BANKREF(chr_gb)

INCBIN(chr_gb_tiles, "levels/chr_data/chr_gb_dmg_tiles.bin")
INCBIN(chr_gb_tiles_rev, "levels/chr_data/chr_gb_dmg_flipped_tiles.bin")

// The DMG build compacts/reindexes the source CHR so background tiles coexist
// with sprites in VRAM. CGB must use this exact index-compatible layout too;
// it receives colour solely from its per-metatile palette attributes.
INCBIN(chr_gb_cgb_tiles, "levels/chr_data/chr_gb_dmg_tiles.bin")
INCBIN(chr_gb_cgb_tiles_rev, "levels/chr_data/chr_gb_dmg_flipped_tiles.bin")
