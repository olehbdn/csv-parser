# Step 1: Use a lightweight Node.js image as the base
FROM ubuntu:24.04

# Step 2: Set the working directory inside the container
WORKDIR /app

# Install Node.js, npm, and Git
RUN apt-get update && apt-get install -y \
    git \
    nodejs \
    npm \
    && apt-get clean
#RUN chmod +x /app/push_to_github.sh

# Step 3: Copy the application files into the container
COPY parser.js /app/
COPY push_to_git_parsed_csv.sh /app/
COPY nginx.log /app/


# Step 7: Define the default command
CMD ["sh", "-c", "node parser.js"]