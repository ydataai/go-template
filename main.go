package main

import (
	"os"

	log "github.com/sirupsen/logrus"
)

func calc(a int, b int) int {
	return a + b*2
}

func main() {
	log.Info("Welcome to my shinny app boilerplate.")
	log.Infof("Did you know that 2 + 2 is %d?", calc(2, 2))
	log.Infof("Also, did I mention that I have ENV Vars? For instance, VAR is %s", os.Getenv("VAR"))
}
