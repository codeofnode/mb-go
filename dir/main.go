package main

import (
	"{{DOCKER_APP_PATH}}/pkg/app"
	"{{DOCKER_APP_PATH}}/internal/server"
	"strconv"
	"os"
)

func main() {
	app.Init(os.Args)
	portStr, exists := os.LookupEnv("PORT")
	if !exists {
		portStr = "5823"
	}
	port, err := strconv.Atoi(portStr)
	if err != nil {
		panic("Env variable PORT is an invalid number!")
	}
	if port < 1 || port > 65535 {
		panic("Env variable PORT should be between 1 and 65535!")
	}
	server.Start(port)
}
