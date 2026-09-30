#pragma bank 10

#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <stdio.h>

#include "gameplay.h"
#include "player.h"
#include "assets.h"
#include "icon1.h"
#include "ship1.h"
#include "ball.h"
#include "famidash_sprites.h"
#include "famidash_bg.h"
#include "gbc_palettes.h"
#include "../levels/chr_data/chr_gb.h"

#define DEBUG_MODE
#include "famidash_metatiles.h"
#include "hUGEDriver.h"
#include "sample_player.h"
#include "sfx_data.h"
#include "level_complete_sfx.h"
#include "fade.h"
#include "death_effect.h"
#include "save_manager.h"
#include "sp_draw.h"
#include "pause_buttons.h"
#include "debug_mode.h"
#include "bg_parallax.h"
#include "collision.h"
#include "settings.h"

extern const uint8_t chr_gb_cgb_tiles[];
extern const uint8_t chr_gb_cgb_tiles_rev[];

#define BKG_MT_W 16

// Famidash chooses the decoration art per level: only Xstep (index 9) uses DECOCLOUD
// (ground "spikes" drawn as round bushes); every other level uses DECO1.
#define LEVEL_XSTEP 9
#define LEVEL_CLUTTERFUNK 11
#define LEVEL_DECO_CLOUD(idx) ((idx) == LEVEL_XSTEP || (idx) == LEVEL_CLUTTERFUNK)
// ... and spike set B (background spikes drawn as round bushes, see mt_renderer.c)
#define LEVEL_SPIKES_B(idx) ((idx) == LEVEL_XSTEP)
// Famidash spike/block CHR sets of the level (see apply_level_tile_patch)
#define LEVEL_TILE_FLAGS(idx) (((idx) == LEVEL_XSTEP) ? LEVEL_TILES_SPIKES_B : \
                               ((idx) == LEVEL_CLUTTERFUNK) ? LEVEL_TILES_BLOCKS_B : 0)
#define BKG_MT_H 16
#define VIEW_MT_W 10
#define VIEW_MT_H 9

// Level end animation timings
#define LEVEL_END_SHAKE_FRAMES 120  // Screen shake duration (2s at 60fps)
#define LEVEL_END_PULL_FRAMES   72  // Magnetic pull towards end trigger (~1.2s)
#define LEVEL_END_OVERSHOOT_PX  14  // Y overshoot amplitude in pixels

// Precomputed reverse-easing (quadratic ease-in: 256 * (t/72)^2)
static const uint16_t level_end_ease_in[73] = {
      0,   0,   0,   0,   1,   1,   2,   2,   3,   4,
      5,   6,   7,   8,  10,  11,  13,  14,  16,  18,
     20,  22,  24,  26,  28,  31,  33,  36,  39,  42,
     44,  47,  51,  54,  57,  60,  64,  68,  71,  75,
     79,  83,  87,  91,  96, 100, 104, 109, 114, 119,
    123, 128, 134, 139, 144, 149, 155, 160, 166, 172,
    178, 184, 190, 196, 202, 209, 215, 222, 228, 235,
    242, 249, 256
};

// Precomputed Y overshoot arc (parabola: 255 * 4 * (t/72) * (1 - t/72))
static const uint8_t level_end_arc[73] = {
      0,  14,  28,  41,  54,  66,  78,  90, 101, 112,
    122, 132, 142, 151, 160, 168, 176, 184, 191, 198,
    205, 211, 216, 222, 227, 231, 235, 239, 242, 245,
    248, 250, 252, 253, 254, 255, 255, 255, 254, 253,
    252, 250, 248, 245, 242, 239, 235, 231, 227, 222,
    216, 211, 205, 198, 191, 184, 176, 168, 160, 151,
    142, 132, 122, 112, 101,  90,  78,  66,  54,  41,
     28,  14,   0
};

// End-animation state — non-static so sp_draw.c can reference them via gameplay.h externs
uint8_t  end_anim_state;
uint8_t  end_anim_frame;
uint8_t  end_shake_timer;
uint8_t  end_trigger_requested;
uint16_t end_trigger_obj_x;
uint16_t end_trigger_obj_y;

static uint16_t locked_scroll_px;
static uint16_t locked_cam_py;
static int16_t end_start_x;
static int16_t end_start_y;
static int16_t end_target_x;
static int16_t end_target_y;
static uint8_t last_bg_phase = 0xFF;
static uint8_t bg_drift_px = 0;

// Scroll speed in 8.8 fixed point (pixels per frame)
// Example: 3.0 = 768, 3.5 = 896, 4.0 = 1024
// 714 = 708 x 714/708 = famidash 60fps speed corrected for the Game Boy's
// ~59.7fps refresh. Must match the physics rescale factor in include/player.h
// so vertical trajectories stay aligned with scroll (see "Better ship").
#define SCROLL_SPEED_FP 714

#define CAM_Y_TOP_ZONE 20
#define CAM_Y_BOTTOM_ZONE 100

// Index (0-3) of the default theme in bg_pals:
// bottom row (light), column 0 (gray). This is used at level start and after death.
extern uint8_t music_ready;

SpCache active_sp;
uint8_t collision_columns[32];

static const Level* l;
static const uint8_t* level_tiles;
static const uint8_t* level_map;
static uint16_t level_tile_count;
static uint16_t level_map_w;
static uint16_t level_map_h;
static uint8_t level_tiles_bank;
static uint8_t level_map_bank;

static uint16_t cam_px;
static uint16_t cam_py;
static uint16_t cam_py_max;
static uint16_t loaded_r;

// A newly streamed map column is built and uploaded in COL_JOB_STEPS slices, one
// per frame (4 metatile rows built before VBlank, the matching 8 tile rows
// uploaded after it), so no single frame has to pay for a whole column. The
// column is written >= 6 frames before it can scroll into view.
#define COL_JOB_STEPS 4
// Ground <-> level-tile switch of the top two tile rows (see below), also spread
// over frames: ROW0_JOB_PER_FRAME ring positions per frame.
#define ROW0_JOB_PER_FRAME 4
static uint8_t row0_job_pos = 16; // == 16: idle
static uint8_t col_job_step = COL_JOB_STEPS; // == COL_JOB_STEPS: idle
static uint8_t col_job_slot;
static uint8_t col_job_issued;  // slice handed to the VBlank handler, not yet acknowledged
static uint8_t row0_job_issued;
static uint16_t col_job_col;
static uint16_t max_scroll_px;

static uint16_t scroll_acc;
static uint8_t prev_joy;
static uint8_t previous_oam_index;
static uint16_t sp_stream_idx;
static uint16_t sp_cache_col;
static uint8_t sp_fill_pending;
static uint16_t cached_collision_col;
static uint8_t prev_reversed;
static uint8_t reduce_flash;
static uint8_t pause_suppress_jump;
#if ENABLE_DEBUG_MODE
static uint8_t debug_ly;      // scanline the game logic had finished at (last frame)
static uint8_t debug_max_ly;  // worst one since debug mode was switched on
#endif
static uint8_t target_bg_idx;
static uint8_t died;
static int16_t py;
static Player player;

static const uint8_t bg_pals[] = {
    0xE4, // 0: Normal (W:W, LG:LG, DG:DG, B:B)
    0x39, // 1: Inverse (W:LG, LG:DG, DG:B, B:W)
    0x3E, // 2: Inverse (W:DG, LG:B, DG:B, B:W)
    0x3F  // 3: Inverse (W:B, LG:B, DG:B, B:W)
};

// Shared blank tile for SHOW BG off (solid areas instead of BG art).
// Lives in this bank (10), NOT in HOME/bank 0 which is 98% full.
static const uint8_t blank_bg_tile[16] = {0};

// Blank CGB parallax VRAM (Bank 1 tiles 0..47) so parallax areas render
// as solid sky color. Must be called with DISPLAY OFF. Bank-10 local so
// HOME stays untouched.
static void blank_parallax_vram(void) {
    if (_cpu != CGB_TYPE) return;
    VBK_REG = 1;
    for (uint8_t i = 0; i < 48; i++) {
        set_bkg_data(i, 1, blank_bg_tile);
    }
    VBK_REG = 0;
}

static void reload_level_state(uint8_t idx) {
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
    disable_interrupts();
    DISPLAY_OFF;

    // Reload tileset and sprite data on respawn/restart
    load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
    apply_level_tile_patch(idx, LEVEL_TILE_FLAGS(idx), 0);
    if (!setting_show_bg_enabled) {
        // Hide BG: blank DMG tile 12 so empty areas are solid
        set_bkg_data(12, 1, blank_bg_tile);
    }

    set_sprite_data(0, 8, icon1_tiles);
    set_sprite_data(8, 4, ship_tiles);
    set_sprite_data(12, 8, ball_tiles);
    init_death_effect_tiles();
    init_pause_tiles();
    debug_load_hud_tiles();
    load_famidash_sprite_tiles(LEVEL_DECO_CLOUD(idx));
    bg_drift_px = 0;
    if (_cpu == CGB_TYPE) {
        if (setting_show_bg_enabled) init_bg_parallax();
        else blank_parallax_vram();
        last_bg_phase = 0;
        load_menu_ground_tiles();
        vram_row0_is_ground = 1;
        cam_py = 128;
    } else {
        cam_py = 112;
    }

    cam_px = 0;
    scroll_acc = 0;
    loaded_r = BKG_MT_W - 1;
    col_job_step = COL_JOB_STEPS;
    row0_job_pos = 16;
    col_job_issued = row0_job_issued = 0; bg_cj_pending = bg_rj_pending = 0;
    target_bg_idx = 0;
    pause_suppress_jump = 0;
    end_anim_state = END_ANIM_INACTIVE;
    end_anim_frame = 0;
    end_shake_timer = 0;
    end_trigger_requested = 0;
    player_init(&player, 0, 240);
    sp_cache_reset(&active_sp, &sp_stream_idx);
    coins_reset();
    coins_saved = level_coins[idx];
    sp_cache_col = 0xFFFF;
    sp_fill_pending = 0;
    previous_oam_index = MAX_HARDWARE_SPRITES;
    cached_collision_col = 0xFFFF;
    move_bkg(0, (uint8_t)cam_py);
    BGP_REG = bg_pals[0];
    if (_cpu == CGB_TYPE) {
        famidash_reset_bg_palettes(idx);
    }
    fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);
    DISPLAY_ON;
    if (level_songs[idx] && setting_music_enabled) {
        init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
        current_song_bank = song_bank[idx];
        TAC_REG = 0x04;
        music_ready = 1;
    }
    enable_interrupts();
}

// ---- play_level helpers: the rarely-run parts of the main loop (pause, level
// complete, mirror portal, death, level end). Out of play_level because SDCC's
// register allocator (--max-allocs-per-node50000) is very slow on one huge
// function. Per-frame code stays inline in play_level: moving it into helpers
// cost frames on DMG.

// Pause menu (Start). Returns 1 when the player chose to leave the level.
static uint8_t pause_menu(uint8_t idx) {
    wait_vbl_done();

    // Pause music and mute active sound
    uint8_t saved_music_ready = music_ready;
    music_ready = 0;
    TAC_REG = 0x00; // Stop hardware timer to prevent music drift/desync
    NR12_REG = 0; NR14_REG = 0x80;
    NR22_REG = 0; NR24_REG = 0x80;
    NR30_REG = 0;
    NR42_REG = 0; NR44_REG = 0x80;

    // Tint screen 1 gradient step down
    uint8_t saved_bgp = BGP_REG;
    uint8_t saved_obp0 = OBP0_REG;
    uint8_t saved_obp1 = OBP1_REG;

    uint8_t saved_scx = SCX_REG;
    uint8_t saved_scy = SCY_REG;
    uint8_t fine_scx = saved_scx & 7;
    uint8_t fine_scy = saved_scy & 7;

    // Grid-lock background
    wait_vbl_done();
    move_bkg((uint8_t)(saved_scx - fine_scx), (uint8_t)(saved_scy - fine_scy));

    if (_cpu == CGB_TYPE) {
        fade_apply_pause_box_palettes();
        apply_pause_box_attributes(1);
        static const palette_color_t pause_pal[4] = {
            RGB8(0, 0, 0), RGB8(0, 0, 0), RGB8(180, 215, 255), RGB8(255, 255, 255)
        };
        set_sprite_palette(7, 1, pause_pal);

        // Play Button: Vibrant golden yellow icon & rim, rich 2-tone green body
        static const palette_color_t play_btn_pal[4] = {
            RGB8(0, 0, 0), RGB8(255, 235, 20), RGB8(80, 210, 20), RGB8(15, 110, 10)
        };
        set_sprite_palette(6, 1, play_btn_pal);

        // Menu & Restart Buttons: Electric cyan icon & rim, rich 2-tone green body
        static const palette_color_t misc_btn_pal[4] = {
            RGB8(0, 0, 0), RGB8(30, 245, 255), RGB8(80, 210, 20), RGB8(15, 110, 10)
        };
        set_sprite_palette(5, 1, misc_btn_pal);
    } else {
        BGP_REG = dim_dmg_byte(saved_bgp, 1);
        OBP0_REG = 0x90;
        OBP1_REG = 0x1C;
    }

    // Hide all gameplay and level sprites during pause (slots 27..39)
    for (uint8_t i = 27; i < 40; i++) {
        shadow_OAM[i].y = 0;
    }

    uint8_t selected_btn = PAUSE_BTN_PLAY;
    draw_pause_menu_sprites(selected_btn);
#if ENABLE_DEBUG_MODE
    if (debug_mode) debug_draw_hud(0, 0, 0);
#endif
    wait_vbl_done();

    uint8_t exit_level = 0;
    uint8_t restart_level = 0;
    while (joypad() & (J_START | J_SELECT | J_A | J_B)) wait_vbl_done();

    uint8_t p_prev_joy = 0;
    while (1) {
        wait_vbl_done();
        uint8_t p_joy = joypad();
        uint8_t p_pressed = p_joy & ~p_prev_joy;
        p_prev_joy = p_joy;

        if (p_pressed & J_LEFT) {
            if (selected_btn == 0) selected_btn = 2;
            else selected_btn--;
            draw_pause_menu_sprites(selected_btn);
        } else if (p_pressed & J_RIGHT) {
            if (selected_btn >= 2) selected_btn = 0;
            else selected_btn++;
            draw_pause_menu_sprites(selected_btn);
#if ENABLE_DEBUG_MODE
        } else if (p_pressed & J_B) {
            // B toggles debug mode (noclip + scanline readout); START resumes
            debug_mode ^= 1;
            debug_max_ly = 0;
            if (debug_mode) debug_draw_hud(0, 0, 0);
            else debug_hide_hud();
        } else if (p_pressed & J_START) {
            break;
#else
        } else if ((p_pressed & J_START) || (p_pressed & J_B)) {
            break;
#endif
        } else if (p_pressed & J_A) {
            if (selected_btn == PAUSE_BTN_PLAY) {
                break;
            } else if (selected_btn == PAUSE_BTN_MENU) {
                exit_level = 1;
                break;
            } else if (selected_btn == PAUSE_BTN_RESTART) {
                restart_level = 1;
                break;
            }
        }
    }

    // Hide all pause menu UI sprites immediately
    for (uint8_t i = 0; i < 27; i++) {
        shadow_OAM[i].y = 0;
    }

    if (_cpu == CGB_TYPE) {
        wait_vbl_done();
        apply_pause_box_attributes(0);
        fade_restore_pause_box_palettes();
        set_sprite_palette(0, 8, gbc_sprite_palettes);
        if (vram_row0_is_ground) {
            flush_vram_row0(1);
        }
    } else {
        BGP_REG = saved_bgp;
        OBP0_REG = saved_obp0;
        OBP1_REG = saved_obp1;
    }

    // Restore fractional background scroll
    move_bkg(saved_scx, saved_scy);

    if (exit_level) {
        return 1;
    }

    if (restart_level) {
        reload_level_state(idx);
        prev_joy = joypad();
        if (prev_joy & J_UP) prev_joy |= J_A;
        player.last_joy = prev_joy;
        return 0;
    }

    NR30_REG = 0x80;
    hUGE_reset_wave();

    wait_vbl_done();

    // Synchronize music timer on VBLANK to prevent desync
    TIMA_REG = TMA_REG;
    IF_REG &= ~TIM_IFLAG;
    cgb_music_tick = 0;
    TAC_REG = 0x04;
    music_ready = saved_music_ready;

    prev_joy = joypad();
    if (prev_joy & J_UP) prev_joy |= J_A;
    player.last_joy = prev_joy;
    pause_suppress_jump = 1;
    return 0;
}

static void level_complete_screen(uint8_t idx) {
    record_level_progress(idx, 100, 0);
    record_level_coins(idx, coins_collected);
    HIDE_SPRITES;
    move_bkg(0, 0);
    disable_interrupts();
    setup_menu_font();
    enable_interrupts();
    VBK_REG = 1;
    fill_bkg_rect(0, 0, 32, 32, 0x00);
    VBK_REG = 0;
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    draw_text(3, 6, "LEVEL COMPLETE");
    draw_text(3, 12, "PRESS A TO EXIT");
    waitpadup();
    while (!(joypad() & J_A)) wait_vbl_done();
}

// The level end object was reached: start the pull-to-the-edge animation
static void start_end_anim(void) {
    end_anim_state = END_ANIM_PULL;
    end_anim_frame = 0;
    locked_scroll_px = player.reversed
        ? (uint16_t)(-(int16_t)cam_px - MIRROR_PLAYER_SCREEN_X)
        : ((cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0);
    locked_cam_py = cam_py;
    end_start_x = player.reversed ? MIRROR_PLAYER_SCREEN_X : ((cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X);
    end_start_y = (int16_t)player.world_y.b.h - (int16_t)cam_py;

    if (!player.reversed) {
        end_target_x = 168; // Exit off the right edge of the screen before disappearing
    } else {
        end_target_x = (int16_t)-16; // Exit off the left edge of the screen in mirror mode
    }
    int16_t ty = (int16_t)end_trigger_obj_y - (int16_t)locked_cam_py;
    if (ty < 32) ty = 40;
    if (ty > 112) ty = 80;
    end_target_y = ty;
    end_trigger_requested = 0;
}

// Mirror portal: reload the (mirrored) tileset and redraw the visible columns
static void mirror_reload(uint8_t idx) {
    col_job_step = COL_JOB_STEPS;
    row0_job_pos = 16;
    col_job_issued = row0_job_issued = 0; bg_cj_pending = bg_rj_pending = 0;
    bg_cj_pending = bg_rj_pending = 0;
    DISPLAY_OFF;

    const uint8_t* target_tiles = player.reversed
        ? ((_cpu == CGB_TYPE) ? chr_gb_cgb_tiles_rev : l->tiles_rev)
        : level_tiles;
    load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
    apply_level_tile_patch(idx, LEVEL_TILE_FLAGS(idx), player.reversed);
    if (!setting_show_bg_enabled) {
        set_bkg_data(12, 1, blank_bg_tile);
    }

    int32_t col_start = (int32_t)(cam_px >> 4) - 4;
    if (col_start < 0) col_start = 0;
    for (uint8_t i = 0; i < 16; i++) {
        uint16_t curr_col = (uint16_t)(col_start + i);
        if (curr_col < level_map_w) {
            uint8_t vram_slot = (uint8_t)(curr_col & 15);
            if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
            prepare_mt_column(curr_col, level_map, level_map_bank, player.reversed);
            flush_mt_column(vram_slot);
        }
    }

    set_sprite_data(0, 8, icon1_tiles);
    set_sprite_data(8, 4, ship_tiles);
    set_sprite_data(12, 8, ball_tiles);
    init_pause_tiles();
    debug_load_hud_tiles();
    load_famidash_sprite_tiles(LEVEL_DECO_CLOUD(idx));

    uint16_t init_scroll_px = player.reversed
        ? (uint16_t)(-(int16_t)cam_px - MIRROR_PLAYER_SCREEN_X)
        : ((cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0);
    move_bkg((uint8_t)init_scroll_px, (uint8_t)cam_py);

    SHOW_BKG;
    SHOW_SPRITES;
    SPRITES_8x16;
    DISPLAY_ON;

    loaded_r = (uint16_t)(col_start + 15);
    prev_reversed = player.reversed;
}

static void handle_death(uint8_t idx, uint8_t sprite_x_final, int16_t final_py, uint16_t scroll_px) {
    record_level_progress_from_cam(idx, cam_px, max_scroll_px);
    if (setting_effects_enabled) {
        play_death_animation(sprite_x_final, (uint8_t)final_py, (uint8_t)scroll_px, (uint8_t)cam_py);
    } else {
        if (setting_sfx_enabled) {
            NR41_REG = 0x00;
            NR42_REG = 0xF2;
            NR43_REG = 0x43;
            NR44_REG = 0x80;
        }
        for (uint8_t i = 0; i < 40; i++) shadow_OAM[i].y = 0;
        move_bkg((uint8_t)scroll_px, (uint8_t)cam_py);
        wait_vbl_done();
    }
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;
    reload_level_state(idx);
}

void play_level(uint8_t idx) BANKED {
    l = game_levels[idx];
    level_tiles = l->tiles;
    level_map = l->map;
    level_tile_count = l->tile_count;
    level_map_w = l->map_width;
    level_map_h = l->map_height;
    level_tiles_bank = BANK(chr_gb);
    level_map_bank = l->map_bank;
    if (_cpu == CGB_TYPE) level_tiles = chr_gb_cgb_tiles;

    cam_px = 0;
    if (_cpu == CGB_TYPE) {
        cam_py = 128;
        cam_py_max = (level_map_h << 4) - 128u;
    } else {
        cam_py = 112;
        cam_py_max = (level_map_h << 4);
        if (cam_py_max > 144u) cam_py_max -= 144u;
        else cam_py_max = 0;
    }
    loaded_r = BKG_MT_W - 1;
    col_job_step = COL_JOB_STEPS;
    row0_job_pos = 16;
    col_job_issued = row0_job_issued = 0; bg_cj_pending = bg_rj_pending = 0;
    max_scroll_px = ((level_map_w - VIEW_MT_W) << 4);

    target_bg_idx = 0;
    player_init(&player, 0, 240);

    DISPLAY_OFF;
    load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
    apply_level_tile_patch(idx, LEVEL_TILE_FLAGS(idx), 0);
    if (!setting_show_bg_enabled) {
        set_bkg_data(12, 1, blank_bg_tile);
    }
    set_sprite_data(0, 8, icon1_tiles);
    set_sprite_data(8, 4, ship_tiles);
    set_sprite_data(12, 8, ball_tiles);
    init_death_effect_tiles();
    init_pause_tiles();
    debug_load_hud_tiles();
    load_famidash_sprite_tiles(LEVEL_DECO_CLOUD(idx));
    bg_drift_px = 0;
    if (_cpu == CGB_TYPE) {
        if (setting_show_bg_enabled) init_bg_parallax();
        else blank_parallax_vram();
        last_bg_phase = 0;
        load_menu_ground_tiles();
        vram_row0_is_ground = 1;
        famidash_reset_bg_palettes(idx);
        fade_set_sprite_palette(0, 8, gbc_sprite_palettes);
    }
    move_bkg(0, (uint8_t)cam_py);
    fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);

    fade_set_dmg_palettes(bg_pals[0], bg_pals[0], bg_pals[0]);
    fade_set_black();

    SPRITES_8x16;
    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;
    enable_interrupts();

    // Wait for the entry sound effect to finish (hiding load time behind SFX)
    while (is_sample_playing()) wait_vbl_done();
    stop_sample();

    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    fade_from_black(2);

    if (level_songs[idx] && setting_music_enabled) {
        init_music_banked(level_songs[idx], song_bank[idx], l->timer_divider);
        current_song_bank = song_bank[idx];
        TAC_REG = 0x04;
        music_ready = 1;
    }

    scroll_acc = 0;
    prev_joy = 0;
    previous_oam_index = MAX_HARDWARE_SPRITES;
    sp_stream_idx = 0;
    sp_cache_col = 0xFFFF;
    sp_fill_pending = 0;
    cached_collision_col = 0xFFFF;
    prev_reversed = player.reversed;
    reduce_flash = setting_dmg_gradient ? 0 : 1;
    pause_suppress_jump = 0;
    end_anim_state = END_ANIM_INACTIVE;
    end_anim_frame = 0;
    end_shake_timer = 0;
    end_trigger_requested = 0;
    sp_cache_reset(&active_sp, &sp_stream_idx);
    coins_reset();
    coins_saved = level_coins[idx];
    bg_parallax_isr_start();
    while (1) {
        uint8_t joy = joypad();
        if (joy & J_UP) joy |= J_A;

        if (pause_suppress_jump) {
            if (!(joy & J_A)) {
                pause_suppress_jump = 0;
            } else {
                joy &= ~J_A;
            }
        }

        // Pause game on Start press
        if (!player.dead && end_anim_state == END_ANIM_INACTIVE && (joy & J_START) && !(prev_joy & J_START)) {
            if (pause_menu(idx)) break;
            continue;
        }

        if (player.level_complete) {
            level_complete_screen(idx);
            break;
        }

        if ((joy & J_SELECT) && !(prev_joy & J_SELECT)) {
            reduce_flash = !reduce_flash;
            setting_dmg_gradient = !reduce_flash;
            save_game_data();
        }
        prev_joy = joy;

        uint16_t px_prev = cam_px >> 4;
        uint8_t needs_render = 0;
        uint16_t need_col = 0;
        uint16_t px_curr = px_prev;

        if (end_anim_state == END_ANIM_INACTIVE && cam_px < max_scroll_px) {
            bg_drift_px++;
            scroll_acc += SCROLL_SPEED_FP;
            cam_px += scroll_acc >> 8;
            scroll_acc &= 0xFF;
            px_curr = cam_px >> 4;
            if (px_curr != px_prev) {
                uint16_t need = px_curr + VIEW_MT_W;
                if (need > loaded_r && need < level_map_w) {
                    needs_render = 1;
                    need_col = need;
                }
            }
        }

        player.world_x = cam_px;
        uint16_t sp_col = (cam_px + 8u) >> 4;
        // Object cache: retire behind the camera, then load ahead on the next frame
        // (never both in one frame; at level start / respawn both at once)
        if (sp_fill_pending) {
            sp_cache_fill(l, cam_px, &sp_stream_idx);
            sp_fill_pending = 0;
        } else if (sp_col != sp_cache_col) {
            sp_cache_retire(cam_px);
            if (sp_cache_col == 0xFFFF) sp_cache_fill(l, cam_px, &sp_stream_idx);
            else sp_fill_pending = 1;
            sp_cache_col = sp_col;
        }

        process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);

        if (end_trigger_requested && end_anim_state == END_ANIM_INACTIVE) start_end_anim();

        if (player.reversed != prev_reversed) mirror_reload(idx);

        if (px_curr != cached_collision_col) {
            load_collision_columns(px_curr, level_map, level_map_w,
                                   level_map_bank, collision_columns);
            cached_collision_col = px_curr;
        }

        if (end_anim_state == END_ANIM_INACTIVE) {
            died = player_update(&player, joy, collision_columns, level_map_h);
#if ENABLE_DEBUG_MODE
            if (debug_mode) { died = 0; player.dead = 0; } // noclip: hazards and walls can't kill
#endif
        } else {
            died = 0;
        }

        if (end_anim_state == END_ANIM_INACTIVE) {
            if (!died) {
                py = (int16_t)player.world_y.b.h - (int16_t)cam_py;
                if (py < CAM_Y_TOP_ZONE) {
                    int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_TOP_ZONE;
                    if (target_cam_py < 0) target_cam_py = 0;
                    if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
                    cam_py = (uint16_t)target_cam_py;
                }
                else if (py > CAM_Y_BOTTOM_ZONE) {
                    int16_t target_cam_py = (int16_t)player.world_y.b.h - CAM_Y_BOTTOM_ZONE;
                    if (target_cam_py < 0) target_cam_py = 0;
                    if ((uint16_t)target_cam_py > cam_py_max) target_cam_py = (int16_t)cam_py_max;
                    cam_py = (uint16_t)target_cam_py;
                }
            }
        } else {
            cam_py = locked_cam_py;
        }

        uint16_t scroll_px;
        uint8_t sprite_x_final;
        int16_t final_py;

        if (end_anim_state == END_ANIM_INACTIVE) {
            if (player.reversed) {
                // Mirror Mode: SCX decreases as progress advances
                scroll_px = (uint16_t)(-(int16_t)cam_px - MIRROR_PLAYER_SCREEN_X);
                sprite_x_final = MIRROR_PLAYER_SCREEN_X; // Mirrored player position (112)
            } else {
                scroll_px = (cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0;
                sprite_x_final = (cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X;
            }
            final_py = (int16_t)player.world_y.b.h - (int16_t)cam_py;
            if (final_py < 0) final_py = 0;
            else if (final_py > 144) final_py = 144;
        } else if (end_anim_state == END_ANIM_PULL) {
            scroll_px = locked_scroll_px;
            end_anim_frame++;
            if (end_anim_frame > LEVEL_END_PULL_FRAMES) end_anim_frame = LEVEL_END_PULL_FRAMES;

            int16_t dx = end_target_x - end_start_x;
            int16_t dy = end_target_y - end_start_y;
            uint16_t factor = level_end_ease_in[end_anim_frame];
            uint8_t arc = level_end_arc[end_anim_frame];

            int16_t cur_x = end_start_x + (int16_t)(((int32_t)dx * factor) >> 8);
            int16_t cur_y = end_start_y + (int16_t)(((int32_t)dy * factor) >> 8) - (int16_t)(((int16_t)LEVEL_END_OVERSHOOT_PX * arc) >> 8);
            if (cur_y < 8) cur_y = 8;
            sprite_x_final = (uint8_t)cur_x;
            final_py = cur_y;
            player.anim_timer += 10;
            if (player.anim_timer >= 21) {
                player.anim_timer -= 21;
                if (player.reversed) {
                    if (player.anim_frame == 0) player.anim_frame = 23;
                    else player.anim_frame--;
                } else {
                    player.anim_frame++;
                    if (player.anim_frame >= 24) player.anim_frame = 0;
                }
            }

            if (end_anim_frame >= LEVEL_END_PULL_FRAMES) {
                end_anim_state = END_ANIM_SHAKE;
                end_shake_timer = LEVEL_END_SHAKE_FRAMES;
                play_sample_with_music(BANK_LEVEL_COMPLETE_SFX, level_complete_sfx_data, LEVEL_COMPLETE_SFX_LEN);
            }
        } else {
            // END_ANIM_SHAKE
            scroll_px = locked_scroll_px;
            sprite_x_final = 0;
            final_py = 0;
        }

        // Player sprite
        uint8_t oam_index = 0;

        if (end_anim_state != END_ANIM_SHAKE && player.mini) {
            // Mini size: one 8x16 sprite, image in its top half, drawn at box top - 1
            // like Famidash (x .. x+7, y+3 .. y+10). Cube: 3 rotation images + mirror.
            static const uint8_t mini_cube_img[6] = { 0, 1, 1, 2, 1, 0 };
            uint8_t tile, prop = 0;
            if (player.mode == MODE_SHIP) tile = MINI_PLAYER_TILE_BASE + 6;
            else if (player.mode == MODE_BALL) tile = MINI_PLAYER_TILE_BASE + 8;
            else {
                uint8_t q = (uint8_t)(player.anim_frame % 6u);
                tile = MINI_PLAYER_TILE_BASE + (uint8_t)(mini_cube_img[q] << 1);
                if (q == 4) prop ^= S_FLIPX;
            }
            uint8_t oy = (uint8_t)(final_py + 16 + 3);
            if (player.gravity_flipped) { prop ^= S_FLIPY; oy -= 8; }
            uint8_t ox = (uint8_t)(sprite_x_final + 8);
            if (player.reversed) { prop ^= S_FLIPX; ox += 8; }
            shadow_OAM[0].y = oy;
            shadow_OAM[0].x = ox;
            shadow_OAM[0].tile = tile;
            shadow_OAM[0].prop = prop;
            oam_index = 1;
        } else if (end_anim_state != END_ANIM_SHAKE) {
            if (player.mode == MODE_SHIP) {
                if (player.gravity_flipped) {
                    if (player.reversed) oam_index += move_metasprite_hvflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 24);
                    else oam_index += move_metasprite_hflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 32);
                } else {
                    if (player.reversed) oam_index += move_metasprite_vflip(ship_metasprites[0], 0, oam_index, sprite_x_final + 24, final_py + 16);
                    else oam_index += move_metasprite(ship_metasprites[0], 0, oam_index, sprite_x_final + 8, final_py + 16);
                }
            } else if (player.mode == MODE_BALL) {
                uint8_t ball_frame = (player.anim_frame >> 1) & 1;
                if (player.reversed) {
                    oam_index += move_metasprite_vflip(ball_metasprites[ball_frame], 12, oam_index, sprite_x_final + 24, final_py + 16);
                } else {
                    oam_index += move_metasprite(ball_metasprites[ball_frame], 12, oam_index, sprite_x_final + 8, final_py + 16);
                }
            } else {
                if (player.gravity_flipped) {
                    if (player.reversed) oam_index += move_metasprite_hvflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 32);
                    else oam_index += move_metasprite_hflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 32);
                } else {
                    if (player.reversed) oam_index += move_metasprite_vflip(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 24, final_py + 16);
                    else oam_index += move_metasprite(icon1_metasprites[player.anim_frame], 0, oam_index, sprite_x_final + 8, final_py + 16);
                }
            }
        }

        int8_t cur_shake_x = 0;
        int8_t cur_shake_y = 0;
        if (end_anim_state == END_ANIM_SHAKE) {
            if (end_shake_timer > 0) {
                end_shake_timer--;
                if (setting_effects_enabled) {
                    uint8_t r = DIV_REG;
                    cur_shake_x = (int8_t)((r % 5) - 2);
                    cur_shake_y = (int8_t)(((r >> 3) % 5) - 2);
                    if (cur_shake_x == 0 && cur_shake_y == 0) {
                        cur_shake_x = (r & 1) ? 1 : -1;
                    }
                }
            } else {
                player.level_complete = 1;
            }
        }

        // Level sprites
        oam_index = draw_sprites(
            &active_sp, (uint16_t)((int16_t)cam_px + cur_shake_x), (uint16_t)((int16_t)cam_py + cur_shake_y),
            player.reversed, oam_index
        );
        if (oam_index < previous_oam_index) {
            uint8_t *oam_ptr = (uint8_t *)&shadow_OAM[oam_index];
            while (oam_index < previous_oam_index) {
                *oam_ptr = 0;
                oam_ptr += 4;
                oam_index++;
            }
        }
        previous_oam_index = oam_index;
#if ENABLE_DEBUG_MODE
        if (debug_mode) debug_draw_hud(1, debug_ly, debug_max_ly);
#endif

        if (needs_render) {
            loaded_r = need_col;
            col_job_col = need_col;
            col_job_slot = (uint8_t)(need_col & 15);
            if (player.reversed) col_job_slot = (uint8_t)(-(int8_t)col_job_slot & 15);
            col_job_step = 0;
        }
        if (bg_gdma_isr_on) {
            // A slice the VBlank handler has uploaded counts as done.
            if (col_job_issued && !bg_cj_pending) { col_job_issued = 0; col_job_step++; }
        }
        if (col_job_step < COL_JOB_STEPS && !col_job_issued) {
            prepare_mt_column_slice(col_job_col, level_map, level_map_bank, player.reversed, col_job_step);
            if (bg_gdma_isr_on) { request_mt_column_slice(col_job_slot, col_job_step); col_job_issued = 1; }
        }

        uint8_t parallax_needed = 0;
        uint8_t bg_phase = 0;

        if (_cpu == CGB_TYPE) {
            uint8_t target_row0_ground = vram_row0_is_ground;
            // Tile rows 0-1 are only on screen when cam_py <= 15 (level top) or
            // cam_py >= 113 (ground, wrapped to the bottom). The thresholds sit
            // inside the gap with >= 25px (4 frames at the 6px/frame maximum
            // camera speed) of margin each way, and the switch itself takes 4
            // frames, so it is finished before the rows scroll into view.
            if (vram_row0_is_ground) {
                if (cam_py < 40) target_row0_ground = 0;
            } else {
                if (cam_py >= 88) target_row0_ground = 1;
            }
            if (target_row0_ground != vram_row0_is_ground) {
                vram_row0_is_ground = target_row0_ground;
                row0_job_pos = 0;
                row0_job_issued = 0;
                bg_rj_pending = 0;
            }

            if (setting_show_bg_enabled && setting_parallax_enabled) {
                bg_phase = player.reversed
                    ? (uint8_t)(scroll_px + bg_drift_px) & 63u
                    : (uint8_t)(scroll_px - bg_drift_px) & 63u;
                if (bg_phase != last_bg_phase) {
                    last_bg_phase = bg_phase;
                    // Full 60Hz update. The GDMA MUST run inside VBlank (before
                    // it, tile data changes mid-scanout and tears the parallax
                    // into "broken puzzle" pieces), which the VBlank ISR ensures.
                    parallax_needed = 1;
                }
            }
        }

        uint8_t apply_idx = target_bg_idx;
        if (reduce_flash && (apply_idx == 1 || apply_idx == 2)) {
            apply_idx = 0;
        }

        uint8_t final_bgp = bg_pals[apply_idx];
        uint8_t final_obp0, final_obp1;

        // Keep sprites visible on DMG during full-black flash
        if (_cpu != CGB_TYPE && apply_idx == 3) {
            final_obp0 = bg_pals[0];
            final_obp1 = bg_pals[0];
        } else {
            final_obp0 = final_bgp;
            final_obp1 = final_bgp;
        }

        uint8_t final_scx = (uint8_t)((int16_t)scroll_px + cur_shake_x);
        uint8_t final_scy = (uint8_t)((int16_t)cam_py + cur_shake_y);

        // The parallax GDMA (768 bytes, ~1.9k dots) is executed by the VBlank
        // interrupt itself the instant VBlank starts (see bg_parallax_phases.c),
        // so it never depends on how late this thread wakes up.
        if (bg_gdma_isr_on) {
            if (row0_job_issued && !bg_rj_pending) { row0_job_issued = 0; row0_job_pos += ROW0_JOB_PER_FRAME; }
            if (row0_job_pos < 16 && !row0_job_issued) {
                request_row0_slots(row0_job_pos, loaded_r, level_map, level_map_w, level_map_bank, player.reversed);
                row0_job_issued = 1;
            }
        }
        if (bg_gdma_isr_on && famidash_bkg_palettes_dirty) bg_pal_request = 1;
        if (parallax_needed) request_bg_parallax(bg_phase);
        // Same for the scroll registers (GBC only; DMG sets them below).
        if (bg_gdma_isr_on) request_bg_scroll(final_scx, final_scy);
#if ENABLE_DEBUG_MODE
        if (debug_mode) {
            debug_ly = LY_REG;
            if (debug_ly > debug_max_ly) debug_max_ly = debug_ly;
        }
#endif
        bg_wait_vbl();
        if (!bg_gdma_isr_on) move_bkg(final_scx, final_scy);

        BGP_REG = final_bgp;
        OBP0_REG = final_obp0;
        OBP1_REG = final_obp1;

        // Palette RAM is only writable in VBlank; if the main thread woke up
        // too late, leave the dirty flag set and apply on the next frame.
        if (!bg_gdma_isr_on && famidash_bkg_palettes_dirty && (uint8_t)(LY_REG - 144u) < 7u) {
            famidash_apply_palettes();
        }

        if (!bg_gdma_isr_on && row0_job_pos < 16) {
            flush_row0_slots(row0_job_pos, ROW0_JOB_PER_FRAME, loaded_r, level_map, level_map_w, level_map_bank, player.reversed);
            row0_job_pos += ROW0_JOB_PER_FRAME;
        }

        if (!bg_gdma_isr_on && col_job_step < COL_JOB_STEPS) {
            flush_mt_column_slice(col_job_slot, col_job_step);
            col_job_step++;
        }

        if (died) handle_death(idx, sprite_x_final, final_py, scroll_px);
    }

    bg_parallax_isr_stop();
    music_ready = 0;
    TAC_REG = 0x00;
    play_sample(BANK_SFX_DATA, quit_sound_data, QUIT_SOUND_LEN);
    fade_to_black(2);
    while (is_sample_playing()) wait_vbl_done();
    stop_sample();

    HIDE_SPRITES;
    move_bkg(0, 0);
    waitpadup();
    disable_interrupts();
    setup_menu_font();
    enable_interrupts();
    redraw = 1;
}
