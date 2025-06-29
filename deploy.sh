#!/usr/bin/env bash
set -e

APP_NAME="azure-nodejs-demo-$RANDOM"
RESOURCE_GROUP="rg-$APP_NAME"
LOCATION="westeurope"
PLAN_NAME="plan-$APP_NAME"
GITHUB_REPO_URL="https://github.com/cccp200/azure-nodejs-webapp.git"  # ← opdatér denne!

echo "▶️ Opretter ressourcer..."
az group create --name $RESOURCE_GROUP --location $LOCATION

az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RESOURCE_GROUP \
  --sku FREE \
  --is-linux

az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --runtime "NODE|20-lts"

# Tilføj GitHub som deployment source (uden CI/CD, bare pull)
az webapp deployment source config \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --repo-url $GITHUB_REPO_URL \
  --branch main \
  --manual-integration

echo "🌍 Appen vil nu blive hentet fra GitHub og deployet til:"
echo "    https://$APP_NAME.azurewebsites.net"
