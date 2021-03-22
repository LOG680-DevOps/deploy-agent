# DeployAgent
The Deploy Agent give the ability to deploy docker container from DockerHub on any VM or computer.

## To Use
The agent has 3 http endpoits:
___
### url:32777/ping
To check if the agent is online & running

**Examples**
- http://ec2-23-95-154-24.compute-1.amazonaws.com:32777/ping
___
### url:32777/docker/<your_password>/ps
To get the list of running container

**Examples**
- http://ec2-23-95-154-24.compute-1.amazonaws.com:32777/docker/$DEPLOT_AGENT_PASSWORD/ps
___
### url:32777/docker/<your_password>/update
To install or update a container.
The command will download the image, stop and remove the container with the name provided if present and start the newly downloaded container.

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `dockerhub_repo` | required | string  | The dockerhub organisation where the contaienr is located <br/><br/> Example: RON_DEMERS |
|     `container_name` | required | string  | The name of the container to be runned <br/><br/>Example: hvac-controller |
|     `tag` | required | string  | The tag of the container to be runned <br/><br/>Example: latest |
|     `args` | optional | string  | Options to be added to the docker run command <br/><br/>Example: -p 327775:80 |

**Examples**
- http://ec2-23-95-154-24.compute-1.amazonaws.com:32777/docker/$DEPLOT_AGENT_PASSWORD/update?dockerhub_repo=pdemers&container_name=hvacsimulator&tag=latest
- http://ec2-23-95-154-24.compute-1.amazonaws.com:32777/docker/$DEPLOT_AGENT_PASSWORD/update?dockerhub_repo=pdemers&container_name=hvacsimulator&tag=latest&args=-p%2032775:80

## To Install
1. Install git using ```sudo yum install git -y```
2. Git clone the project in ```/home/ec2-user/```
3. Move into script folder ```cd deploy-agent/script/```
4. Open ```deployagent.service``` file using ```nano deployagent.service``` and set your password at the end of line ```ExecStart```. Save on exit.
5. Execute the command ```chmod +x install.sh```
6. Install the app using the command ```sudo ./install.sh```

## To Uninstall
1. Move into script folder ```cd deploy-agent/script/```
2. Execute the command ```chmod +x uninstall.sh```
3. Uninstall the app using the command ```sudo ./uninstall.sh```

## Commands
- To see logs ```sudo journalctl -f -u deployagent.service```
- To see service status ```sudo systemctl status deployagent.service```
- To restart systemctl ```sudo systemctl daemon-reload```
- To reset failted services ```sudo systemctl reset-failed```

## To Develop

> ! https://medium.com/mindorks/create-projects-independent-of-gopath-using-go-modules-802260cdfb51

To import package into project, add in import and run
```go build```

To run project ```go run src/main.go```

To build exe ```go build -o DeployAgent src/main.go```





