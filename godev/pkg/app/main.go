package app

import (
	"{{DOCKER_APP_PATH}}/pkg/routegen"
)

func Init(args []string) string {
	if args[1] == "gen" && args[2] == "routes" {
		routegen.Start(args[4], args[6])
	}
	return args[0] + " starting ..."
}
