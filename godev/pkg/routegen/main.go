package routegen

import (
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"reflect"
	"fmt"
	"os"
)

const template = `
	Route{
		"%s",
		strings.ToUpper("%s"),
		"%s",
		handlers.%s,
	},

`

func Init(from string, to string) {
	fi, err := ioutil.Readfile(from)
	if err != nil {
	    panic(err)
	}
	fo, err := os.Create(to)
	if err != nil {
	    panic(err)
	}
	writeToFile(&fo, "var routes = Routes{")
	defer func() {
			writeToFile(&fo, "{")
	    if err := fo.Close(); err != nil {
	        panic(err)
	    }
	}()
	m := make(map[string]interface{})

	err := yaml.Unmarshal(fi, &m)
  if err != nil {
    panic(err)
  }
  for path, pathOb := range m["paths"] {
		for method, methodOb := range pathOb {
			writeToFile(&fo, fmt.Sprintf(template, methodOb["operationId"], method, path, methodOb["operationId"]) )
		}
  }
}
