FROM node:18-alpine

#Set the working directory inside the container
WORKDIR /app

#Install Git
RUN apk add --no-cache git

#Copy application files into the container
COPY parser.js /app/
COPY push_to_git_parsed_csv.sh /app/
COPY nginx.log /app/

#Set permissions for the script
RUN chmod +x /app/push_to_git_parsed_csv.sh

#Define environment variables for Git credentials
ENV GIT_USER_NAME="default_user"
ENV GIT_USER_EMAIL="default_email@example.com"
ENV GIT_REPO=""

#Define the default command
CMD ["sh", "-c", "node parser.js && ./push_to_git_parsed_csv.sh"]
