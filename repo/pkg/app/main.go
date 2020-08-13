package app

import (
	"fmt"
)

func Init(args []string) string {
	fmt.Println(args[0] + " starting ...")
	return args[0] + " starting ..."
}
