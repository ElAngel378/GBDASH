#pragma bank 248
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 1;
static const unsigned char P0[] = { 0, 1, 0 }; // Minimal pattern

static const unsigned char* const order1[] = {P0};
static const unsigned char* const order2[] = {P0};
static const unsigned char* const order3[] = {P0};
static const unsigned char* const order4[] = {P0};

static const hUGEDutyInstr_t duty_instruments[] = { {0,0,0,0,0} };
static const hUGEWaveInstr_t wave_instruments[] = { {0,0,0,0,0} };
static const hUGENoiseInstr_t noise_instruments[] = { {0,0,0,0} };
static const unsigned char waves[] = { 0 };

const hUGESong_t timemachine = {6, &order_cnt, order1, order2, order3, order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
