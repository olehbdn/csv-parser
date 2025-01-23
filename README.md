## CSV Parser and Git Automation

This application parsing `nginx.log` file to CSV form and automatically pushing parsed `.csv` file to Git repository using Docker

### Requirements

- Docker installed on your machine
- A remote Git repository where the parsed CSV will be pushed
- A GitHub personal access token for authentication


### Getting Started
#### 1. Clone the Repository
```bash
git clone https://github.com/olehbdn/csv-parser.git
cd csv-parser
```

#### 2. Build the Docker Image
Build the Docker image using the included Dockerfile:
```bash
docker build -t csv-parser .
```

#### 3. Run the Docker Container
Run the container with the appropriate environment variables:
```bash
docker run --rm \
  -e GIT_USER_NAME="your_username" \
  -e GIT_USER_EMAIL="your_email@example.com" \
  -e GIT_REPO="https://<your_token>@github.com/olehbdn/csv-parser.git" \
  csv-parser
```

#### 4. Check Output
The parsed CSV file (parsed_nginx_log.csv) will be committed and pushed to the specified Git repository.