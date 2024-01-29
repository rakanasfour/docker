
# Stage 1: Build the application
# Use an official Node runtime as a base image
FROM node:16-alpine as build
# Set the working directory
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
COPY . ./
# Install dependencies
RUN npm install
# Copy the application files
COPY . .
# Build the React app

RUN npm run build

# Stage 2: Create a minimal runtime image
# Use a smaller Node image for the final image
FROM node:16-alpine
# Set the working directory
WORKDIR /app
# Copy the built app from the previous stage
COPY --from=build /app/build /app


# Install only production dependencies (optional)
#RUN npm install --only=production
# Expose port 3000 (or any other port you want to use)
EXPOSE 3000
# Start the React app
CMD ["npm", "start"]
