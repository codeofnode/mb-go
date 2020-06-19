package main
 
import (
	"{{DOCKER_APP_PATH}}/pkg/app"
	"os"
)

func main() {
	app.Init(os.Args)
}
