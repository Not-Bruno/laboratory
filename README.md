# Test Laboratory
Local docker Environment for testing und playing.

## Requirements
Windows
- docker Desktop v4.35.1 or higher
- better use docker inside WSL -> docker Engine 24.0.7 or higher

Linux 
- docker Engine 24.0.7 or higher

## Known Problems
> Ubuntu Container does not start 
> Metasploitable does not run on Docker Desktop

## Network
The local network is a Class C network. Since all containers are in the same network and should be able to see each other, subnetting is not an issue.

However, if you want to work with subnetting, it is necessary to switch to a Class B network. It also works with a Class C network, but in my opinion, it makes little sense, and the possibilities are greater with a Class B network.

## Ports
Windows             -> [Browser] {ip}:8006 or {localhost}:8006<br>
Ubuntu              -> ssh -p 22 root@{localhost}<br>
OWASP Juice Shop    -> [Browser] {ip}:3000 or {localhost}:3000<br>