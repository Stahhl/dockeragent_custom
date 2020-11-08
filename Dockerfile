FROM ubuntu:18.04
ENV VERSION_ID=18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

#default https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        libssl1.0 

#powershell https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7
RUN apt-get install -y wget apt-transport-https \
&& wget -q https://packages.microsoft.com/config/ubuntu/${VERSION_ID}/packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt-get install -y software-properties-common \       
&& apt-get update \
&& add-apt-repository universe \
&& apt-get install -y powershell

# #podman https://podman.io/getting-started/installation
# RUN echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
# && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add - \
# && apt-get update \
# && apt-get -y upgrade \
# && apt-get -y install podman \
# && apt-get -y install podman-docker

#docker https://docs.docker.com/engine/install/ubuntu/#install-docker-engine
RUN apt-get remove docker docker-engine docker.io containerd runc \
&& apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -\  
&& add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" \ 
&& apt-get update \
&& apt-get install -y docker-ce \
&& apt-get install -y docker-ce-cli \
&& apt-get install containerd.io

#dotnet https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
#core 3.1 
RUN wget https://packages.microsoft.com/config/ubuntu/${VERSION_ID}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt-get update \
&& apt-get install -y apt-transport-https \
&& apt-get update \
&& apt-get install -y dotnet-sdk-3.1

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]