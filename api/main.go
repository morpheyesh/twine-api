package main


import (
"net/http"
"github.com/bmizerany/pat"
"fmt"
)


const (
  AcctCreate = "/accounts"
  AcctShow = "/accounts/:email"

  DevicesCount = "/devices"

  EventsPost = "/events"
)

func main() {

  mux := pat.New()

  mux.Post(AcctCreate, http.HandlerFunc(Post))
  mux.Get(AcctShow, http.HandlerFunc(Show))
  mux.Get(DevicesCount, http.HandlerFunc(Devices))
  mux.Post(EventsPost, http.HandlerFunc(Events))

http.Handle("/", mux)
fmt.Println("[x] - Starting the server")
http.ListenAndServe(":8000", nil)

}
