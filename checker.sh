#!/bin/bash

# Define the RPC URL and API key
RPC_URL="https://mainnet.helius-rpc.com/?api-key=your rpc key"

# Define the list of wallets
WALLETS=(
    "Wallet"
    "Wallet"
    "Wallet"
    "Wallet"
)

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

clear
                                                                        
echo -e "${GREEN}   ████ █████   █                                                          ${RESET}" 
echo -e "${GREEN}   ██ ██ ██ ██  █     ██   ██   █████   ██████   ████   ██   ██   ████     ${RESET}"
echo -e "${GREEN}   ██  ██ ██ ██ █     ████ ██ ██    ██ ██       ██  ██  ████ ██  ██  ██    ${RESET}"
echo -e "${GREEN}   ████ ██ ██   █     ██ ████ ██    ██       ██ ██   ██ ██ ████ ██   ██    ${RESET}"
echo -e "${GREEN}   ██ ██ ██ ██  █     ██   ██  ██████  ███████ ██    ██ ██   ██ ██    ██   ${RESET}"
echo -e "${GREEN}   ██  █████ ████                                                          ${RESET}"
echo -e "${GREEN}     ${RESET}"                                                                      
echo -e "${GREEN}   ███  ██  ██████  ██████  ██████                                     ${RESET}"    
echo -e "${GREEN}   ████ ██ ██   ███ ██   ██ ██                                         ${RESET}"   
echo -e "${GREEN}   ██ ████ ██   ███ ██   ██ ██                                         ${RESET}"   
echo -e "${GREEN}   ██   ██  ██████  ██████  ██████                                     ${RESET}"   
echo -e "${GREEN} ${RESET}"                                                                                                         
echo -e "${GREEN}     ████ ██   ██ ██████  █████ ██  █████████ █████             ██     ${RESET}"   
echo -e "${GREEN}   ██     ██   ██ ██     ██     █████  ███    ██  ██   ███ ██ ████     ${RESET}" 
echo -e "${GREEN}   ██     ███████ █████ ███     ████   ██████ ██████    █████   ██     ${RESET}"   
echo -e "${GREEN}   ██████ ██   ██ ██████ ██████ ██ ███ ██████ ██ ███    ████    ██     ${RESET}"   
                                                                          
# Check if npx is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}npx could not be found. Please install Node.js v20.15.1 and npx.${RESET}"
    exit 1
fi

# Check if @nosana/cli is installed
if ! npx @nosana/cli --version &> /dev/null; then
    echo -e "${RED}@nosana/cli is not installed. Installing now...${RESET}"
    npx @nosana/cli
fi   
# Function to print a formatted header
print_header() {
    local header="$1"
    echo -e "${GREEN}====================================${RESET}"
    echo -e "${GREEN}${header}${RESET}"
    echo -e "${GREEN}====================================${RESET}"
}

# Function to kill all related processes
kill_all_processes() {
    print_header "Stopping All Related Processes"
    
    # stop processes
    pkill -f "npm exec @nosana/cli node view"
    pkill -f "sh -c 'npx @nosana/cli node view'"
    pkill -f "node --no-warnings .*nosana.*node view"

    echo -e "${GREEN}All related processes have been stopped.${RESET}"
}
sleep 3

# Loop through each wallet and run the command
for WALLET in "${WALLETS[@]}"; do
    print_header "Processing Node ${GREEN}${WALLET}${RESET}"
    
    # Run the command in the background
    npx @nosana/cli node view --rpc "$RPC_URL" "$WALLET" &
    
    # Get the PID of the background process
    PID=$!

    # Prompt user to press Enter to stop the command and move to the next wallet
    echo -e "Press ${RED}Enter${RESET} to stop and proceed to the next Node..."

    # Read user input
    read -r

    # Stop all related processes
    kill_all_processes

    # Wait for the command to finish
    
    wait "$PID" 2>/dev/null

    # Display the stopped command status
    echo -e "${GREEN}Status for ${WALLET}${RESET} has been stopped."
    echo -e "${YELLOW}------------------------------------------------------------${RESET}"
done

print_header "All Nodes processed"

