#pragma bank 10

#include <gb/gb.h>
#include <gbdk/font.h>
#include <gbdk/console.h>
#include <stdio.h>
#include <string.h>

#include "gameplay.h"
#include "player.h"
#include "assets.h"
#include "icon1.h"
#include "ship1.h"
#include "ball.h"
#include "famidash_sprites.h"
#include "famidash_bg.h"
#include "gbc_palettes.h"
#include "bg_tiles.h"
BANKREF_EXTERN(chr_gb)   // base level tile sheet (src/graphics/tileset.c)

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
#include "percent_hud.h"
#include "bg_parallax.h"
#include "collision.h"
#include "settings.h"


#define BKG_MT_W 16

// Famidash chooses the decoration art per level: only Xstep (index 9) uses DECOCLOUD
// (ground "spikes" drawn as round bushes); every other level uses DECO1.
#define LEVEL_XSTEP 9
#define LEVEL_CLUTTERFUNK 11
#define LEVEL_DECO_CLOUD(idx) ((idx) == LEVEL_XSTEP || (idx) == LEVEL_CLUTTERFUNK)
// ... and spike set B (background spikes drawn as round bushes, see mt_renderer.c)
#define LEVEL_SPIKES_B(idx) ((idx) == LEVEL_XSTEP)
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

// Camera y. Cube: dead zone, the camera snaps to keep the player within screen rows
// CAM_Y_TOP_ZONE .. CAM_Y_BOTTOM_ZONE. Ship / ball: shows what the player is about to meet.
// The map columns from the player's to CAM_LOOK - 1 ahead give a window that must be on screen:
// below, the nearest obstacle under the player in every one of those columns; above, the
// nearest obstacle over its head within CAM_REACH_FLY rows (the corridor's ceiling) and CAM_HEAD
// px of headroom. The camera only moves when the screen stops covering that window, and eases
// there (1/3 of the distance per frame, 1..CAM_Y_MAX_STEP px). A window taller than the screen
// (a tall corridor): the player centred, but never past either end, so the nearer wall stays on
// screen. No ceiling in reach: locked to the mode portal like Famidash. The player never gets
// closer than CAM_Y_EDGE to a screen edge. The view is 144px on CGB too: its ground strip is the
// map row below the level and scrolls away when the camera goes up.
#define CAM_Y_TOP_ZONE 20      // cube: dead zone (screen rows the player may move in)
#define CAM_Y_BOTTOM_ZONE 100
#define CAM_LOOK 6
#define CAM_REACH_FLY 9
#define CAM_HEAD 24
#define CAM_FOOT 8
#define CAM_PAD 2             // obstacles: at least half of their tile + CAM_PAD on screen
#define CAM_Y_EDGE 12
#define CAM_Y_MAX_STEP 8      // the VRAM band streams one map row (16px) per 2 frames
#define CAM_VIEW_H 144
uint16_t cam_portal_y;
// Look-ahead tables of the columns c0 .. c0 + 7 (ring: column c in slot c & 7): cam_nb[slot * 32
// + r] = the first row >= r with something the player meets (collision type != COL_NONE; 32:
// none, the ground), cam_na[slot * 32 + r] = the last such row <= r (0xFF: none). A column is
// built ahead of the player in 5 steps (a column scrolls by every ~6 frames): 4 x 8 rows
// bottom-up (cam_nb), then cam_na; all at once after a (re)start.
#define CAM_RING 8u
static uint8_t cam_nb[CAM_RING * 32u], cam_na[CAM_RING * 32u];   // [slot * 32 + row]
static uint16_t cam_build_col;    // column being built, 0xFFFF: rebuild all
static uint8_t cam_build_step;
static uint8_t cam_build_left;    // build steps to do (5 per column the player moves)
static const uint8_t *cam_build_src;    // its map data (row 0) and ROM bank
static uint8_t cam_build_bank;
static uint16_t cam_win_col = 0xFFFF;   // cam_win_top / bot are for this column, row, mode, portal
static uint8_t cam_win_row, cam_win_fly;
static uint16_t cam_win_portal;
static uint16_t cam_win_top, cam_win_bot;   // px: must be on screen (top 0xFFFF: no limit)
static uint16_t cam_last_wy;      // cam_apply's input last time, and it did not move the camera
static uint8_t cam_still;

// Tall levels: maps are MAP_ROWS rows tall and bottom-aligned (a level made for 16 rows sits in
// rows MAP_ROWS-16 .. MAP_ROWS-1). World y is a 16-bit pixel position.
#define MAP_Y0 ((uint16_t)(MAP_ROWS - 16u) << 4)
// The player's physics stay 8.8 inside a 16-row collision window starting at player.y_base
// (world px, a multiple of 128). The window moves by 128px when the player gets within 48px of
// its top or bottom, so collision probes never leave it (physics code unchanged, same speed).
#define Y_BASE_MAX MAP_Y0
// The level's first row (rows above it are padding): the camera, the collision window and the
// VRAM band stay below it, and the player dies above it like at the top of a 16-row map before.
static uint16_t level_top_px;
#define PLAYER_WORLD_Y() ((uint16_t)(player.y_base + player.world_y.b.h))
// VRAM band (see mt_renderer.c): 16 rows around the (up to) 10 visible ones. It only moves when
// the screen comes within 2 rows of its edge, and then so that 3 rows are left on that side.
#define BAND_MAX ((_cpu == CGB_TYPE) ? (uint8_t)(GROUND_ROW - 15u) : (uint8_t)(MAP_ROWS - 16u))
static uint8_t band_for_cam(uint16_t cam_y, uint8_t band) {
    uint8_t vis_top = (uint8_t)(cam_y >> 4);
    uint8_t vis_bot = (uint8_t)((cam_y + 143u) >> 4);
    uint8_t band_min = (uint8_t)(level_top_px >> 4);
    if (band_min > BAND_MAX) band_min = BAND_MAX;
    if (vis_top < (uint8_t)(band + 2u)) {
        band = (vis_top > 3u) ? (uint8_t)(vis_top - 3u) : 0;
    } else if ((uint8_t)(vis_bot + 2u) > (uint8_t)(band + 15u)) {
        band = (uint8_t)(vis_bot - 12u);
    }
    if (band < band_min) band = band_min;
    if (band > BAND_MAX) band = BAND_MAX;
    return band;
}

// Index (0-3) of the default theme in bg_pals:
// bottom row (light), column 0 (gray). This is used at level start and after death.
extern uint8_t music_ready;

SpCache active_sp;
uint8_t collision_columns[32];

// Profiling build only (make PROFILE=1, see tools/profile.py): every section of the main loop
// writes its id here, and tools/mesen_profile.lua charges the CPU cycles to the sections.
#ifdef DEBUG_PROFILE
volatile uint8_t gpmark;
volatile uint16_t gpcamx;   // camera x, to say where in the level a frame was slow
volatile uint16_t gpcamy;   // camera y, player world y, mode | mini << 4 | gravity << 5 | dead << 7
volatile uint16_t gpplayy;  // (tools: camera / hitbox checks)
volatile uint8_t gpstate;
volatile uint8_t gpdeaths;  // deaths (in god mode: the ones that did not happen)
#define PROF_MARK(n) (gpmark = (n))
#else
#define PROF_MARK(n)
#endif

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
// Row job: the map row that just entered the VRAM band is written over 2 frames,
// ROW_JOB_PER_FRAME ring positions per frame (as fast as the camera can move vertically).
#define ROW_JOB_PER_FRAME BG_RJ_SLOTS
static uint8_t row0_job_pos = 16; // == 16: idle
static uint8_t row_job_row;       // map row being written
static uint8_t band_cam_row = 0xFF; // camera row the band was last checked against
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
#ifdef DEBUG_PROFILE
Player * volatile gpplayer = &player;   // tools: the bot reads the whole player state
#endif
static uint8_t practice_mode = 0;

static const uint8_t bg_pals[] = {
    0xE4, // 0: Normal (W:W, LG:LG, DG:DG, B:B)
    0x39, // 1: Inverse (W:LG, LG:DG, DG:B, B:W)
    0x3E, // 2: Inverse (W:DG, LG:B, DG:B, B:W)
    0x3F  // 3: Inverse (W:B, LG:B, DG:B, B:W)
};

// Sprite palette on a black DMG background (bg_pals[3]): shades 1 and 2 as normal, black -> white
#define DMG_OBP_ON_BLACK 0x24
// OBP1 (blue orbs, pads and gravity-down portals): OBP0 with shades 1 and 2 swapped. On the dark
// grey background (idx 2) OBP0 maps both to black, so OBP1 keeps shade 1 for the other look.
#define DMG_OBP1_ON_DARK 0x34
#define dmg_obp1(idx, p) ((uint8_t)((idx) == 2 ? DMG_OBP1_ON_DARK :     (((p) & 0xC3) | (((p) & 0x0C) << 2) | (((p) & 0x30) >> 2))))

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
    apply_level_bg_tiles(idx, 0);
    if (!setting_show_bg_enabled) {
        // Hide BG: blank DMG tile 12 so empty areas are solid
        set_bkg_data(12, 1, blank_bg_tile);
    }

    load_gameplay_sprite_tiles(LEVEL_DECO_CLOUD(idx));   // sprite_tiles.png
    if (practice_mode) load_checkpoint_tiles();
    debug_load_hud_tiles();
    percent_hud_load_tiles();
    bg_drift_px = 0;
    if (_cpu == CGB_TYPE) {
        if (setting_show_bg_enabled) init_bg_parallax();
        else blank_parallax_vram();
        last_bg_phase = 0;
        load_menu_ground_tiles();
        cam_py = MAP_Y0 + 128u;
    } else {
        cam_py = MAP_Y0 + 112u;
    }
    mt_band = band_for_cam(cam_py, BAND_MAX);
    cam_build_col = 0xFFFF;
    band_cam_row = 0xFF;

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
    player.y_base = Y_BASE_MAX;
    sp_cache_reset(&active_sp, &sp_stream_idx);
    coins_reset();
    coins_saved = level_coins[idx];
    percent_hud_reset(max_scroll_px);
    attempt_text_start(1, cam_px, cam_py);
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

extern const hUGESong_t practice;
// StayInsideMe(WIP).uge plays on VBlank (timer off) at 7 ticks/row: ~59.7 Hz from the
// 4096 Hz timer is 69 counts, TMA = 256 - 69
#define PRACTICE_MUSIC_DIVIDER 187

#define MAX_PRACTICE_CHECKPOINTS 10

typedef struct {
    Player   player;
    uint16_t cam_px;
    uint16_t cam_py;
    uint16_t scroll_acc;
    uint8_t  bg_drift_px;
    uint8_t  target_bg_idx;
    uint8_t  active;
    uint16_t world_x;
    uint16_t world_y;
    palette_color_t bg_palettes[20];
    uint16_t cam_portal_y;
} PracticeCheckpoint;

static PracticeCheckpoint practice_checkpoints[MAX_PRACTICE_CHECKPOINTS];
static uint8_t practice_cp_count = 0;
static uint16_t last_cp_cam_px = 0;

static void practice_clear_checkpoints(void) {
    uint8_t i;
    practice_cp_count = 0;
    last_cp_cam_px = 0;
    for (i = 0; i < MAX_PRACTICE_CHECKPOINTS; i++) {
        practice_checkpoints[i].active = 0;
    }
}

static void practice_add_checkpoint(void) {
    uint8_t i;
    PracticeCheckpoint *cp;
    if (player.dead || end_anim_state != END_ANIM_INACTIVE || player.level_complete) return;
    if (practice_cp_count >= MAX_PRACTICE_CHECKPOINTS) {
        for (i = 0; i < MAX_PRACTICE_CHECKPOINTS - 1; i++) {
            practice_checkpoints[i] = practice_checkpoints[i + 1];
        }
        practice_cp_count = MAX_PRACTICE_CHECKPOINTS - 1;
    }
    cp = &practice_checkpoints[practice_cp_count];
    cp->player = player;
    cp->cam_px = cam_px;
    cp->cam_py = cam_py;
    cp->cam_portal_y = cam_portal_y;
    cp->scroll_acc = scroll_acc;
    cp->bg_drift_px = bg_drift_px;
    cp->target_bg_idx = target_bg_idx;
    cp->world_x = cam_px;
    cp->world_y = PLAYER_WORLD_Y();
    cp->active = 1;
    if (_cpu == CGB_TYPE) {
        memcpy(cp->bg_palettes, famidash_bg_target, 20 * sizeof(palette_color_t));
    }
    practice_cp_count++;
    last_cp_cam_px = cam_px;
}

static void practice_remove_checkpoint(void) {
    if (practice_cp_count > 1) {
        practice_cp_count--;
        practice_checkpoints[practice_cp_count].active = 0;
        last_cp_cam_px = practice_checkpoints[practice_cp_count - 1].cam_px;
    } else if (practice_cp_count == 1) {
        practice_checkpoints[0].cam_px = 0;
        if (_cpu == CGB_TYPE) {
            practice_checkpoints[0].cam_py = MAP_Y0 + 128u;
        } else {
            practice_checkpoints[0].cam_py = MAP_Y0 + 112u;
        }
        practice_checkpoints[0].scroll_acc = 0;
        practice_checkpoints[0].bg_drift_px = 0;
        practice_checkpoints[0].target_bg_idx = 0;
        practice_checkpoints[0].world_x = 0;
        practice_checkpoints[0].world_y = practice_checkpoints[0].cam_py;
        player_init(&practice_checkpoints[0].player, 0, 240);
        practice_checkpoints[0].player.y_base = Y_BASE_MAX;
        last_cp_cam_px = 0;
    }
}

static uint8_t practice_has_checkpoint(void) {
    return (practice_cp_count > 0 && practice_checkpoints[practice_cp_count - 1].active);
}

static void practice_init_checkpoint(void) {
    if (practice_cp_count == 0) {
        practice_add_checkpoint();
    }
}

static uint8_t practice_draw_checkpoints(uint8_t oam_index, uint16_t cam_x, uint16_t cam_y, uint8_t reversed) {
    uint8_t cpi;
    for (cpi = 0; cpi < practice_cp_count; cpi++) {
        PracticeCheckpoint *cp = &practice_checkpoints[cpi];
        if (!cp->active) continue;
        int16_t dist_x = (int16_t)cp->world_x - (int16_t)cam_x;
        int16_t ox;
        if (reversed) {
            ox = (int16_t)MIRROR_PLAYER_SCREEN_X + dist_x + 8;
        } else {
            ox = (cam_x < PLAYER_SCREEN_X) ? ((int16_t)cp->world_x + 8) : (dist_x + (int16_t)PLAYER_SCREEN_X + 8);
        }
        int16_t oy = (int16_t)cp->world_y - (int16_t)cam_y + 16;
        if (ox >= 0 && ox <= 168 && oy >= 0 && oy <= 160 && oam_index <= 38) {
            shadow_OAM[oam_index].x = (uint8_t)ox;
            shadow_OAM[oam_index].y = (uint8_t)oy;
            shadow_OAM[oam_index].tile = CHECKPOINT_TILE_BASE;
            shadow_OAM[oam_index].prop = (_cpu == CGB_TYPE) ? S_PAL(1) : 0;
            oam_index++;

            shadow_OAM[oam_index].x = (uint8_t)(ox + 8);
            shadow_OAM[oam_index].y = (uint8_t)oy;
            shadow_OAM[oam_index].tile = CHECKPOINT_TILE_BASE + 2;
            shadow_OAM[oam_index].prop = (_cpu == CGB_TYPE) ? S_PAL(1) : 0;
            oam_index++;
        }
    }
    return oam_index;
}

// ---- play_level helpers: the rarely-run parts of the main loop (pause, level
// complete, mirror portal, death, level end). Out of play_level because SDCC's
// register allocator (--max-allocs-per-node50000) is very slow on one huge
// function. Per-frame code stays inline in play_level: moving it into helpers
// cost frames on DMG.

// Pause menu (Start). Returns 1 when the player chose to leave the level.
static void practice_respawn(uint8_t idx);

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

        // Practice Button: White rim & diamond outline, 2-tone green body
        static const palette_color_t practice_btn_pal[4] = {
            RGB8(0, 0, 0), RGB8(255, 255, 255), RGB8(80, 210, 20), RGB8(15, 110, 10)
        };
        set_sprite_palette(4, 1, practice_btn_pal);
    } else {
        BGP_REG = dim_dmg_byte(saved_bgp, 1);
        OBP0_REG = 0x90;
        OBP1_REG = 0x1C;
    }

    // Hide all gameplay and level sprites, then load the pause tiles: they borrow the death
    // effect and checkpoint tiles, which must be off screen while they are overwritten
    for (uint8_t i = 0; i < 40; i++) {
        shadow_OAM[i].y = 0;
    }
    wait_vbl_done();
    init_pause_tiles();

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
            if (selected_btn == 0) selected_btn = 3;
            else selected_btn--;
            draw_pause_menu_sprites(selected_btn);
        } else if (p_pressed & J_RIGHT) {
            if (selected_btn >= 3) selected_btn = 0;
            else selected_btn++;
            draw_pause_menu_sprites(selected_btn);
        } else if (p_pressed & (J_UP | J_DOWN)) {
            if (selected_btn == PAUSE_BTN_PRACTICE) selected_btn = PAUSE_BTN_PLAY;
            else selected_btn = PAUSE_BTN_PRACTICE;
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
            } else if (selected_btn == PAUSE_BTN_PRACTICE) {
                if (!practice_mode) {
                    practice_mode = 1;
                    practice_init_checkpoint();
                    if (setting_music_enabled) {
                        init_music_banked(&practice, 212, PRACTICE_MUSIC_DIVIDER);
                        current_song_bank = 212;
                        saved_music_ready = 1;
                    }
                    break;
                } else {
                    practice_mode = 0;
                    practice_clear_checkpoints();
                    restart_level = 1;
                    break;
                }
            }
        }
    }

    // Hide all pause menu UI sprites immediately
    for (uint8_t i = 0; i < 34; i++) {
        shadow_OAM[i].y = 0;
    }
    percent_hud_hide();   // redrawn next frame (the pause menu used its slots)

    if (_cpu == CGB_TYPE) {
        wait_vbl_done();
        apply_pause_box_attributes(0);
        fade_restore_pause_box_palettes();
        set_sprite_palette(0, 8, gbc_sprite_palettes);
        flush_ground_row();
    } else {
        BGP_REG = saved_bgp;
        OBP0_REG = saved_obp0;
        OBP1_REG = saved_obp1;
    }

    // Restore fractional background scroll
    move_bkg(saved_scx, saved_scy);

    if (exit_level) {
        practice_mode = 0;
        practice_clear_checkpoints();
        return 1;
    }

    // Practice mode: Restart goes back to the last checkpoint and the practice music keeps
    // going (resumed below like a normal unpause)
    if (restart_level && practice_mode) {
        practice_respawn(idx);
        restart_level = 0;
    }

    if (restart_level) {
        practice_clear_checkpoints();
        reload_level_state(idx);
        if (practice_mode) practice_init_checkpoint();
        prev_joy = joypad();
        if (prev_joy & J_UP) prev_joy |= J_A;
        player.last_joy = prev_joy;
        return 0;
    }

    NR30_REG = 0x80;
    hUGE_reset_wave();

    wait_vbl_done();

    // The pause tiles borrowed these (exit and restart reload all sprite tiles)
    restore_death_tiles();
    if (practice_mode) load_checkpoint_tiles();
    attempt_text_load_tiles();

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

// draw_text() is BANKED (sp_draw's bank is switched in while it runs), so a string literal
// that lives in this file's bank would be read from the wrong ROM bank. Draw from here.
static void complete_text(uint8_t x, uint8_t y, const char *str) {
    for (; *str; str++, x++) {
        char c = *str;
        uint8_t tile = 0;
        if (c >= 'A' && c <= 'Z') tile = (uint8_t)((c - 'A') + 13);
        set_bkg_tile_xy(x, y, (uint8_t)(FONT_PUSAB_START + tile));
    }
}

static void level_complete_screen(uint8_t idx) {
    if (practice_mode) {
        record_level_progress(idx, 100, 1);
    } else {
        record_level_progress(idx, 100, 0);
        record_level_coins(idx, coins_collected);
    }
    HIDE_SPRITES;
    move_bkg(0, 0);
    disable_interrupts();
    setup_menu_font();
    enable_interrupts();
    VBK_REG = 1;
    fill_bkg_rect(0, 0, 32, 32, 0x00);
    VBK_REG = 0;
    fill_bkg_rect(0, 0, 20, 18, 0x00);
    if (practice_mode) {
        complete_text(2, 6, "PRACTICE COMPLETE");
    } else {
        complete_text(3, 6, "LEVEL COMPLETE");
    }
    complete_text(2, 12, "PRESS A TO EXIT");
    waitpadup();
    while (!(joypad() & J_A)) wait_vbl_done();
}

// The level end object was reached: start the pull-to-the-edge animation
static void start_end_anim(void) {
    percent_hud_complete();
    end_anim_state = END_ANIM_PULL;
    end_anim_frame = 0;
    locked_scroll_px = player.reversed
        ? (uint16_t)(-(int16_t)cam_px - MIRROR_PLAYER_SCREEN_X)
        : ((cam_px > PLAYER_SCREEN_X) ? (cam_px - PLAYER_SCREEN_X) : 0);
    locked_cam_py = cam_py;
    end_start_x = player.reversed ? MIRROR_PLAYER_SCREEN_X : ((cam_px < PLAYER_SCREEN_X) ? (uint8_t)cam_px : PLAYER_SCREEN_X);
    end_start_y = (int16_t)PLAYER_WORLD_Y() - (int16_t)cam_py;

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
    PROF_MARK(14);   // mirror: tileset

    const uint8_t* target_tiles = player.reversed
        ? l->tiles_rev
        : level_tiles;
    load_bkg_tileset(target_tiles, level_tile_count, level_tiles_bank);
    PROF_MARK(15);   // mirror: level tiles
    apply_level_bg_tiles(idx, player.reversed);
    if (!setting_show_bg_enabled) {
        set_bkg_data(12, 1, blank_bg_tile);
    }
    PROF_MARK(16);   // mirror: columns

    int32_t col_start = (int32_t)(cam_px >> 4) - 4;
    if (col_start < 0) col_start = 0;
    for (uint8_t i = 0; i < 16; i++) {
        uint16_t curr_col = (uint16_t)(col_start + i);
        if (curr_col < level_map_w) {
            uint8_t vram_slot = (uint8_t)(curr_col & 15);
            if (player.reversed) vram_slot = (uint8_t)(-(int8_t)vram_slot & 15);
            prepare_mt_column(curr_col, level_map, level_map_bank, player.reversed);
            PROF_MARK(19);   // mirror: column flush
            flush_mt_column(vram_slot);
            PROF_MARK(16);
        }
    }

    PROF_MARK(17);   // mirror: sprite tiles
    // The tileset reload overwrote sprite tiles 128..159 (shared VRAM); no other sprite changes
    reload_bg_shared_sprite_tiles();
    PROF_MARK(18);   // mirror: rest

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

static void practice_respawn(uint8_t idx) {
    uint8_t apply_idx;
    PracticeCheckpoint *cp = &practice_checkpoints[practice_cp_count - 1];

    cam_px = cp->cam_px;
    cam_py = cp->cam_py;
    cam_build_col = 0xFFFF;
    cam_portal_y = cp->cam_portal_y;
    scroll_acc = cp->scroll_acc;
    bg_drift_px = cp->bg_drift_px;
    target_bg_idx = cp->target_bg_idx;

    player = cp->player;
    player.dead = 0;

    mt_band = band_for_cam(cam_py, BAND_MAX);
    cam_build_col = 0xFFFF;
    band_cam_row = 0xFF;

    mirror_reload(idx);

    if (_cpu == CGB_TYPE) {
        if (setting_show_bg_enabled) init_bg_parallax();
        else blank_parallax_vram();
        last_bg_phase = 0;
        load_menu_ground_tiles();
        flush_ground_row();
        famidash_bg_set_now(cp->bg_palettes);
        set_bkg_palette(0, 5, shadow_bkg_palettes);
        fade_set_sprite_palette(0, 8, gbc_sprite_palettes);
    } else {
        apply_idx = target_bg_idx;
        if (reduce_flash && (apply_idx == 1 || apply_idx == 2)) apply_idx = 0;
        BGP_REG = bg_pals[apply_idx];
        OBP0_REG = (apply_idx == 3) ? DMG_OBP_ON_BLACK : BGP_REG;
        OBP1_REG = dmg_obp1(apply_idx, OBP0_REG);
    }

    load_gameplay_sprite_tiles(LEVEL_DECO_CLOUD(idx));
    load_checkpoint_tiles();
    debug_load_hud_tiles();
    percent_hud_load_tiles();

    sp_cache_reset(&active_sp, &sp_stream_idx);
    sp_cache_fill(l, cam_px, &sp_stream_idx);
    sp_cache_col = 0xFFFF;
    sp_fill_pending = 0;
    cached_collision_col = 0xFFFF;
    previous_oam_index = MAX_HARDWARE_SPRITES;

    percent_hud_reset(max_scroll_px);
    percent_hud_update(cam_px);
    attempt_text_start(cam_px == 0, cam_px, cam_py);

    // Like a normal restart: a held jump acts right away (prev_joy only keeps B/SELECT
    // from placing or removing a checkpoint on the first frame)
    prev_joy = joypad();
    player.last_joy = 0;
    pause_suppress_jump = 0;
}

static void handle_death(uint8_t idx, uint8_t sprite_x_final, int16_t final_py, uint16_t scroll_px) {
    record_level_progress_from_cam(idx, cam_px, max_scroll_px, practice_mode);
    if (setting_effects_enabled) {
        play_death_animation(sprite_x_final, (uint8_t)final_py, (uint8_t)scroll_px, (uint8_t)cam_py, practice_mode);
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
    if (practice_mode && practice_has_checkpoint()) {
        practice_respawn(idx);
    } else {
        reload_level_state(idx);
    }
}

// Look-ahead table builders, hand-written (in C one step took ~1/16 of a DMG frame). The
// rows of a map column: cam_build_rows in collision.c (HOME: it switches the ROM bank).
// cam_build_na: cam_na at cb_dst from cam_nb at cb_src (32 rows).
static void cam_build_na(void) __naked {
    __asm
        ld      hl, #_cb_dst
        ld      a, (hl+)
        ld      e, a
        ld      d, (hl)                 ; de = cam_na
        ld      hl, #_cb_src
        ld      a, (hl+)
        ld      h, (hl)
        ld      l, a                    ; hl = cam_nb
        ld      b, #0xFF                ; b = last row with something in it
        ; unrolled over the 32 rows: cam_nb[r] == r means row r has something in it
        ld      a, (hl+)
        cp      a, #0
        jr      NZ, 1$
        ld      b, a
    1$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #1
        jr      NZ, 2$
        ld      b, a
    2$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #2
        jr      NZ, 3$
        ld      b, a
    3$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #3
        jr      NZ, 4$
        ld      b, a
    4$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #4
        jr      NZ, 5$
        ld      b, a
    5$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #5
        jr      NZ, 6$
        ld      b, a
    6$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #6
        jr      NZ, 7$
        ld      b, a
    7$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #7
        jr      NZ, 8$
        ld      b, a
    8$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #8
        jr      NZ, 9$
        ld      b, a
    9$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #9
        jr      NZ, 10$
        ld      b, a
    10$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #10
        jr      NZ, 11$
        ld      b, a
    11$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #11
        jr      NZ, 12$
        ld      b, a
    12$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #12
        jr      NZ, 13$
        ld      b, a
    13$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #13
        jr      NZ, 14$
        ld      b, a
    14$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #14
        jr      NZ, 15$
        ld      b, a
    15$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #15
        jr      NZ, 16$
        ld      b, a
    16$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #16
        jr      NZ, 17$
        ld      b, a
    17$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #17
        jr      NZ, 18$
        ld      b, a
    18$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #18
        jr      NZ, 19$
        ld      b, a
    19$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #19
        jr      NZ, 20$
        ld      b, a
    20$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #20
        jr      NZ, 21$
        ld      b, a
    21$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #21
        jr      NZ, 22$
        ld      b, a
    22$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #22
        jr      NZ, 23$
        ld      b, a
    23$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #23
        jr      NZ, 24$
        ld      b, a
    24$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #24
        jr      NZ, 25$
        ld      b, a
    25$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #25
        jr      NZ, 26$
        ld      b, a
    26$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #26
        jr      NZ, 27$
        ld      b, a
    27$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #27
        jr      NZ, 28$
        ld      b, a
    28$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #28
        jr      NZ, 29$
        ld      b, a
    29$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #29
        jr      NZ, 30$
        ld      b, a
    30$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #30
        jr      NZ, 31$
        ld      b, a
    31$:
        ld      a, b
        ld      (de), a
        inc     de
        ld      a, (hl+)
        cp      a, #31
        jr      NZ, 32$
        ld      b, a
    32$:
        ld      a, b
        ld      (de), a
        inc     de
        ret
    __endasm;
}

// Next step (0..4) of building the look-ahead tables of column cam_build_col (see cam_nb)
static uint8_t cam_build_slot;
static void cam_build(void) {
    uint8_t step = cam_build_step;
    if (!step) {
        uint16_t col = cam_build_col;
        cam_build_slot = (uint8_t)((uint8_t)col & (CAM_RING - 1u)) << 5;
        cb_run = 32;
        cam_build_bank = 0;   // past the map's end: nothing
        if (col < level_map_w) {
            cam_build_bank = (uint8_t)(level_map_bank + (uint8_t)(col >> MAP_BANK_COLS_SHIFT));
            cam_build_src = level_map + (((uint16_t)col & (MAP_BANK_COLS - 1u)) << MAP_ROWS_SHIFT);
        }
    }
    if (step < 4u) {
        uint8_t row = (uint8_t)(31u - (step << 3));   // rows 24..31 first
        cb_dst = &cam_nb[(uint8_t)(cam_build_slot | row)];
        if (cam_build_bank) {
            cb_bank = cam_build_bank;
            cb_src = cam_build_src + row;
            cb_row = row;
            cam_build_rows();
        } else {
            memset(cb_dst - 7, 32, 8);
        }
    } else {
        cb_src = &cam_nb[cam_build_slot];
        cb_dst = &cam_na[cam_build_slot];
        cam_build_na();
    }
    if (++cam_build_step == 5u) { cam_build_step = 0; cam_build_col++; }
}

// The window's rows from the look-ahead tables of the CAM_LOOK columns from cw_s (column & 7):
// cw_below = max(cw_below, the first row >= cw_frow1 with something in it), cw_above = min(cw_above,
// the last row <= cw_prow - 1 with something in it, if >= cw_lim). Hand-written like cam_apply.
static uint8_t cw_s, cw_n, cw_frow1, cw_prow, cw_lim, cw_below, cw_above;
static void cam_window(void) __naked {
    __asm
        ld      a, #CAM_LOOK
        ld      (_cw_n), a
    1$:
        ld      a, (_cw_s)
        and     a, #7
        swap    a
        add     a, a
        ld      c, a                    ; c = slot * 32
        ld      a, (_cw_frow1)
        cp      a, #32
        jr      NC, 2$
        or      a, c
        ld      hl, #_cam_nb
        add     a, l
        ld      l, a
        adc     a, h
        sub     a, l
        ld      h, a
        ld      a, (_cw_below)
        cp      a, (hl)
        jr      NC, 2$
        ld      a, (hl)
        ld      (_cw_below), a
    2$:
        ld      a, (_cw_prow)
        or      a, a
        jr      Z, 3$
        dec     a
        or      a, c
        ld      hl, #_cam_na
        add     a, l
        ld      l, a
        adc     a, h
        sub     a, l
        ld      h, a
        ld      a, (hl)
        cp      a, #0xFF
        jr      Z, 3$
        ld      b, a                    ; b = row
        ld      a, (_cw_lim)
        ld      e, a
        ld      a, b
        cp      a, e
        jr      C, 3$                   ; out of reach
        ld      a, (_cw_above)
        cp      a, b
        jr      C, 3$
        jr      Z, 3$
        ld      a, b
        ld      (_cw_above), a
    3$:
        ld      hl, #_cw_s
        inc     (hl)
        ld      hl, #_cw_n
        dec     (hl)
        jr      NZ, 1$
        ret
    __endasm;
}

// Camera step for a distance a: 1/3 of it (~ 1/4 + 1/16 + 1/64), 1 .. CAM_Y_MAX_STEP px
static const uint8_t cam_step_tab[28] = {
    0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7
};

// The per-frame part of update_camera_y, hand-written (SDCC's 16-bit code took ~1/40 of a DMG
// frame). In: cam_wy (the player's world y), cam_win_top / bot, cam_py. Out: cam_py.
//   hi = min(wy - CAM_HEAD, win_top), lo = max(wy + 16 + CAM_FOOT, win_bot) - CAM_VIEW_H (both
//   cannot fit: the player centred within hi .. lo, so the nearer end of the window stays on
//   screen); the target is cam_py clamped to lo .. hi and to the level; cam_py
//   moves towards it by cam_step_tab, then keeps the player CAM_Y_EDGE from the screen edges.
static uint16_t cam_wy;
static void cam_apply(void) __naked {
    __asm
        ld      hl, #_cam_wy
        ld      a, (hl+)
        ld      c, a
        ld      b, (hl)                 ; bc = wy (kept to the end)
        ; hl = hi = wy - CAM_HEAD (0 below it), then min with win_top
        ld      a, c
        sub     a, #CAM_HEAD
        ld      l, a
        ld      a, b
        sbc     a, #0
        ld      h, a
        jr      NC, 1$
        ld      hl, #0
    1$:
        ld      a, (_cam_win_top)
        sub     a, l
        ld      a, (_cam_win_top + 1)
        sbc     a, h
        jr      NC, 2$
        ld      a, (_cam_win_top)
        ld      l, a
        ld      a, (_cam_win_top + 1)
        ld      h, a
    2$:
        push    hl                      ; hi
        ; de = bot = max(wy + 16 + CAM_FOOT, win_bot)
        ld      hl, #(16 + CAM_FOOT)
        add     hl, bc
        ld      e, l
        ld      d, h
        ld      a, (_cam_win_bot)
        ld      l, a
        ld      a, (_cam_win_bot + 1)
        ld      h, a
        ld      a, e
        sub     a, l
        ld      a, d
        sbc     a, h
        jr      NC, 3$
        ld      e, l
        ld      d, h
    3$:
        ; de = lo = bot - CAM_VIEW_H (0 below it)
        ld      a, e
        sub     a, #CAM_VIEW_H
        ld      e, a
        ld      a, d
        sbc     a, #0
        ld      d, a
        jr      NC, 4$
        ld      de, #0
    4$:
        pop     hl                      ; hl = hi
        ; lo > hi (the window is taller than the screen): both = the player centred, but
        ; within hi .. lo, so the nearer end of the window stays on screen
        ld      a, l
        sub     a, e
        ld      a, h
        sbc     a, d
        jr      NC, 5$
        push    de                      ; lo
        ld      a, c
        sub     a, #(CAM_VIEW_H / 2 - 8)
        ld      e, a
        ld      a, b
        sbc     a, #0
        ld      d, a                    ; de = wy + 8 - CAM_VIEW_H / 2
        jr      NC, 51$
        ld      de, #0
    51$:
        ld      a, e
        sub     a, l
        ld      a, d
        sbc     a, h
        jr      NC, 52$
        ld      e, l                    ; not above hi
        ld      d, h
    52$:
        pop     hl                      ; hl = lo
        ld      a, l
        sub     a, e
        ld      a, h
        sbc     a, d
        jr      NC, 53$
        ld      e, l                    ; not below lo
        ld      d, h
    53$:
        ld      l, e
        ld      h, d
    5$:
        push    hl                      ; hi
        ld      hl, #_cam_py
        ld      a, (hl+)
        ld      h, (hl)
        ld      l, a                    ; hl = target = cam_py
        ld      a, l
        sub     a, e
        ld      a, h
        sbc     a, d
        jr      NC, 6$
        ld      l, e                    ; below lo
        ld      h, d
        pop     de
        jr      7$
    6$:
        pop     de                      ; de = hi
        ld      a, e
        sub     a, l
        ld      a, d
        sbc     a, h
        jr      NC, 7$
        ld      l, e                    ; above hi
        ld      h, d
    7$:
        call    30$                     ; target within the level
        ; de = cy = cam_py, hl = target - cy
        ld      a, (_cam_py)
        ld      e, a
        ld      a, (_cam_py + 1)
        ld      d, a
        ld      a, l
        sub     a, e
        ld      l, a
        ld      a, h
        sbc     a, d
        ld      h, a
        jr      C, 9$                   ; target < cy: down
        or      a, l
        jr      Z, 12$                  ; there already
        call    40$                     ; a = step
        add     a, e                    ; cy += step
        ld      e, a
        ld      a, d
        adc     a, #0
        ld      d, a
        jr      12$
    9$:
        xor     a, a                    ; hl = cy - target
        sub     a, l
        ld      l, a
        ld      a, #0
        sbc     a, h
        ld      h, a
        call    40$                     ; a = step
        ld      l, a                    ; cy -= step
        ld      a, e
        sub     a, l
        ld      e, a
        ld      a, d
        sbc     a, #0
        ld      d, a
    12$:
        ; de = cy; the player at least CAM_Y_EDGE from the screen edges
        ld      hl, #CAM_Y_EDGE
        add     hl, de                  ; hl = cy + CAM_Y_EDGE
        ld      a, c
        sub     a, l
        ld      a, b
        sbc     a, h
        jr      NC, 13$
        ld      a, c                    ; wy < cy + EDGE: cy = wy - EDGE (0 below it)
        sub     a, #CAM_Y_EDGE
        ld      l, a
        ld      a, b
        sbc     a, #0
        ld      h, a
        jr      NC, 15$
        ld      hl, #0
        jr      15$
    13$:
        ld      hl, #(CAM_VIEW_H - 16 - CAM_Y_EDGE)
        add     hl, de                  ; hl = cy + VIEW - 16 - EDGE
        ld      a, l
        sub     a, c
        ld      a, h
        sbc     a, b
        jr      NC, 14$
        ld      a, c                    ; wy below that: cy = wy - (VIEW - 16 - EDGE)
        sub     a, #(CAM_VIEW_H - 16 - CAM_Y_EDGE)
        ld      l, a
        ld      a, b
        sbc     a, #0
        ld      h, a
        jr      15$
    14$:
        ld      l, e
        ld      h, d
    15$:
        call    30$
        ld      a, l
        ld      (_cam_py), a
        ld      a, h
        ld      (_cam_py + 1), a
        ret
    30$:
        ; hl clamped to level_top_px .. cam_py_max (uses de)
        ld      a, (_level_top_px)
        ld      e, a
        ld      a, (_level_top_px + 1)
        ld      d, a
        ld      a, l
        sub     a, e
        ld      a, h
        sbc     a, d
        jr      NC, 31$
        ld      l, e
        ld      h, d
    31$:
        ld      a, (_cam_py_max)
        ld      e, a
        ld      a, (_cam_py_max + 1)
        ld      d, a
        ld      a, e
        sub     a, l
        ld      a, d
        sbc     a, h
        ret     NC
        ld      l, e
        ld      h, d
        ret
    40$:
        ; a = step for the distance hl (> 0): cam_step_tab, CAM_Y_MAX_STEP from 28 on
        ld      a, h
        or      a, a
        jr      NZ, 41$
        ld      a, l
        cp      a, #28
        jr      NC, 41$
        add     a, #<_cam_step_tab
        ld      l, a
        ld      a, #0
        adc     a, #>_cam_step_tab
        ld      h, a
        ld      a, (hl)
        ret
    41$:
        ld      a, #CAM_Y_MAX_STEP
        ret
    __endasm;
}

static void update_camera_y(void) {
    uint16_t wy = PLAYER_WORLD_Y();
    uint16_t c0 = cam_px >> 4;
    uint8_t fly = (player.mode != MODE_CUBE);

    // look-ahead tables: columns c0 .. c0 + CAM_LOOK - 1, and the next two being built
    if (cam_build_col == 0xFFFF) {
        cam_build_col = c0;
        cam_build_step = 0;
        while (cam_build_col < c0 + CAM_RING) cam_build();
        cam_build_left = 0;
        cam_still = 0;
        cam_win_col = c0;
        cam_win_row = 0xFF;   // recompute the window
    } else if (cam_build_left) {
        // One step per frame (a column every ~6 frames needs 5); two when it fell behind
        cam_build();
        if (--cam_build_left > 5u) { cam_build(); cam_build_left--; }
    }

    if (!fly) {
        // Cube: the dead zone camera (the player stays within screen rows CAM_Y_TOP_ZONE ..
        // CAM_Y_BOTTOM_ZONE, the camera snaps there)
        int16_t py = (int16_t)wy - (int16_t)cam_py;
        int16_t t;
        if (py < CAM_Y_TOP_ZONE) t = (int16_t)wy - CAM_Y_TOP_ZONE;
        else if (py > CAM_Y_BOTTOM_ZONE) t = (int16_t)wy - CAM_Y_BOTTOM_ZONE;
        else return;
        if (t < (int16_t)level_top_px) t = (int16_t)level_top_px;
        if ((uint16_t)t > cam_py_max) t = (int16_t)cam_py_max;
        cam_py = (uint16_t)t;
        cam_still = 0;
        return;
    }

    // Ship / ball: the window, when the player's column, row, mode or portal changed
    uint8_t prow = (uint8_t)(wy >> 4);
    if ((uint8_t)c0 != (uint8_t)cam_win_col || prow != cam_win_row || fly != cam_win_fly || cam_portal_y != cam_win_portal) {
        if ((uint8_t)c0 != (uint8_t)cam_win_col) cam_build_left += 5;   // one more column to build
        cam_still = 0;
        cam_win_col = c0; cam_win_row = prow; cam_win_fly = fly; cam_win_portal = cam_portal_y;
        uint8_t frow1 = (uint8_t)(((wy + 15u) >> 4) + 1u);
        uint8_t lim = (uint8_t)(prow - CAM_REACH_FLY);   // rows above it: out of reach
        if (lim > prow) lim = 0;
        cw_s = (uint8_t)c0; cw_frow1 = frow1; cw_prow = prow; cw_lim = lim;
        cw_below = frow1; cw_above = 0xFF;
        cam_window();
        uint8_t below = cw_below, above = cw_above;
        if (frow1 >= 32u) below = 32;
        // obstacles: at least half of their tile + CAM_PAD on screen
        cam_win_top = (above != 0xFF) ? (uint16_t)(((uint16_t)above << 4) + (8 - CAM_PAD)) : 0xFFFF;
        cam_win_bot = ((uint16_t)below << 4) + ((below < 32u) ? (8 + CAM_PAD) : CAM_PAD);
        if (fly && above == 0xFF) {
            // no ceiling in reach: Famidash's lock to the mode portal
            uint16_t c = cam_portal_y + (CAM_PORTAL_H / 2u);
            if (c - (CAM_VIEW_H / 2u) < cam_win_top) cam_win_top = c - (CAM_VIEW_H / 2u);
            if (c + (CAM_VIEW_H / 2u) > cam_win_bot) cam_win_bot = c + (CAM_VIEW_H / 2u);
        }
    }

    // nothing changed and the camera has settled: nothing to do (the cube running on the ground)
    if (cam_still && wy == cam_last_wy) return;
    cam_last_wy = wy;
    uint16_t before = cam_py;
    cam_wy = wy;
    cam_apply();
    cam_still = (cam_py == before);
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

    cam_px = 0;
    // CGB shows the ground strip (16px) below the map, DMG ends at the map's last row
    if (_cpu == CGB_TYPE) {
        cam_py = MAP_Y0 + 128u;
        cam_py_max = (level_map_h << 4) - 128u;
    } else {
        cam_py = MAP_Y0 + 112u;
        cam_py_max = (level_map_h << 4) - 144u;
    }
    level_top_px = (uint16_t)l->map_top << 4;
    mt_band = band_for_cam(cam_py, BAND_MAX);
    cam_build_col = 0xFFFF;
    band_cam_row = 0xFF;
    loaded_r = BKG_MT_W - 1;
    col_job_step = COL_JOB_STEPS;
    row0_job_pos = 16;
    col_job_issued = row0_job_issued = 0; bg_cj_pending = bg_rj_pending = 0;
    max_scroll_px = ((level_map_w - VIEW_MT_W) << 4);

    target_bg_idx = 0;
    player_init(&player, 0, 240);
    player.y_base = Y_BASE_MAX;

    DISPLAY_OFF;
    load_bkg_tileset(level_tiles, level_tile_count, level_tiles_bank);
    apply_level_bg_tiles(idx, 0);
    if (!setting_show_bg_enabled) {
        set_bkg_data(12, 1, blank_bg_tile);
    }
    load_gameplay_sprite_tiles(LEVEL_DECO_CLOUD(idx));   // sprite_tiles.png
    debug_load_hud_tiles();
    percent_hud_load_tiles();
    bg_drift_px = 0;
    if (_cpu == CGB_TYPE) {
        if (setting_show_bg_enabled) init_bg_parallax();
        else blank_parallax_vram();
        last_bg_phase = 0;
        load_menu_ground_tiles();
        famidash_reset_bg_palettes(idx);
        fade_set_sprite_palette(0, 8, gbc_sprite_palettes);
    }
    move_bkg(0, (uint8_t)cam_py);
    fill_scroll_bg(level_map, level_map_w, level_map_bank, 0);

    fade_set_dmg_palettes(bg_pals[0], bg_pals[0], dmg_obp1(0, bg_pals[0]));
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
    practice_mode = 0;
    practice_clear_checkpoints();
    coins_reset();
    coins_saved = level_coins[idx];
    percent_hud_reset(max_scroll_px);
    attempt_count = 0;
    attempt_text_start(1, cam_px, cam_py);
    bg_parallax_isr_start();
    while (1) {
        PROF_MARK(1);   // input, scrolling, object cache
#ifdef DEBUG_PROFILE
        gpcamx = cam_px;
        gpcamy = cam_py;
        gpplayy = PLAYER_WORLD_Y();
        gpstate = (uint8_t)(player.mode | (player.mini << 4) | (player.gravity_flipped << 5) | (player.dead << 7));
#endif
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

        if (practice_mode) {
            if ((joy & J_B) && !(prev_joy & J_B)) {
                practice_add_checkpoint();
            }
            if (((joy & J_SELECT) && !(prev_joy & J_SELECT)) ||
                ((joy & J_DOWN) && !(prev_joy & J_DOWN))) {
                practice_remove_checkpoint();
            }

            if (!player.dead && end_anim_state == END_ANIM_INACTIVE && !player.level_complete) {
                if (cam_px > last_cp_cam_px + 140) {
                    if (player.mode == MODE_SHIP) {
                        practice_add_checkpoint();
                    } else if (player.on_ground) {
                        practice_add_checkpoint();
                    }
                }
            }
        } else {
            if ((joy & J_SELECT) && !(prev_joy & J_SELECT)) {
                reduce_flash = !reduce_flash;
                setting_dmg_gradient = !reduce_flash;
                save_game_data();
            }
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

        PROF_MARK(2);   // object logic
        process_sprite_logic(&active_sp, cam_px, &player, joy, &target_bg_idx);
        PROF_MARK(3);   // collision columns, player physics

        if (end_trigger_requested && end_anim_state == END_ANIM_INACTIVE) start_end_anim();

        if (player.reversed != prev_reversed) mirror_reload(idx);

        // Move the collision window when the player nears its top or bottom
        {
            uint8_t ly = player.world_y.b.h;
            if (ly < 48u && player.y_base > level_top_px) {
                uint8_t d = (player.y_base - level_top_px > 128u) ? 128u : (uint8_t)(player.y_base - level_top_px);
                player.y_base -= d;
                player.world_y.b.h = (uint8_t)(ly + d);
                cached_collision_col = 0xFFFF;
            } else if (ly >= 208u && player.y_base < Y_BASE_MAX) {
                uint8_t d = (Y_BASE_MAX - player.y_base > 128u) ? 128u : (uint8_t)(Y_BASE_MAX - player.y_base);
                player.y_base += d;
                player.world_y.b.h = (uint8_t)(ly - d);
                cached_collision_col = 0xFFFF;
            }
        }
        if (px_curr != cached_collision_col) {
            load_collision_columns(px_curr, level_map, level_map_w,
                                   level_map_bank, collision_columns, (uint8_t)(player.y_base >> 4));
            cached_collision_col = px_curr;
        }

        if (end_anim_state == END_ANIM_INACTIVE) {
            died = player_update(&player, joy, collision_columns, 16);
#ifdef DEBUG_PROFILE
            if (died) gpdeaths++;
#endif
#if ENABLE_DEBUG_MODE
            if (debug_mode) { died = 0; player.dead = 0; } // noclip: hazards and walls can't kill
#ifdef DEBUG_GODMODE
            died = 0; player.dead = 0;
#endif
#endif
        } else {
            died = 0;
        }

        PROF_MARK(4);   // camera, end animation
        if (end_anim_state == END_ANIM_INACTIVE) {
            if (!died) update_camera_y();
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
            final_py = (int16_t)PLAYER_WORLD_Y() - (int16_t)cam_py;
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

        PROF_MARK(5);   // player sprite
        // Player sprite
        percent_hud_update(cam_px);
        uint8_t oam_index = PERCENT_HUD_OAM;   // slots 0..3: % display

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
            shadow_OAM[PERCENT_HUD_OAM].y = oy;
            shadow_OAM[PERCENT_HUD_OAM].x = ox;
            shadow_OAM[PERCENT_HUD_OAM].tile = tile;
            shadow_OAM[PERCENT_HUD_OAM].prop = prop;
            oam_index = PERCENT_HUD_OAM + 1;
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

        PROF_MARK(6);   // level sprites
        // Level sprites
        oam_index = draw_sprites(
            &active_sp, (uint16_t)((int16_t)cam_px + cur_shake_x), (uint16_t)((int16_t)cam_py + cur_shake_y),
            player.reversed, oam_index
        );
        if (practice_mode) {
            oam_index = practice_draw_checkpoints(oam_index, cam_px, cam_py, player.reversed);
        }
        oam_index = attempt_text_draw(oam_index, cam_px, cam_py);
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

        PROF_MARK(7);   // column job
        if (needs_render) {
            loaded_r = need_col;
            col_job_col = need_col;
            col_job_slot = (uint8_t)(need_col & 15);
            if (player.reversed) col_job_slot = (uint8_t)(-(int8_t)col_job_slot & 15);
            col_job_step = 0;
        }
        // VRAM uploads (DMG too): the VBlank handler writes them the moment VBlank starts. Done
        // by this thread after waking up, they could land outside VBlank when the music timer
        // interrupt ran first. A slice the handler has uploaded counts as done.
        if (col_job_issued && !bg_cj_pending) { col_job_issued = 0; col_job_step++; }
        if (col_job_step < COL_JOB_STEPS && !col_job_issued) {
            prepare_mt_column_slice(col_job_col, level_map, level_map_bank, player.reversed, col_job_step);
            request_mt_column_slice(col_job_slot, col_job_step);
            col_job_issued = 1;
        }

        PROF_MARK(8);   // band, parallax, palettes, row job requests
        uint8_t parallax_needed = 0;
        uint8_t bg_phase = 0;

        // Vertical streaming: move the VRAM band one row towards the camera when the row job is
        // idle. The new row is BAND_MARGIN rows away from the screen, and a row takes 2 frames
        // (16px) while the camera moves at most ~8px per frame.
        uint8_t cam_row = (uint8_t)(cam_py >> 4);
        if (row0_job_pos >= 16 && cam_row != band_cam_row) {
            uint8_t target_band = band_for_cam(cam_py, mt_band);
            if (target_band == mt_band) band_cam_row = cam_row;   // settled: skip until the camera row changes
            if (target_band != mt_band) {
                if (target_band > mt_band) {
                    row_job_row = (uint8_t)(mt_band + 16u);
                    mt_band++;
                } else {
                    mt_band--;
                    row_job_row = mt_band;
                }
                row0_job_pos = 0;
                row0_job_issued = 0;
                bg_rj_pending = 0;
                // a column slice already built is uploaded before the row job, which fixes it
                if (col_job_step < COL_JOB_STEPS) refetch_mt_column(level_map, level_map_bank);
            }
        }

        if (_cpu == CGB_TYPE) {
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

        // DMG: OBP0 follows the background palette, except on a black background (idx 3, every
        // shade -> black) where the player and objects keep their shades and only their black
        // outline turns white, so they stay visible. OBP1 (blue orbs/pads, gravity-down portals)
        // is OBP0 with shades 1 and 2 swapped (dmg_obp1).
        final_obp0 = (_cpu != CGB_TYPE && apply_idx == 3) ? DMG_OBP_ON_BLACK : final_bgp;
        final_obp1 = dmg_obp1(apply_idx, final_obp0);

        uint8_t final_scx = (uint8_t)((int16_t)scroll_px + cur_shake_x);
        uint8_t final_scy = (uint8_t)((int16_t)cam_py + cur_shake_y);

        // The parallax GDMA (768 bytes, ~1.9k dots) is executed by the VBlank
        // interrupt itself the instant VBlank starts (see bg_parallax_phases.c),
        // so it never depends on how late this thread wakes up.
        if (row0_job_issued && !bg_rj_pending) { row0_job_issued = 0; row0_job_pos += ROW_JOB_PER_FRAME; }
        if (row0_job_pos < 16 && !row0_job_issued) {
            request_row_slots(row0_job_pos, row_job_row, loaded_r, level_map, level_map_w, level_map_bank, player.reversed);
            row0_job_issued = 1;
        }
        if (bg_gdma_isr_on) {
            famidash_bg_fade_step();
            if (famidash_bkg_palettes_dirty) bg_pal_request = 1;
        }
        if (parallax_needed) request_bg_parallax(bg_phase);
        saw_anim_request();
        // Same for the scroll registers and the DMG palettes
        if (_cpu != CGB_TYPE) request_bg_dmg_pals(final_bgp, final_obp0, final_obp1);
        request_bg_scroll(final_scx, final_scy);
#if ENABLE_DEBUG_MODE
        if (debug_mode) {
            debug_ly = LY_REG;
            if (debug_ly > debug_max_ly) debug_max_ly = debug_ly;
        }
#endif
        PROF_MARK(9);   // waiting for VBlank
        bg_wait_vbl();
        PROF_MARK(10);  // after VBlank: DMG scroll / VRAM writes, saw animation

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
