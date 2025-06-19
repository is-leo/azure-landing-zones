1. The dnsLabelPrefix parameter is used to define the prefix for the DNS name associated with your Azure public IP addres. This allows you to access resources using a friendly DNS name instead of just the IP address.

2. AZ cli deployment command:
deployment group create --template-file bicep/custom-modules/publicIP/publicIp.bicep --parameters bicep/custom-modules/publicIP/parameters/publicIP.parameters.json