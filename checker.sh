#!/bin/bash

# Define the RPC URL and API key
RPC_URL="https://mainnet.helius-rpc.com/?api-key=43ad2d0e-ce64-42ce-b19d-2767b436ce29"

# Define the list of wallets
WALLETS=(
    "Wallet1"
    "Wallet2"
    "Wallet3"
    "Wallet4"
  
)

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'
BLINK='\e[1;5;32m'

clear
print_logo(){
 echo -e "${BLINK}${RESET}"
 
                                                                                                                     
                                                                                                                     
echo -e "${BLINK}      		                  ███████████            ${RESET}" 
echo -e "${BLINK}   		              ███             ███        ${RESET}" 
echo -e "${BLINK}   		            ██                   ██      ${RESET}" 
echo -e "${BLINK}   		          ██                       ██    ${RESET}" 
echo -e "${BLINK}   		         █   ██████ ████████    ███  █   ${RESET}" 
echo -e "${BLINK}   		        █    ███ ███ ████ ███   ███   █  ${RESET}" 
echo -e "${BLINK}   		       █     ███  ███ ███  ███  ███    █ ${RESET}" 
echo -e "${BLINK}   		      ██     ███   ███ ███  ███ ███    ██${RESET}" 
echo -e "${BLINK}   		      ██     ███    ███ ███  ██ ███    ██${RESET}" 
echo -e "${BLINK}   		      █      ███ ███ ███ ███    ███    █ ${RESET}" 
echo -e "${BLINK}		      ██     ███ ████ ███ ███   ███    ██${RESET}" 
echo -e "${BLINK}		      ██     ███  ████ ███ ███  ███    ██${RESET}" 
echo -e "${BLINK}		       █     ███   ███  ███ ███ ███    █ ${RESET}" 
echo -e "${BLINK}		        █    ███    ████████ █████    █  ${RESET}" 
echo -e "${BLINK}		         █                           █   ${RESET}" 
echo -e "${BLINK}		          ██    NODE CHECKER v1    ██    ${RESET}" 
echo -e "${BLINK}		            ██                   ██      ${RESET}" 
echo -e "${BLINK}		              ███             ███        ${RESET}" 
echo -e "${BLINK}		                  ███████████            ${RESET}" 
 }
 
 print_logo
             
sleep 3
                                                                          
# Check if npx is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}npx could not be found. Trying to install Node.js v20. ${RESET}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs  
fi

# Check if @nosana/cli is installed
if ! npx @nosana/cli --version &> /dev/null; then
    echo -e "${RED}@nosana/cli is not installed. Installing now...${RESET}"
    npx @nosana/cli
fi   
# Function to print a formatted header
print_header() {
    local header="$1"
    echo -e "${GREEN}█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █${RESET}"
    echo -e "${GREEN}${header}${RESET}"
    echo -e "${GREEN}█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █${RESET}"
}

# Function to kill all related processes
kill_all_processes() {
    
    
    # stop processes
    pkill -f "npm exec @nosana/cli node view"
    pkill -f "sh -c 'npx @nosana/cli node view'"
    pkill -f "node --no-warnings .*nosana.*node view"

    
}
sleep 3

# Loop through each wallet and run the command
for WALLET in "${WALLETS[@]}"; do
    clear
    print_logo
    echo -e "							"
    print_header "█ █ █ █ █Processing Node ${WALLET} █ █ █ █ █"
    
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
    echo -e "Status for ${GREEN}${WALLET}${RESET} has been stopped."

done
clear
print_logo
echo -e " "
print_header "█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ All Nodes processed █ █ █ █ █ █ █ █ █ █ █ █ █ █ █"
