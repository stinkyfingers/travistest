package main

import (
	"fmt"
)

var unused string

func main() {
	fmt.Println("testing travis")
	makeErr("an err")
}

func makeErr(s string) error {
	return fmt.Errorf("this is an error: %s", s)
}
