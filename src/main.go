package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"runtime"
	"strings"

	"github.com/gin-gonic/gin"
)

var password string

const DEPLOY_FILEPATH = "./script/deploy.sh"
const VERSION = "v0.1"

func main() {
	fmt.Println("Deploy Agent ! ", VERSION)
	fmt.Println("--------------")

	flag.StringVar(&password, "password", "", "")
	flag.Parse()

	if password == "" {
		password = os.Getenv("DEPLOY_AGENT_PASSWORD")
		if password == "" {
			fmt.Println("Please set a password using flag\n\t -password <your_password> or environment variable DEPLOY_AGENT_PASSWORD")
			return
		}
	}
	fmt.Printf("Password: %s\n", password)
	if runtime.GOOS != "windows" {
		ChmodFile(DEPLOY_FILEPATH)
	}

	r := gin.Default()
	r.GET("/ping", getHealtchCheck)
	r.GET("/docker/:password/ps", getDockerPs)
	r.GET("/docker/:password/update", getDockerUpdate)
	r.Run(":32777")
}

func ChmodFile(filepath string) {
	cmd := exec.Command("chmod", "777", filepath)

	if output, err := cmd.Output(); err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Printf("Output: %s\n", output)
	}
}

func getHealtchCheck(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"message": "All system operational commander !"})
}

func getDockerPs(c *gin.Context) {
	cmd := exec.Command("docker", "ps", "--all")

	var result []string
	if output, err := cmd.CombinedOutput(); err != nil {
		fmt.Println("Error:", err)
		c.JSON(http.StatusOK, gin.H{"message": err})
		return
	} else {
		fmt.Printf("Output: %s\n", output)
		result = strings.SplitAfter(string(output), "\n")
	}

	c.JSON(http.StatusOK, gin.H{"message": result})
}

func getDockerUpdate(c *gin.Context) {
	if password != c.Param("password") {
		c.JSON(http.StatusOK, gin.H{"error": "wrong password"})
		return
	}

	dockerhub_repo := c.Query("dockerhub_repo")
	container_name := c.Query("container_name")
	tag := c.Query("tag")
	args := c.Query("args")
	if dockerhub_repo == "" {
		c.JSON(http.StatusOK, gin.H{"error": "missing dockerhub_repo argument"})
		return
	}
	if container_name == "" {
		c.JSON(http.StatusOK, gin.H{"error": "missing container_name argument"})
		return
	}
	if tag == "" {
		c.JSON(http.StatusOK, gin.H{"error": "missing tag argument"})
		return
	}

	var cmd *exec.Cmd
	if args == "" {
		cmd = exec.Command("bash", DEPLOY_FILEPATH, dockerhub_repo, container_name, tag)
	} else {
		cmd = exec.Command("bash", DEPLOY_FILEPATH, dockerhub_repo, container_name, tag, args)
	}

	var result []string
	if output, err := cmd.CombinedOutput(); err != nil {
		fmt.Printf("Output: %s\n", output)
		fmt.Println("Error:", err)
		result = strings.SplitAfter(string(output), "\n")
		c.JSON(http.StatusOK, gin.H{"error": err.Error(), "message": result})
		return
	} else {
		fmt.Printf("Output: %s\n", output)
		result = strings.SplitAfter(string(output), "\n")
	}

	c.JSON(http.StatusOK, gin.H{"message": result})
}
