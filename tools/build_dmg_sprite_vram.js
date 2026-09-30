const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");
const read = (name) => fs.readFileSync(path.join(ROOT, name));
const write = (name, data) => fs.writeFileSync(path.join(ROOT, name), data);

const SPRITE_TILE_BASE = 160;

// The source pairs used by the currently supported Famidash object IDs.
// Each entry is an NES 8x16 pair: the listed tile and the tile immediately after it.
const spritePairs = [
    ["portals", 0], ["portals", 2], ["portals", 4], ["portals", 6], ["portals", 8], ["portals", 10],
    ["portals", 44], ["portals", 46], ["portals", 50], ["portals", 52], ["portals", 56], ["portals", 58],
    ["main", 24], ["main", 26], ["main", 56], ["main", 58], ["portals", 24], ["portals", 26],
    ["portals", 12], ["portals", 14], ["portals", 16], ["portals", 18], ["portals", 20], ["portals", 22]
];

// Decoration pairs from Famidash's first decoration CHR bank. The source
// tile numbers are the start (even) tile of each NES 8x16 pair.
const decoPairs = [
    14, 8, 10, 12, 20, 22, 24, 26, 28, 30,
    32, 34, 36, 38, 44, 52, 48, 54, 40, 42
].map((tile) => ["blank", tile]);

function nesTileToGb(chr, tileIndex) {
    const offset = tileIndex * 16;
    const tile = Buffer.alloc(16);
    for (let row = 0; row < 8; row++) {
        tile[row * 2] = chr[offset + row];
        tile[row * 2 + 1] = chr[offset + 8 + row];
    }
    return tile;
}

// (The background tile / metatile packing that was here is now tools/build_bg_tiles.py,
// from levels/chr_data/bg_tiles.png.)

const portalChr = read("famidash-main/GRAPHICS/Level Sprites/bankportals.chr");
const mainChr = read("famidash-main/GRAPHICS/Level Sprites/bankmain.chr");
const decoChr = read("famidash-main/GRAPHICS/Level Sprites/bankblank.chr");
const chainChr = read("chain block.chr");
const chainTileOrder = [0, 16, 1, 17, 32, 48, 33, 49];
if (chainChr.length < (Math.max(...chainTileOrder) + 1) * 16) {
    throw new Error("chain block CHR is missing the 16x32 graphic tiles");
}
const mirrorPortalsBin = read("levels/chr_data/mirror_portals.bin");
const MIRROR_PORTAL_TILES = 32; // 16 tiles entrance (48..63), 16 tiles exit (64..79)
if (mirrorPortalsBin.length !== MIRROR_PORTAL_TILES * 16) {
    throw new Error(`expected mirror_portals.bin to be ${MIRROR_PORTAL_TILES * 16} bytes, got ${mirrorPortalsBin.length}`);
}

// Bank 0 sprites: 24 pairs (48 tiles) + 32 mirror portal tiles + 8 chain block tiles = 88 tiles
const compactSprites = Buffer.alloc(spritePairs.length * 32 + mirrorPortalsBin.length + chainTileOrder.length * 16);

// 1. Core gameplay sprites (pads, orbs, portals) at offset 0..47 tiles
for (let index = 0; index < spritePairs.length; index++) {
    const [bank, tile] = spritePairs[index];
    const chr = bank === "portals" ? portalChr : mainChr;
    nesTileToGb(chr, tile).copy(compactSprites, index * 32);
    nesTileToGb(chr, tile + 1).copy(compactSprites, index * 32 + 16);
}

// 2. Mirror Portals at offset 48..79 tiles (Entrance: 48..63, Exit: 64..79)
const mirrorOffset = spritePairs.length * 32;
mirrorPortalsBin.copy(compactSprites, mirrorOffset);

// 3. Chain block at offset 80..87 tiles
const chainOffset = mirrorOffset + mirrorPortalsBin.length;
for (let index = 0; index < chainTileOrder.length; index++) {
    chainChr.copy(compactSprites, chainOffset + index * 16,
        chainTileOrder[index] * 16, chainTileOrder[index] * 16 + 16);
}

// Bank 1 sprites (CGB only decorations: 18 pairs = 36 tiles)
const compactDeco = Buffer.alloc(decoPairs.length * 32);
for (let index = 0; index < decoPairs.length; index++) {
    const [, tile] = decoPairs[index];
    const offset = index * 32;
    nesTileToGb(decoChr, tile).copy(compactDeco, offset);
    nesTileToGb(decoChr, tile + 1).copy(compactDeco, offset + 16);
}

write("levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin", compactSprites);
write("levels/chr_data/famidash/famidash_deco_cgb_tiles.bin", compactDeco);

console.log(`DMG sprite tiles: ${compactSprites.length / 16} tiles at ${SPRITE_TILE_BASE}-${SPRITE_TILE_BASE + compactSprites.length / 16 - 1}`);
console.log(`CGB deco tiles: ${compactDeco.length / 16} tiles for VRAM Bank 1`);
