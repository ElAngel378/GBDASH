# Port Portal Switching Logic from FamiDash

This plan ports the portal transition physics and camera smoothing from FamiDash to the GBC demake. This includes velocity adjustments when changing gamemodes and a "camera catch-up" timer to prevent jarring vertical snaps.

## Proposed Changes

### [Player Component]

#### [MODIFY] [player.h](file:///C:/Users/soter/Source/Repos/GBDASH/include/player.h)
- Add `uint8_t exit_timer` to the `Player` struct.
- Add `MODE_UFO` (3) constant.

#### [MODIFY] [player.c](file:///C:/Users/soter/Source/Repos/GBDASH/src/player.c)
- Initialize `exit_timer = 0` in `player_init`.
- (Optional) Implement UFO physics if desired, but focus on the portal transitions first.

### [Gameplay Component]

#### [MODIFY] [gameplay.c](file:///C:/Users/soter/Source/Repos/GBDASH/src/gameplay.c)
- Add `#define OBJ_UFO_PORTAL 3`.
- Update the portal collision switch:
    - On mode switch: halve vertical velocity (`vel_y.w >>= 1`) if entering Ship/Ball/UFO.
    - Zero vertical velocity if entering Cube.
    - Set `player.exit_timer = 10`.
- Update the camera logic:
    - If `player.exit_timer > 0`:
        - Decrement the timer.
        - Cap the vertical camera movement per frame based on the timer value (using the `11 - timer` logic from FamiDash).
    - This will make the camera "slide" into position instead of jumping instantly when exiting a portal.

## Verification Plan

### Automated Tests
- Build the project using `make` to ensure no syntax errors.

### Manual Verification
- Test portal transitions in-game:
    - Verify that vertical momentum is halved when entering a Ship portal.
    - Verify that the camera doesn't "snap" instantly to the player's new height after a portal, but instead slides smoothly.
