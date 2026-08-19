import sys
import yaml

with open ("service.yaml") as f:
    data = yaml.safe_load(f)

with open("deployment.yaml", "r") as f:
    deployment_data = yaml.safe_load(f)

service_selector = data['spec']['selector']
deployment_selector = deployment_data['spec']['template']['metadata']['labels']
print("Service Selector:", service_selector)
print("Deployment Selector:", deployment_selector)

if service_selector != deployment_selector:
    print("Error: Service selector does not match Deployment selector.")
    sys.exit(1) 
else:
    print("Success: Service selector matches Deployment selector.")
    sys.exit(0)