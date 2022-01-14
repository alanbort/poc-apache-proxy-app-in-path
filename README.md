# PoC Apache Proxy app in path

This serves a static website on the host root and an application on a path:

`http://localhost:8080` will render a simple Hello World page.
`http://localhost:8080/app` will render a phpinfo() page.

## Requirements

Docker (Docker Desktop on Windows)
Docker Compose

## Usage

Use `docker-compose` to manage the environment.

```
docker-compose up -d
```

Clean up environment with

```
docker-compose down
docker system prune --all
```