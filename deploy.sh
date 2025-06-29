#!/usr/bin/env bash
set -e

APP_NAME="azure-nodejs-demo-$RANDOM"
RESOURCE_GROUP="rg-$APP_NAME"
LOCATION="westeurope"
PLAN_NAME="plan-$APP_NAME"

echo "Opretter ressourcer..."
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
  --runtime "NODE|20-lts" \
  --deployment-local-git

DEPLOY_URL=$(az webapp deployment source config-local-git \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query url --output tsv)

echo "✅ Web App klar: https://$APP_NAME.azurewebsites.net"
echo "📘 Git remote-url: $DEPLOY_URL"

echo "Initialiserer Git og deployer..."
git init
git remote add azure $DEPLOY_URL
git add .
git commit -m "Initial commit"
git push azure master
