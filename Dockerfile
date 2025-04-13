# Use the official Node.js image as the base image
FROM node:18

# Set the working directory in the container
WORKDIR /usr/src/app

# Use ARG to dynamically pass the tag value from the CI/CD pipeline
ARG TAG

# Replace the hardcoded tag with the dynamic ARG value
RUN git clone --branch $TAG https://github.com/hamzakoc/todo-list-by-day.git /usr/src/app \
    && cd /usr/src/app \
    && npm install

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
