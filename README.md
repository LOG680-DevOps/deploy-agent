# DeployAgent

## To Develop

> ! https://medium.com/mindorks/create-projects-independent-of-gopath-using-go-modules-802260cdfb51

To import package into project, add in import and run
```go build```

To run project ```go run src/main.go```

To build exe ```go build -o DeployAgent src/main.go```

## To Install
1. Git clone the project in ```/home/ec2-user/```
2. Move into script folder ```cd deploy-agent/script/```
3. Open ```deployagent.service``` file using ```nano deployagent.service``` and set your password at the end of line ```ExecStart```. Save on exit.
4. Execute the command ```chmod +x install.sh```
5. Install the app using the command ```sudo ./install.sh```

## To Uninstall
1. Move into script folder ```cd deploy-agent/script/```
2. Execute the command ```chmod +x uninstall.sh```
3. Uninstall the app using the command ```sudo ./uninstall.sh```

## Commands
- To see logs ```sudo journalctl -f -u deployagent.service```
- To see service status ```sudo systemctl status deployagent.service```
- To restart systemctl ```sudo systemctl daemon-reload```
- To reset failted services ```sudo systemctl reset-failed```




