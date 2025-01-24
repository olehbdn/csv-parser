# Use Node.js 18 on Alpine Linux as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Install Git
RUN apk add --no-cache git

# Copy the application files into the container
COPY parser.js /app/
COPY push_to_git_parsed_csv.sh /app/

# Set permissions for the shell script
RUN chmod +x /app/push_to_git_parsed_csv.sh

# Specify the default command to run
CMD ["sh", "-c", "node /app/parser.js && /app/push_to_git_parsed_csv.sh"]
