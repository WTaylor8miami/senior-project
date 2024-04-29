# Use a Node.js base image
FROM node:14-buster as builder

# Set the working directory in the Docker container
WORKDIR /app

# Copy package.json and package-lock.json/yarn.lock files
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Build the application
RUN yarn tsc
RUN yarn build

# Production image, copy all the files and run next
FROM node:14-buster-slim

WORKDIR /app

# Copy built assets from the builder stage
COPY --from=builder /app/packages/backend/dist/bundle.tar.gz .
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

# Install production dependencies
RUN yarn install --production --frozen-lockfile

# Expose the port the app runs on
EXPOSE 7000

# Command to run when starting the container
CMD ["node", "packages/backend", "--config", "app-config.yaml", "--config", "app-config.production.yaml"]
