# Running PowerDNS Recursor in Docker

These are the files required to run PowerDNS Recursor in a Docker container. It includes configurations for both single-instance and multi-instance deployments.

## Files Overview

- **Dockerfile**: For Building the PowerDNS Recursor container.
- **docker-compose.yaml**: Docker Compose configuration for deployment.
- **powerdns/recursor.conf**: Configuration file for PowerDNS Recursor.

## Usage

### Build the Docker Image
```sh
docker build -t local/pdns-recursor .
```

### Run Instance
```sh
docker-compose -f docker-compose.yaml up -d
```

## Configuration
Modify `powerdns/recursor.conf` to customize your PowerDNS Recursor setup. Ensure that necessary ports are exposed in the Compose files.

## Notes
- Ensure the configuration files have the correct permissions.
- Ensure the image tag is correct.
- Adjust networking settings if running multiple instances.
- Logs can be accessed using:
  ```sh
  docker logs -f <container_name>
  ```
- To enable IPv6 support, add the following example to `/etc/docker/daemon.json`:
  ```json
  {
    "ipv6": true,
    "fixed-cidr-v6": "fd7e:1768:1379::/64",
    "default-address-pools": [
      { "base": "172.17.0.0/16", "size": 16 },
      { "base": "172.18.0.0/16", "size": 16 },
      { "base": "172.19.0.0/16", "size": 16 },
      { "base": "172.20.0.0/14", "size": 16 },
      { "base": "172.24.0.0/14", "size": 16 },
      { "base": "172.28.0.0/14", "size": 16 },
      { "base": "192.168.0.0/16", "size": 20 },
      { "base": "fd7e:1768:1379::/48", "size": 64 }
    ]
  }
  ```
