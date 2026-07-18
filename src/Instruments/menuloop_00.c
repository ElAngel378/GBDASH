#include "Instruments.h"

static void menuloop_00_trigger(uint8_t channel, uint8_t pitch, uint8_t volume)
{
}

static void menuloop_00_update(uint8_t channel, uint8_t pitch, uint8_t volume)
{
}

static void menuloop_00_step(uint8_t channel)
{
}

static void menuloop_00_init(uint8_t channel)
{
}

static void menuloop_00_override(uint8_t channel, uint8_t flags)
{
}

static void menuloop_00_release(uint8_t channel)
{
}

const Instrument menuloop_00 =
{
    menuloop_00_trigger,
    menuloop_00_update,
    menuloop_00_step,
    menuloop_00_init,
    menuloop_00_override,
    menuloop_00_release,
};