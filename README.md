# DeployAgent

### Using go modules
https://medium.com/mindorks/create-projects-independent-of-gopath-using-go-modules-802260cdfb51

To import package into project, add in import and run
```go build```

To run project ```go run src/main.go```

To build exe ```go build -o DeployAgent src/main.go```

sudo journalctl -f -u deployagent.service

chmod +x install.sh && chmod +x uninstall.sh && chmod +x prelaunch.sh