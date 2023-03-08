Session: 2023-01-20 Kubernetes III, Helm I, Cluster Tool Stacks I

Agenda
 - Presentation of assignments (Team ToBeDefined, Team Brokkoli)
 - Presentation: Helm
  (see: https://d11ec2722rad1b.cloudfront.net/helm/index.html)
 - Hand-out of assignments
 - Wrap-up

TODOs
- Assignment 15: Install your containerized application on Kubernetes using Kubernetes manifests and kubectl apply (all teams)
     Acceptance Criteria:
        - Application is deployed to  your team namespace on the CXP cluster
        - Application is accessible via https://cxp.k8s.azure.msgoat.eu/<k8s-namespace>/<k8s-service>
        (e.g. https://cxp.k8s.azure.msgoat.eu/cxp-team-miket92/cxp-hello-miket92)
- Assignment 16: Install your containerized application on Kubernetes using Helm (all teams)
  Please remember to uninstall previous deployment with kubectl delete first!!!
    Acceptance Criteria:
        - Application is deployed to  your team namespace on the CXP cluster
        - Application is accessible via https://cxp.k8s.azure.msgoat.eu/<k8s-namespace>/<k8s-service>(e.g. https://cxp.k8s.azure.msgoat.eu/cxp-team-miket92/cxp-hello-miket92)
- Assignment 17: Add a PodDisruptionBudget, a HorizontalPodAutoscaler and a ServiceAccount to your Helm chart and redeploy your containerized application to Kubernetes using Helm (all teams)
    Acceptance Criteria:
        - Application is deployed to  your team namespace on the CXP cluster
        - Application is accessible via https://cxp.k8s.azure.msgoat.eu/<k8s-namespace>/<k8s-service>(e.g. https://cxp.k8s.azure.msgoat.eu/cxp-team-miket92/cxp-hello)
