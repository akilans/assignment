/*
A sample application to print “Welcome to 2022”and user agent info
Add a health check endpoint to configure liveness and readiness probe in k8s
*/

package main

// Import necessary packages
import (
	"fmt"
	"net/http"
	"os"
)

// get port from env variable
var port string = os.Getenv("PORT")

// handler for / route
func welcomeHandler(w http.ResponseWriter, req *http.Request) {
	userAgent := req.UserAgent()
	fmt.Fprintf(w, "<html><title>Home</title><body><h1>Welcome to 2022</h1><h3>UserAgent:: %s</h3></body></html>", userAgent)
}

// handler for /health route
func healthHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, "<html><title>Health Check</title><body><h1>Healthy</h1></body></html>")
}

// main function
func main() {
	// define routes
	http.HandleFunc("/", welcomeHandler)
	http.HandleFunc("/health", healthHandler)

	// If the port env not set assign default port
	if port != "" {
		fmt.Println("App is running on port", port)
		http.ListenAndServe(port, nil)
	} else {
		fmt.Println("App is running on port :8080")
		http.ListenAndServe(":8080", nil)
	}

}
