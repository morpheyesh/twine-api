package main

import (
"net/http"
  "fmt"
  handlers "github.com/morpheyesh/twine-api/handlers"
)

func Post(w http.ResponseWriter, req *http.Request) {
fmt.Println("worked")
handlers.Post()
}

func Show(w http.ResponseWriter, req *http.Request) {
fmt.Println("worked")
handlers.Show()
}
