# msg David CXP

## Assignment 15

### Build & push

From within the `assignment-15` folder use one of the following two options to build & push the container images:

```bash
# csharp
export DOCKER_IMAGE=docker.cloudtrain.aws.msgoat.eu/cxp/starfleet/registry-number:1.0.0-csharp
docker build -t $DOCKER_IMAGE -f api-csharp/Dockerfile api-csharp
docker push $DOCKER_IMAGE

# typescript
export DOCKER_IMAGE=docker.cloudtrain.aws.msgoat.eu/cxp/starfleet/registry-number:1.0.0-typescript
docker build -t $DOCKER_IMAGE -f api-typescript/Dockerfile api-typescript
docker push $DOCKER_IMAGE
```
