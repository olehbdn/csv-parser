## CSV Parser and Git Automation

This application parsing nginx.log files to CSV and automatically pushing parsed `.csv` file to Git repository using Docker

### Requirements

- Docker installed on your machine
- A remote Git repository where the parsed CSV will be pushed
- A GitHub personal access token for authentication


### Getting Started
### 1. Clone the Repository
```bash
git clone https://github.com/olehbdn/csv-parser.git
cd csv-parser
```

### 2. Prepare .env file for flexibility of the app
Modify .env.example and rename it to .env afterwards with the environmental variables:
```
GIT_USER_NAME="username"
GIT_USER_EMAIL="email"
GIT_REPO=https://your-github-token@github.com/username/reponame.git
```

### 3. Build the Docker Image
Build the Docker image using the included Dockerfile:
```bash
docker build -t parser_git_push-ct .
```

### 4. Run the Docker Container
Command will parse all the nginx log files inside /local/path/logs folder. Also it will mount that folders to the container.
```
docker run --env-file .env -v /local/path/logs:/app/nginx_logs -v /local/path/parsed/logs:/app/parsed_nginx_logs parser_git_push-ct
```

### 5. Check Output
The parsed CSV file will be committed and pushed to the specified Git repository.