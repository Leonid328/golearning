package main

import "fmt"

const (
	led1Interval = 200
	led2Interval = 500
	led3Interval = 1000
	durationMs   = 2000
)

func state(on bool) string {
	if on {
		return "ON"
	}
	return "OFF"
}

func main() {
	var last1, last2, last3 uint64
	var on1, on2, on3 bool

	fmt.Println("Superloop simulation (virtual millis)")
	fmt.Println("LED1 every 200 ms, LED2 every 500 ms, LED3 every 1000 ms")
	fmt.Println("duration: 2000 ms")
	fmt.Println()

	for now := uint64(0); now <= durationMs; now++ {
		if now-last1 >= led1Interval {
			last1 = now
			on1 = !on1
			fmt.Printf("t=%4d ms  LED1 -> %s\n", now, state(on1))
		}
		if now-last2 >= led2Interval {
			last2 = now
			on2 = !on2
			fmt.Printf("t=%4d ms  LED2 -> %s\n", now, state(on2))
		}
		if now-last3 >= led3Interval {
			last3 = now
			on3 = !on3
			fmt.Printf("t=%4d ms  LED3 -> %s\n", now, state(on3))
		}
	}
}
