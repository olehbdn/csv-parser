#!/bin/sh

# Ensure required environment variables are set
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ] || [ -z "$GIT_REPO" ]; then
    echo "Error: Missing GIT_USER_NAME, GIT_USER_EMAIL, or GIT_REPO environment variables."
    exit 1
fi

# Configure Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Clone the repository if it doesn't exist
if [ ! -d "/app/repo" ]; then
    echo "Cloning repository..."
    git clone "$GIT_REPO" /app/repo || { echo "Error: Failed to clone repository."; exit 1; }
fi

# Navigate to the repository
cd /app/repo || { echo "Error: Failed to navigate to repository directory."; exit 1; }

# Copy the parsed file to the repo
cp /app/parsed_nginx_log.csv .

# Check the status to confirm the file has been copied
git status

# Force add the file and commit
git add parsed_nginx_log.csv || { echo "Error: Failed to add parsed file."; exit 1; }
git commit -m "Automated commit for parsed NGINX log" || { echo "Error: No changes detected to commit."; exit 1; }

# Push changes
git push origin main || { echo "Error: Failed to push changes."; exit 1; }
