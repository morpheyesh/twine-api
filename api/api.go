package main


import (
"net/http"
"github.com/bmizerany/pat"
"github.com/handlers/accounts"


)


const (

  //Accounts
  AcctCreate = "/accounts/create"
  AcctShow = "/accounts/:email"

)

//All the routes
func main() {

  mux := pat.New()
  mux.Post(AcctCreate, http.HandlerFunc(accounts.Post))
  mux.Get(AcctShow, http.HandlerFunc(accounts.Show))

http.Handle("/", mux)
http.ListenAndServe(":8000", nil)

}
