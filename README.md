# msg CXP - Team Starfleet

## Specification

### API

```mermaid
sequenceDiagram
    %% User
    actor User
    User->>+API: HTTP Call
    
    %% API
    participant API as https://host:8080/
    API-->>+API: Calculation
    API-->>User: HTTP Response
```

### Kubernetes Cluster

```mermaid
flowchart TB
    %% User
    user(User)
    
    %% Namespace
    subgraph namespace[Namespace 'cxp-team-starfleet']
        ingress
        service
        deployment
    end
    
    %% Cluster
    subgraph cluster["Cluster https://cxp.k8s.azure.msgoat.eu/"]

        namespace
        
        %% Ingress
        subgraph ingress[Ingress 'startship-registry-ingress']
            ingresspath("/startship-registry")
        end
        
        %% Service
        subgraph service[Service 'startfleet-registry-service']
            serviceapp(80:8080)
        end
        
        ingresspath -->|forward| serviceapp
        
        %% Deployment
        subgraph deployment[Deployment 'startfleet-registry']
            subgraph replicaset['ReplicaSet']
                replica1[API 1]
                replica2[API 2]
                replica3[API 3]
            end
        
        end
        
        subgraph registry[Docker Image Registry]
            Images
        end
        
        deployment -->|pull| registry

        serviceapp -->|forward| deployment
    end
    
    %% User access
    user -->|HTTP Call| ingress
```

## Implementations

### C#

```bash
export DOCKER_IMAGE=docker.cloudtrain.aws.msgoat.eu/cxp/starfleet/registry-number:1.0.0-csharp
docker build -t $DOCKER_IMAGE -f api-csharp/Dockerfile api-csharp
docker push $DOCKER_IMAGE
```

### TypeScript

```bash
export DOCKER_IMAGE=docker.cloudtrain.aws.msgoat.eu/cxp/starfleet/registry-number:1.0.0-typescript
docker build -t $DOCKER_IMAGE -f api-typescript/Dockerfile api-typescript
docker push $DOCKER_IMAGE
```
