FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

# Install essential tools
RUN apt-get update && \
    apt-get install -y \
    make \
    cmake \
    lsb-release \
    git \
    file \
    aptitude \
    python3 \
    python3-pip \
    wget \
    qemu-system \
    qemu-user \
    xz-utils \
    ruby \
    gcc \
    g++ \
    gperf \
    bison \
    flex \
    texinfo \
    help2man \
    libncurses5-dev \
    python3-dev \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    gawk \
    bzip2 \
    unzip \
    patch \
    libstdc++6 \
    rsync \
    libncursesw5-dev \
    diffstat \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3-pexpect \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    zstd \
    liblz4-tool \
    locales \
    fdisk \
    dosfstools \
    parted \
    libacl1 \
    ca-certificates \
    curl \
    gnupg \
    linux-headers-generic \
    && rm -rf /var/lib/apt/lists/*

# Install ARM and AArch64 cross-compilers separately to avoid conflicts
RUN apt-get update && \
    apt-get install -y \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8

# Install Docker
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Download and extract ARM GCC compiler
RUN wget -O gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2?rev=78196d3461ba4c9089a67b5f33edf82a&hash=D484B37FF37D6FC3597EBE2877FB666A41D5253B" && \
    mkdir -p /opt/compilers/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux && \
    tar xf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /opt/compilers/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux --strip-components=1 && \
    rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

# Download and extract ARM LINUX GNU Compiler
RUN wget -O gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz "https://releases.linaro.org/archive/15.02/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz" && \
    mkdir -p /opt/compilers/arm-linux-gnueabihf && \
    tar xf gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz -C /opt/compilers/arm-linux-gnueabihf --strip-components=1 && \
    rm gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz

# Install gcovr tool
RUN pip3 install gcovr==7.2

# Set the default command
CMD ["/bin/bash"]
