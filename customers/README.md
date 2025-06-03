Use deploy.bicep as an wrapper to orchestrate ALZ, app zones, and policies deployment.

Each customer folder contains its own deployment files and parameters.

az deployment mg create \
  --template-file customers/customerA/deploy.bicep \
  --parameters customers/customerA/parameters.bicepparam