git pull origin main# azure-landing-zones
Cegal AZL bicep modules for cloud customers.

 bicep/alz-main a Git submodule, which points to your forked ALZ-Bicep repo. It is up to date with Azure/ALZ-Bicep:main.

Whenever Microsoft updates ALZ-Bicep:

Go into your ALZ fork:
cd bicep/alz-main
git remote add upstream https://github.com/Azure/ALZ-Bicep.git
git fetch upstream
git merge upstream/main
git push origin  upstream
Now your fork is updated with the latest from Microsoft.

Then go back to your azure-landingzones repo root:
cd ../../../
git submodule update --remote bicep/alz-main
git commit -am "Update ALZ-Bicep submodule to latest upstream"
git push
This updates your main repo with the latest version of ALZ.
 