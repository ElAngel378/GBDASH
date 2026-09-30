#pragma bank 11

#include <gb/gb.h>
#include <gb/cgb.h>
#include <gbdk/incbin.h>
#include "famidash_sprites.h"

INCBIN(famidash_sprites_tiles, "levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin")
INCBIN_EXTERN(famidash_sprites_tiles)

INCBIN(famidash_deco_tiles, "levels/chr_data/famidash/famidash_deco_cgb_tiles.bin")
INCBIN_EXTERN(famidash_deco_tiles)

// Same decorations with Famidash's DECOCLOUD look (ground "spikes" are round bushes)
INCBIN(famidash_deco_cloud_tiles, "levels/chr_data/famidash/famidash_deco_cloud_cgb_tiles.bin")
INCBIN_EXTERN(famidash_deco_cloud_tiles)

// 1.4 objects (tools/make_mini_tiles.py)
INCBIN(mini_player_tiles, "levels/chr_data/famidash/mini_player_tiles.bin")
INCBIN_EXTERN(mini_player_tiles)
INCBIN(mini_portal_tiles, "levels/chr_data/famidash/mini_portal_tiles.bin")
INCBIN_EXTERN(mini_portal_tiles)
INCBIN(coin_tiles, "levels/chr_data/famidash/coin_tiles.bin")
INCBIN_EXTERN(coin_tiles)

void load_famidash_sprite_tiles(uint8_t deco_cloud) BANKED {
    set_sprite_data(MINI_PLAYER_TILE_BASE, 10, mini_player_tiles);
    set_sprite_data(MINI_PORTAL_TILE_A, 2, mini_portal_tiles);
    set_sprite_data(MINI_PORTAL_TILE_B, 8, mini_portal_tiles + 2 * 16);
    set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_SPRITE_TILE_COUNT, famidash_sprites_tiles);
    if (_cpu == CGB_TYPE) {
        VBK_REG = 1;
        set_sprite_data(FAMIDASH_SPRITE_TILE_BASE, FAMIDASH_DECO_TILE_COUNT,
                        deco_cloud ? famidash_deco_cloud_tiles : famidash_deco_tiles);
        set_sprite_data(COIN_TILE_BASE, 16, coin_tiles);
        VBK_REG = 0;
    }
}
