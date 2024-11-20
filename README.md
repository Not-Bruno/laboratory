
![Logo](https://blog.tryhackme.com/content/images/2023/03/Content-Banner---updated.png)


# Pentesting Laboratory

#### << -- WORK IN PROGRES -- >>

This project provides a fully Docker-based penetration testing lab. It offers a flexible and modular solution for security and penetration testing in an isolated and controlled environment.

With the Setup file, users can quickly and easily configure and deploy the lab by selecting and launching the necessary containers. The configuration is modular, allowing various security tools, exploit servers, and target machines to be added or removed depending on the specific needs of each test. This makes the lab highly customizable for different penetration testing scenarios.

The pentest lab runs on Docker, enabling easy deployment and management of containers. The entire infrastructure is automatically set up through the setup script, eliminating the need for complex manual configuration. After the initial setup, the lab can be quickly started again using the Startup file to continue working.

Key Features:
- Modularity: Select only the containers needed for the current test.
- Easy Setup: The setup file allows quick and user-friendly configuration of the environment.
- Docker-based Containers: Uses Docker to create isolated and reproducible testing environments.
- Flexibility: Start and stop containers as needed to adapt the test scenarios.

This project provides a powerful, scalable, and easy-to-use platform for penetration testing and security training.

## Features
- <placeholder>


## Install requirements (only for Windows WSL)
For Windows you need to install WSL first. I recommend to user Ubuntu WSL.

Powershell
```bash
    wsl --install
    wsl --install -d Ubuntu
```

## Setup laboratory
You have to run the script as root. You can use 'sudo' or login as 'root'. Use the 'setup' file only the first time. After that, please use the 'startup' file.

!! NOTE: This script has only been tested with the package managers 'apt' and 'pacman' so far. Although it should theoretically work with other supported package managers, this has not yet been verified.

/bin/bash
```bash
   chmod +x ./setup
   sudo ./setup
```
or
```bash
   chmod +x ./startup
   sudo ./startup
```

## Usage/Examples

<WORK IN PROGRES>


## Support
<placeholder>


## Authors

- [@Not-Bruno](https://www.github.com/Not-Bruno)
