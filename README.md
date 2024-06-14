# Embedded Linux Docker Environment

### Table of Contents
- [Introduction](#Introduction)
- [Get Started](#get-started)
- [Features](#features)
- [Environment](#environment)
- [Usage](#Usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Welcome to the Embedded Linux Docker Environment project! This project is designed to create a comprehensive development environment tailored for embedded Linux and Linux From Scratch (LFS) development. By leveraging Docker-in-Docker (DinD) technology, I provide a consistent and reproducible environment that ensures seamless development, testing, and deployment processes. My environment encapsulates all necessary tools and dependencies, streamlining the setup process and reducing the overhead associated with configuring individual systems.

### Get Started 

1. Clone the Repo
```bash
git clone https://github.com/mohamedashraf-eng/my-linux-cots.git && 
git checkout advanced_embedded_linux_cots &&
cd embedded-linux-docker-environment
```

2. Run the install script
```bash
source ./install.sh
```

3. Start Developing: Once the environment is set up, you can start developing your embedded Linux projects with all necessary tools readily available.

This script is located in the doc/utils/ directory. Running this script will initiate the environment setup, pulling all necessary Docker images, installing dependencies, and configuring the environment to suit the needs of embedded Linux development.

For the `docs/bashs` it contains a collection of useful bash scripts that can be used to automate the setup process.

### Features
- **Comprehensive Toolchain:** Includes all the essential tools and compilers required for embedded Linux development, such as GCC, binutils, make, and more.
- **Docker-in-Docker (DinD):** Utilizes Docker-in-Docker to ensure an isolated and reproducible development environment.
- **Automated Setup:** The install.sh script automates the installation and configuration process, reducing setup time and minimizing errors.
- **Support for Multiple Architectures:** Preconfigured to support various architectures commonly used in embedded systems, including ARM.
- **Validated Environment:** Ensures that all repositories and dependencies are correctly cloned and installed, providing a reliable development setup.

### Environment
| Component                          | Usage                      | Completed |
|------------------------------------|----------------------------|-----------|
| Docker                             | Containerization           | ☑️         |
| Docker Compose                     | Container orchestration    | ☑️         |
| Docker-in-docker                   | Docker inside a docker     | ☑️         |
| GCC                                | Native Compiler                   | ☑️         |
| Binutils                           | Binary utilities           | ☑️         |
| Make                               | Build automation           | ☑️         |
| CMake                              | Build system               | ☑️         |
| Git                                | Version control            | ☑️         |
| QEMU                               | Emulator                   | ☑️         |
| Crossng                            | Toolchain builder                 | ☑️         |
| Busybox                            | Unix utilities             | ☑️         |
| U-Boot                             | Bootloader                 | ☑️         |
| GRUB                             | Bootloader                 | ☑️         |
| Linux Kernel                       | Operating system kernel    | ☑️         |
| Yocto Project                      | Build system               | ☑️         |
| Cross-compilation tools (arm-linux-gnueabihf) | Cross-compiling       | ☑️         |

## Usage

To get started with building and setting up the environment, simply run the following command:

```bash
cd doc/utils &&
source ./install.sh
```

By following these steps, you can quickly and efficiently set up a robust development environment tailored for embedded Linux projects. This environment is designed to streamline your workflow, reduce setup complexities, and provide a consistent platform for all your development needs.

## License
MIT License Copyright (c) 2024, MoWx
