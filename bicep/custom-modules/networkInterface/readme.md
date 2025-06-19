1. Replace values in networkInterface parameters file (like "myVnet", "mySubnet", "myInfraResourceGroup", etc.) with your actual resource names and configurations.

Set "createPublicIP": false if you do not want a public IP created.

2. Az cli deployment command: 
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file <your-bicep-file>.bicep \
  --parameters @<your-parameters-file>.json