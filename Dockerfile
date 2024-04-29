# Use the official Node.js 14 image.
FROM node:14

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy the server.js file from the build context into the container's /usr/src/app directory
COPY server.js /usr/src/app/

# Initialize a new package.json file using yarn.
# The `-y` flag will skip the questionnaire and generate a default package.json.
RUN yarn init -y

# Install dependencies
RUN npm install
RUN npm install @backstage/backend

# If you need to add specific packages, you can do so using yarn add.
# This step is optional and can be customized to include the packages you need.
# For example:
# RUN yarn add express body-parser

# After your package.json and yarn.lock are correctly set up,
# you can copy your source code.
COPY . .

# You might have a build step for your application.
# RUN yarn build

# The command to run your application.
# Replace "server.js" with the path to your application's entry point.
CMD ["node", "server.js"]
