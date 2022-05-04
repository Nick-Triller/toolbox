FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
ARG CRICTL_VERSION="v1.23.0"

# Force color in .bashrc
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc  && \
    apt-get update -qq && \
      apt-get install -y \
      # Simple init system used as PID 1 in container
      dumb-init \
      # Add add-apt-repository
      software-properties-common \
      # Docker dependencies
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
      apt-transport-https \
      gnupg2 \
      # Manuals
      man \
      manpages-posix && \
    # Install docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get install -y docker-ce && \
    # Install crictl
    curl -SsL https://github.com/kubernetes-sigs/cri-tools/releases/download/$CRICTL_VERSION/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz --output crictl-${CRICTL_VERSION}-linux-amd64.tar.gz && \
    tar zxvf crictl-$CRICTL_VERSION-linux-amd64.tar.gz -C /usr/local/bin && \
    rm -f crictl-$CRICTL_VERSION-linux-amd64.tar.gz && \
    rm -rf /var/lib/apt/lists/*


# Debugging tools
RUN apt-get update -qq && apt-get install -y \
  tcpdump \
  vim \
  tmux \
  atop \
  htop \
  dstat \
  jq \
  # dig, nslookup, nsupdate
  dnsutils \
  tcpdump \
  traceroute \
  iputils-ping \
  # arp, hostname, ifconfig, netstat, rarp, route, plipconfig, slattach, mii-tool, iptunnel and ipmaddr
  net-tools \
  netcat \
  iproute2 \
  strace \
  telnet \
  conntrack \
  nmap \
  git \
  socat \
  lsof && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sleep", "infinity"]
