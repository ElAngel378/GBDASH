#pragma bank 100
#include <gbdk/incbin.h>
#include <stdint.h>

// This pulls in the binary data directly into the ROM
INCBIN(logo_tiles, "Logo.chr")
