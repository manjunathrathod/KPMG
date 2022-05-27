package main

import (
	"encoding/json"
	"fmt"
)

func main() {

	data := `{ 
	"a": {
		"b": {
		"c":"d" 
		}
	}
}`
	Key := "a"

	type Inner struct {
		c string
	}
	type Outer struct {
		b Inner
	}
	type Outmost struct {
		a Outer
	}
	var cont1 Outmost
	var cont2 Outer
	var cont3 Inner

	if Key == "a" {
		json.Unmarshal([]byte(data), &cont1)
		fmt.Printf("%+v\n", cont1)
	} else if Key == "b" {
		json.Unmarshal([]byte(data), &cont2)
		fmt.Printf("%+v\n", cont2)
	} else {
		json.Unmarshal([]byte(data), &cont3)
		fmt.Printf("%+v\n", cont3)
	}

}
