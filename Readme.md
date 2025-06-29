# Azure Node.js Web App

Eksempelapplikation til deployment på Azure Web App.

## Sådan bruger du projektet

```bash
# Klon repo
git clone https://github.com/DIT_BRUGERNAVN/azure-nodejs-webapp.git
cd azure-nodejs-webapp

# Log ind på Azure CLI
az login

# Gør deploy-script eksekverbart
chmod +x deploy.sh

# Kør deployment (opretter webapp og deployer)
./deploy.sh
