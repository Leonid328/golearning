package main

import (
	"fmt"
	"os"
)

func main() {
	// os.Args[0] is the program path; the username is os.Args[1]
	if len(os.Args) < 2 {
		// print usage and exit if the name was not passed
		fmt.Fprintf(os.Stderr, "usage: %s <username>\n", os.Args[0])
		os.Exit(1)
	}

	username := os.Args[1]
	fmt.Printf("Hello, %s!\n", username)
}
