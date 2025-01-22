# Use the official Node.js image as the base
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set the environment variable for production (if applicable)
ENV NODE_ENV=production

# Expose the port the application will run on
EXPOSE 5000

# Start the application
CMD ["node", "app.js"]
