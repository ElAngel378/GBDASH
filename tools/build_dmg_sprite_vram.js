const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");
const read = (name) => fs.readFileSync(path.join(ROOT, name));
const readText = (name) => read(name).toString("utf8");
const write = (name, data) => fs.writeFileSync(path.join(ROOT, name), data);

const PLAYER_TILE_COUNT = 12;
const SPRITE_TILE_BASE = 88;

// The source pairs used by the currently supported Famidash object IDs.
// Each entry is an NES 8x16 pair: the listed tile and the tile immediately after it.
const spritePairs = [
    ["portals", 0], ["portals", 2], ["portals", 4], ["portals", 6], ["portals", 8], ["portals", 10],
    ["portals", 44], ["portals", 46], ["portals", 50], ["portals", 52], ["portals", 56], ["portals", 58],
    ["main", 24], ["main", 26], ["main", 56], ["main", 58], ["portals", 24], ["portals", 26]
];

// Decoration pairs from Famidash's first decoration CHR bank. The source
// tile numbers are the start (even) tile of each NES 8x16 pair.
const decoPairs = [
    14, 8, 10, 12, 20, 22, 24, 26, 28, 30,
    32, 34, 36, 38, 44, 52, 48, 54
].map((tile) => ["blank", tile]);

function arrayBody(source, name) {
    const start = source.indexOf(`const uint8_t ${name}[`);
    if (start < 0) throw new Error(`missing ${name}`);
    const open = source.indexOf("{", start);
    const close = source.indexOf("};", open);
    return source.slice(open + 1, close);
}

function parseMetatileArray(source, name) {
    return [...arrayBody(source, name).matchAll(/\{\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}/g)]
        .map((match) => match.slice(1).map(Number));
}

function parseFlatArray(source, name) {
    return [...arrayBody(source, name).matchAll(/\d+/g)].map((match) => Number(match[0]));
}

function nesTileToGb(chr, tileIndex) {
    const offset = tileIndex * 16;
    const tile = Buffer.alloc(16);
    for (let row = 0; row < 8; row++) {
        tile[row * 2] = chr[offset + row];
        tile[row * 2 + 1] = chr[offset + 8 + row];
    }
    return tile;
}

function formatMetatileArray(name, values) {
    return [
        `const uint8_t ${name}[FAMIDASH_NUM_METATILES][4] = {`,
        ...values.map((row) => `    { ${row.join(", ")} },`),
        "};",
        ""
    ].join("\n");
}

function formatFlatArray(name, values) {
    const lines = [];
    for (let index = 0; index < values.length; index += 16) {
        lines.push(`    ${values.slice(index, index + 16).join(", ")},`);
    }
    return [`const uint8_t ${name}[FAMIDASH_NUM_METATILES] = {`, ...lines, "};", ""].join("\n");
}

const source = readText("include/famidash_metatiles.c");
const metatiles = parseMetatileArray(source, "metatiles");
const metatilesRev = parseMetatileArray(source, "metatiles_rev");
const palettes = parseFlatArray(source, "famidash_metatile_palettes");
const collision = parseFlatArray(source, "famidash_metatile_collision");
if (metatiles.length !== 256 || metatilesRev.length !== 256) throw new Error("expected 256 metatiles");

const usedMetatiles = new Set();
for (const file of fs.readdirSync(path.join(ROOT, "levels/level_data"))) {
    if (!file.endsWith("_16high.bin") || file === "template_16high.bin") continue;
    for (const id of read(`levels/level_data/${file}`)) usedMetatiles.add(id);
}

const usedSourceTiles = new Set();
for (const id of usedMetatiles) {
    for (const tile of metatiles[id]) usedSourceTiles.add(tile);
    for (const tile of metatilesRev[id]) usedSourceTiles.add(tile);
}

const sourceTiles = read("levels/chr_data/chr_gb_tiles.bin");
const sourceFlippedTiles = read("levels/chr_data/chr_gb_flipped_tiles.bin");
const compactTiles = Buffer.alloc(256 * 16);
const compactFlippedTiles = Buffer.alloc(256 * 16);
const tileMap = new Array(256).fill(PLAYER_TILE_COUNT);
const patternSlots = new Map();
let nextTile = PLAYER_TILE_COUNT;

for (const oldTile of [...usedSourceTiles].sort((a, b) => a - b)) {
    const start = oldTile * 16;
    const pattern = sourceTiles.subarray(start, start + 16);
    const key = pattern.toString("hex");
    let newTile = patternSlots.get(key);
    if (newTile === undefined) {
        newTile = nextTile++;
        patternSlots.set(key, newTile);
        pattern.copy(compactTiles, newTile * 16);
        sourceFlippedTiles.copy(compactFlippedTiles, newTile * 16, start, start + 16);
    }
    tileMap[oldTile] = newTile;
}

if (nextTile > SPRITE_TILE_BASE) {
    throw new Error(`background needs ${nextTile - PLAYER_TILE_COUNT} tiles; sprite VRAM starts at ${SPRITE_TILE_BASE}`);
}

const remap = (rows) => rows.map((row) => row.map((tile) => tileMap[tile]));
const compactMetatiles = [
    '#include "famidash_metatiles.h"',
    "",
    formatMetatileArray("metatiles", remap(metatiles)),
    formatMetatileArray("metatiles_rev", remap(metatilesRev)),
    formatFlatArray("famidash_metatile_palettes", palettes),
    formatFlatArray("famidash_metatile_collision", collision)
].join("\n");

const portalChr = read("famidash-main/GRAPHICS/Level Sprites/bankportals.chr");
const mainChr = read("famidash-main/GRAPHICS/Level Sprites/bankmain.chr");
const decoChr = read("famidash-main/GRAPHICS/Level Sprites/bankblank.chr");
const compactSprites = Buffer.alloc((spritePairs.length + decoPairs.length) * 2 * 16);
for (let index = 0; index < spritePairs.length; index++) {
    const [bank, tile] = spritePairs[index];
    const chr = bank === "portals" ? portalChr : mainChr;
    nesTileToGb(chr, tile).copy(compactSprites, index * 32);
    nesTileToGb(chr, tile + 1).copy(compactSprites, index * 32 + 16);
}
for (let index = 0; index < decoPairs.length; index++) {
    const [, tile] = decoPairs[index];
    const offset = (spritePairs.length + index) * 32;
    nesTileToGb(decoChr, tile).copy(compactSprites, offset);
    nesTileToGb(decoChr, tile + 1).copy(compactSprites, offset + 16);
}

write("levels/chr_data/chr_gb_dmg_tiles.bin", compactTiles);
write("levels/chr_data/chr_gb_dmg_flipped_tiles.bin", compactFlippedTiles);
write("levels/chr_data/famidash/famidash_sprites_dmg_tiles.bin", compactSprites);
write("include/famidash_metatiles_dmg.c", compactMetatiles);

console.log(`DMG background tiles: ${nextTile - PLAYER_TILE_COUNT} unique tiles`);
console.log(`DMG sprite tiles: ${compactSprites.length / 16} tiles at ${SPRITE_TILE_BASE}-${SPRITE_TILE_BASE + compactSprites.length / 16 - 1}`);
