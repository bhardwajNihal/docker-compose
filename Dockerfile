# lightweight Node.js base image with Alpine Linux
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy only dependency files first to take advantage of Docker layer caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files into the container
COPY . .

# Generate Prisma client
# This step uses DATABASE_URL from the .env inside the container,
# which should point to Postgres inside the same Docker network (e.g., 'my_postgres')
RUN npx prisma generate

# Build the TypeScript code
RUN npm run build

# Expose the app port (make sure this matches your app's port)
EXPOSE 3000

# Run the app (`start` script should point to the compiled dist output)
#This makes sure the migrations are applied while running the container and not during build,
# In the RUN command, provide the environment variable DATABASE_URL, for it to connect to the db container.
CMD ["npm", "run", "docker:start"]

    
# "docker:start" : "npx prisma migrate deploy && npm start"
    # --> this applies already existing migrations, instead of creating new one
