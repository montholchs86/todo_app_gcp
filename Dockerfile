# Use the Node.js 19.7.0 Alpine base image
FROM node:19.7.0-alpine

# Set the environment variable NODE_ENV to production
ENV NODE_ENV=production

# Copy source to container
RUN mkdir -p /usr/app/src

# Copy source code
COPY src /usr/labone/src
COPY package.json /usr/labone
COPY package-lock.json /usr/labone

WORKDIR /usr/labone

# Running npm install
RUN npm install

# Create a user group 
RUN addgroup -S labone_group

# Create a user 'labone_user' under 'labone_group'
RUN adduser -S  -D -h /usr/labone/src labone_user labone_group

#chown all file to the app user
RUN chown -R labone_user:labone_group /usr/labone/

# Switch to labone_user
USER labone_user

# Open mapped port
EXPOSE 3000

# Start the process
CMD ["node", "src/index.js"]