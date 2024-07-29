# NosanaNodeChecker
# 🚀 Welcome to Nosana Node Checker v1, a powerful tool designed for monitoring multiple Nosana nodes.

## What is Nosana Node Checker v1?
Nosana Node Checker v1 is a command-line utility built to help you easily manage and monitor multiple Nosana nodes. It allows you to execute commands, check node statuses, and ensure everything is running smoothly with minimal effort.

### Key Features:
    • Multi-Wallet Support: Manage and monitor multiple Nosana nodes simultaneously. Simply provide a list of wallet addresses, and the tool handles the rest.
    • Dynamic Status Updates: Receive real-time updates and easily track the status of each node.


### 1.Installation & Usage:

To get started with Nosana Node Checker v1, follow these simple steps:
    
### 2.Download the Script: 
`wget [https://raw.githubusercontent.com/ersguteralbaner/NosanaNodeChecker/main/checker.sh]`

Obtain the latest version of Nosana Node Checker v1 and make it executable with `chmod +x checker.sh`

### 3.Install Dependencies:

Ensure that npx and nosana/cli are installed. The script will assist with this if needed.

#installs nvm (Node Version Manager)

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash`

#download and install Node.js (you may need to restart the terminal)

`nvm install 20`

#verifies the right Node.js version is in the environment

`node -v` # should print v20.16.0

#verifies the right npm version is in the environment

`npm -v` # should print 10.8.1

`npx @nosana/cli`

### 4. Configure:
   
   Set your wallet addresses and RPC URL in the script. You can get an individual RPC URL for free at https://www.helius.dev/.
   
### 5. Run the Tool:

   Execute the script to start managing and monitoring your Nosana nodes. 
   `./checker.sh`
   
### 6. Monitor and Control:
   
   Follow the interactive prompts to manage your node checks and get real-time updates.

View while node is in queue.   
![Screenshot from 2024-07-29 15-13-44](https://github.com/user-attachments/assets/46b91a05-2fbe-4a78-bf1b-6095ac87d879)

View while node is processing a job
![Screenshot from 2024-07-29 16-54-33](https://github.com/user-attachments/assets/5db47ae1-e82b-4d53-bc16-e09f7d06ee4c)
