#include <gb/gb.h>
#include "assets.h"
#include "player.h"

// This function resides in Bank 0.
// It safely handles switching to the portals bank and back.
// Optimized to use the sorted nature of the portal list.
void check_portals_banked(const Level* l, uint16_t col, Player* p, uint8_t* target_bg_idx) {
    uint8_t p_bank = l->portals_bank;
    const PortalDef* p_ptr = l->portals;

    if (p_bank == 0) return;

    uint8_t save_bank = _current_bank;
    SWITCH_ROM(p_bank);

    // Start searching from the last known portal index to avoid O(N) complexity every column
    p_ptr += p->portal_idx;

    // 1. Advance the pointer past any portals we might have skipped (safety/teleport)
    // or simply catch up to the current column.
    while (p_ptr->x != 0xFFFF && p_ptr->x < col) {
        p_ptr++;
        p->portal_idx++;
    }

    // 2. Process all portals at the current column.
    // We only check portals where x == col.
    while (p_ptr->x != 0xFFFF && p_ptr->x == col) {
        uint8_t obj = p_ptr->obj;
        if (obj == 0) p->mode = MODE_CUBE;
        else if (obj == 1) p->mode = MODE_SHIP;
        else if (obj == 8) {
            if (p->gravity_flipped) {
                p->gravity_flipped = 0;
                p->vel_y.w = 320;
            }
        }
        else if (obj == 9) {
            if (!p->gravity_flipped) {
                p->gravity_flipped = 1;
                p->vel_y.w = -320;
            }
        }
        else if (obj >= 100 && obj <= 103) {
            *target_bg_idx = obj - 100;
        }

        p_ptr++;
        p->portal_idx++;
    }

    SWITCH_ROM(save_bank);
}
