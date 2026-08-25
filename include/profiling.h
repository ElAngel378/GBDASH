#ifndef PROFILING_H
#define PROFILING_H

#include <stdint.h>

// Lightweight counters for profiling and diagnostics
extern volatile uint16_t prof_vbl_enter_count;
extern volatile uint16_t prof_tim_enter_count;
extern volatile uint16_t prof_mirror_transitions;
extern volatile uint16_t prof_column_changed_count;

#endif // PROFILING_H
