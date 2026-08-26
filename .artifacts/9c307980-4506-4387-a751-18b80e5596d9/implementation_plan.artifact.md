# Import Ball Sprite from NES CHR

This plan describes how to import the Ball icon from the NES-formatted `.chr` file and integrate it into the GBDK project for use in `MODE_BALL`.

## User Review Required

> [!NOTE]
> The `.chr` file is currently in NES format (Planar 2bpp), while Game Boy requires Interleaved 2bpp. I have included a conversion step in the process.

## Proposed Changes

### [Sprite Assets]

Summary of new files for the ball sprite.

#### [NEW] [ball.c](file:///C:/Users/soter/Source/Repos/GBDASH/src/ball.c)
Contains the converted tile data and the metasprite definition for the ball.

#### [NEW] [ball.h](file:///C:/Users/soter/Source/Repos/GBDASH/include/ball.h)
Header for referencing the ball tiles and metasprites.

---

### [Gameplay Integration]

#### [MODIFY] [gameplay.c](file:///C:/Users/soter/Source/Repos/GBDASH/src/gameplay.c)
- Include `ball.h`.
- Load `ball_tiles` into VRAM during level initialization.
- Update the sprite rendering logic to use `ball_metasprites` when the player is in `MODE_BALL`.

## Verification Plan

### Manual Verification
- Check if the Ball sprite appears correctly when the player enters a Ball portal or starts a level in Ball mode.
- Verify that the sprite is correctly aligned and flipped when gravity changes.
