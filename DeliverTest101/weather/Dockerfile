# Step 1: Use an official Node.js image as a base
FROM node:20-alpine

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Step 4: Copy the rest of the app code
COPY . .

# Step 5: Expose the port that the app will run on
EXPOSE 3000

# Step 6: Run the app
CMD ["node", "index.js"]

