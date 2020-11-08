Dockerfile and start script for self-hosted azure devops agent in Docker. 

With some custom stuff installed:
- Powershell Core
- docker
- dotnet core sdk 3.1

docker run -v /var/run/docker.sock:/var/run/docker.sock -e AZP_URL=<URL> -e AZP_TOKEN=<TOKEN> -e AZP_POOL=<poolName> -e AZP_AGENT_NAME=<agentName> <imageName>:<tag>

https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops

https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7

https://podman.io/getting-started/installation
