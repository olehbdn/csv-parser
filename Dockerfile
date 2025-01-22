# Step 1: Use a lightweight Node.js image as the base
FROM node:18-alpine

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Install Git (already included in Alpine-based Node.js image)
RUN apk add --no-cache git

# Step 4: Copy application files into the container
COPY parser.js /app/
COPY push_to_git_parsed_csv.sh /app/
COPY nginx.log /app/

# Step 5: Set permissions for the script
RUN chmod +x /app/push_to_git_parsed_csv.sh

# Step 6: Define environment variables for Git credentials
ENV GIT_USER_NAME="default_user"
ENV GIT_USER_EMAIL="default_email@example.com"
ENV GIT_REPO=""

# Step 7: Define the default command
CMD ["sh", "-c", "node parser.js && ./push_to_git_parsed_csv.sh"]
