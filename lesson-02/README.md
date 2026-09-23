# Superloop and independent tasks

Three LEDs blink independently in one `loop()`, without blocking.

| LED  | Pin | Interval |
|------|-----|----------|
| LED1 | 8   | 200 ms   |
| LED2 | 9   | 500 ms   |
| LED3 | 10  | 1000 ms  |

Rules:

- no `delay()`
- no `while()` waiting for time inside `loop()`
- timing with `millis()`

## Wiring

- LED1 -> pin 8 (resistor 220 ohm to GND)
- LED2 -> pin 9
- LED3 -> pin 10

## Arduino

Open `superloop_leds/superloop_leds.ino` in Arduino IDE, select the board, upload.

## Simulation (no hardware)

This prints the same toggle schedule as the sketch, using a virtual `millis()` clock.

From the repository root:

```bash
go run ./lesson-02/simulate
```

From this folder:

```bash
go run ./simulate
```

Saved output: [results/execution.txt](results/execution.txt)
