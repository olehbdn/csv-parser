# Configuration
CSV_FILE="parsed_nginx_log.csv"  # Replace with your CSV file name
REPO_PATH="/Users/ob/Documents/testdevops"   # Replace with your Git repository path
COMMIT_MESSAGE="Update parsed NGINX log" # Commit message

# Navigate to the Git repository
cd "$REPO_PATH" || { echo "Error: Repository path not found."; exit 1; }

# Check if the CSV file exists
if [[ -f "$CSV_FILE" ]]; then
    # Stage the CSV file
    echo "Adding $CSV_FILE to Git..."
    git add "$CSV_FILE"

    # Commit the changes
    echo "Committing changes..."
    git commit -m "$COMMIT_MESSAGE"

    # Push the changes
    echo "Pushing changes to remote repository..."
    git push

    echo "CSV file successfully committed and pushed to the repository."
else
    echo "Error: $CSV_FILE not found in $REPO_PATH."
    exit 1
fi