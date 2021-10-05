package main

import (
	"net/http"
	"os"
	"fmt"
	"flag"
)

func main() {
	port := flag.String("p", "8080", "port")
	flag.Parse()
	path, _ := os.Getwd()
	fmt.Printf("listening on: http://localhost:%s/", *port)
	http.ListenAndServe(fmt.Sprintf(":%s", *port), http.FileServer(http.Dir(path)))
}
