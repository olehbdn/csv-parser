#!/bin/sh

# Ensure required environment variables are set
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ] || [ -z "$GIT_REPO" ]; then
    echo "Error: Missing GIT_USER_NAME, GIT_USER_EMAIL, or GIT_REPO environment variables."
    exit 1
fi

# Configure Git
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Clone the repository
if [ ! -d "/app/repo" ]; then
    git clone "$GIT_REPO" /app/repo
fi

cd /app/repo || exit

# Copy the parsed file to the repo
cp /app/parsed_nginx_log.csv .

# Commit and push changes
git add parsed_nginx_log.csv
git commit -m "Automated commit for parsed NGINX log"
git push origin main