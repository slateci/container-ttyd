For an overview of the overall sandbox setup, [see here](https://github.com/slateci/sandbox-portal).

# SLATE ttyd container

This repository contains the container for ([SLATE ttyd application](https://github.com/slateci/slate-ttyd)), which is the entrypoint for the container. The container packages all dependencies so that the SLATE client can be executed within the container, so that the terminal exposed through ttyd will allow to execute slate commands.

## Pushing changes

There are three ways to push changes to this container.

1) Any commit to the repository will force an automatic rebuild on Docker Hub

2) Build locally and push

```
git clone https://github.com/slateci/container-ttyd.git
cd container-ttyd
docker build .
docker push slateci/container-ttyd:latest
```

3) You can trigger the build on the Docker Hub [dashboard](https://hub.docker.com/repository/docker/slateci/container-ttyd/builds)
