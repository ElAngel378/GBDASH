const fs = require("fs");

const [input, output] = process.argv.slice(2);
if (!input || !output) {
    throw new Error("usage: node tools/mirror_gb_tiles.js <input.bin> <output.bin>");
}

const source = fs.readFileSync(input);
const mirrored = Buffer.alloc(source.length);

for (let offset = 0; offset < source.length; offset += 2) {
    for (let bit = 0; bit < 8; bit++) {
        mirrored[offset] |= ((source[offset] >> bit) & 1) << (7 - bit);
        mirrored[offset + 1] |= ((source[offset + 1] >> bit) & 1) << (7 - bit);
    }
}

fs.writeFileSync(output, mirrored);
