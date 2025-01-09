#!/bin/bash

# Step 1: Installing Helm
echo "## Step 1: Installing Helm ##"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Check if Helm is installed
if ! command -v helm &> /dev/null
then
    echo "Helm installation failed. Exiting."
    exit 1
fi

echo "Helm installed successfully!"

# Step 2: Asking the user for Helm chart installation choice
echo "Select the type of Helm chart you want to install:"
echo "1. Stable Chart"
echo "2. Custom Chart from your repository"
echo "3. Specific chart from a different repository"
read -p "Enter the number corresponding to your choice (1, 2, or 3): " chart_type

# Step 3: Install based on user selection
case $chart_type in
    1)
        # Install stable chart
        echo "You have chosen Stable Chart."
        read -p "Enter the chart name (e.g., nginx-ingress, mysql, etc.): " chart_name
        read -p "Enter the version of the chart (e.g., 1.32.0 or latest): " chart_version
        echo "## Step 3: Installing Stable Helm chart... ##"
        helm repo add stable https://charts.helm.sh/stable
        helm repo update
        helm install $chart_name stable/$chart_name --version $chart_version
        ;;
    2)
        # Install custom chart from your repository
        echo "You have chosen Custom Chart from your repository."
        read -p "Enter your custom chart repository URL: " chart_repo_url
        read -p "Enter the chart name (e.g., my-chart): " chart_name
        read -p "Enter the version of the chart (e.g., 1.0.0 or latest): " chart_version
        echo "## Step 3: Adding your custom chart repository... ##"
        helm repo add custom-repo $chart_repo_url
        helm repo update
        helm install $chart_name custom-repo/$chart_name --version $chart_version
        ;;
    3)
        # Install specific chart from a different repository
        echo "You have chosen Specific chart from a different repository."
        read -p "Enter the repository URL: " repo_url
        read -p "Enter the chart name: " chart_name
        read -p "Enter the version of the chart (e.g., 1.0.0 or latest): " chart_version
        echo "## Step 3: Adding specific chart repository... ##"
        helm repo add custom-repo $repo_url
        helm repo update
        helm install $chart_name custom-repo/$chart_name --version $chart_version
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

echo "Helm chart installation completed successfully!"
