#!/bin/sh

# Ensure required environment variables are set
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ] || [ -z "$GIT_REPO" ]; then
    echo "Error: Missing GIT_USER_NAME, GIT_USER_EMAIL, or GIT_REPO environment variables."
    exit 1
fi

# Configure Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Clone the repository if not already cloned
if [ ! -d "/app/repo" ]; then
    git clone "$GIT_REPO" /app/repo || { echo "Error: Failed to clone repository."; exit 1; }
fi

# Copy parsed files to the repository directory
cp /app/parsed_nginx_logs/*.csv /app/repo/

# Commit and push changes
cd /app/repo || { echo "Error: Failed to navigate to repository."; exit 1; }
git add .
git commit -m "Automated commit for parsed logs" || echo "No changes to commit."
git push origin main || { echo "Error: Failed to push changes."; exit 1; }
