#!/bin/bash

# Step 1: Check if Helm is installed
if ! command -v helm &> /dev/null
then
    echo "Helm is not installed. Exiting."
    exit 1
fi

echo "Helm is installed. Proceeding with uninstallation."

# Step 2: Uninstall Helm charts
echo "## Step 2: Uninstalling Helm charts ##"
helm list --all-namespaces -q | while read release_name
do
    echo "Uninstalling chart: $release_name"
    helm uninstall $release_name
done

# Step 3: Remove Helm repositories
echo "## Step 3: Removing Helm repositories ##"
helm repo list -q | while read repo
do
    echo "Removing Helm repository: $repo"
    helm repo remove $repo
done

# Step 4: Remove Helm binary
echo "## Step 4: Removing Helm binary ##"
rm -f /usr/local/bin/helm

# Step 5: Remove Helm configuration and data
echo "## Step 5: Removing Helm configuration and data ##"
rm -rf ~/.helm
rm -rf ~/.cache/helm
rm -rf ~/.local/share/helm

# Step 6: Cleanup system packages related to Helm (if any)
echo "## Step 6: Removing Helm-related packages ##"
sudo apt-get purge --auto-remove -y kubectl helm
sudo apt-get autoremove -y

# Step 7: Cleanup logs and other Helm-related files
echo "## Step 7: Cleaning up Helm logs and files ##"
rm -rf /var/log/helm
rm -rf /var/lib/helm

# Step 8: Remove the Helm installation script
echo "## Step 8: Removing installation script ##"
rm -f get_helm.sh

echo "Helm uninstallation completed successfully!"
