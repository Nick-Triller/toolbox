# toolbox image

## Docker

```bash
# Run in background - default CMD is infinite sleep
docker run -d --name toolbox nicktriller/toolbox
docker exec -it toolbox bash

# Interactive
docker run -it --name toolbox --rm -v /var/run/docker.sock:/var/run/docker.sock -v /:/host --privileged nicktriller/toolbox bash
```

More useful flags:
- `--net=host`

## Kubernetes

```
TODO
```
