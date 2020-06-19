package server

import (
	"fmt"
	"net/http"
)

func Start(port int) error {
	router := NewRouter()
	return http.ListenAndServe(fmt.Sprintf(":%d", port), router)
}
