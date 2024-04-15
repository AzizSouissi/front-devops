# Use node image as base
FROM node:18 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Stage 2: Use nginx to serve the compiled Angular app
FROM nginx:alpine

# Copy the built Angular app from the 'build' stage to the nginx html directory
COPY --from=build /app/dist/crudtuto-front /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
