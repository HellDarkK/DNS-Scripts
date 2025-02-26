# Running PowerDNS Recursor in Docker

These are the files required to run PowerDNS Recursor in a Docker container. It includes configurations for both single-instance and multi-instance deployments.

## Files Overview

- **Dockerfile**: For Building the PowerDNS Recursor container.
- **docker-compose-single.yaml**: Docker Compose configuration for a single-instance deployment.
- **docker-compose-multi.yaml**: Docker Compose configuration for multi-instance deployment.
- **powerdns/recursor.conf**: Configuration file for PowerDNS Recursor.

## Usage

### Build the Docker Image
```sh
docker build -t local/pdns-recursor .
```

### Run a Single Instance
```sh
docker-compose -f docker-compose-single.yaml up -d
```

### Run Multiple Instances
```sh
docker-compose -f docker-compose-multi.yaml up -d
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

