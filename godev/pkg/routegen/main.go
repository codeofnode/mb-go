package routegen

import (
	"fmt"
	"io/ioutil"
	"os"
	"reflect"

	"gopkg.in/yaml.v2"
)

const template = `
        Route{
                "%s",
                strings.ToUpper("%s"),
                "%s",
                handlers.%s,
        },
`

func writeToFile(fo *os.File, data string) {
	cont := []byte(data)
	if _, err := fo.Write(cont); err != nil {
		panic(err)
	}
}

func printVal(fo *os.File, v interface{}, k string, depth int, paths []string) {
	typ := reflect.TypeOf(v).Kind()
	ln := len(paths)
	if typ == reflect.Int || typ == reflect.String {
		if k == "operationId" {
			writeToFile(fo, fmt.Sprintf(template, v, paths[1], paths[0], v))
		}
	} else if typ == reflect.Map {
		if k == "paths" || k[0] == '/' || (ln > 0 && paths[ln-1][0] == '/') {
			if len(paths) != 2 && k != "paths" {
				paths = append(paths, k)
			}
			printMap(fo, v.(map[interface{}]interface{}), k, depth+1, paths)
			if ln > 0 {
				paths = paths[:ln-1]
			}
		}
	}
}

func printMap(fo *os.File, m map[interface{}]interface{}, k string, depth int, paths []string) {
	for kk, v := range m {
		printVal(fo, v, kk.(string), depth+1, paths)
	}
}

func Init(from string, to string) {
	fi, err := ioutil.ReadFile(from)
	if err != nil {
		panic(err)
	}
	fo, err := os.OpenFile(to, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		panic(err)
	}
	writeToFile(fo, "var routes = Routes{")
	defer func() {
		writeToFile(fo, "{")
		if err := fo.Close(); err != nil {
			panic(err)
		}
	}()
	m := make(map[string]interface{})
	er := yaml.Unmarshal(fi, &m)
	if er != nil {
		panic(er)
	}
	for k, v := range m {
		printVal(fo, v, k, 1, []string{})
	}
}
