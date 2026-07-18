#include "Instruments.h"

static void INSTRUMENT_trigger(uint8_t channel, uint8_t pitch, uint8_t volume)
{
}

static void INSTRUMENT_update(uint8_t channel, uint8_t pitch, uint8_t volume)
{
}

static void INSTRUMENT_step(uint8_t channel)
{
}

static void INSTRUMENT_init(uint8_t channel)
{
}

static void INSTRUMENT_override(uint8_t channel, uint8_t flags)
{
}

static void INSTRUMENT_release(uint8_t channel)
{
}

const Instrument INSTRUMENT =
{
    INSTRUMENT_trigger,
    INSTRUMENT_update,
    INSTRUMENT_step,
    INSTRUMENT_init,
    INSTRUMENT_override,
    INSTRUMENT_release,
};