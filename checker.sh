#!/bin/bash

# Define the RPC URL and API key
RPC_URL="https://mainnet.helius-rpc.com/?api-key=43ad2d0e-ce64-42ce-b19d-2767b436ce29"

# Define the names and wallet addresses of the nodes
NODE1="Nodename 1" 
NODE2="Nodename 2" 
NODE3="Nodename 3" 
NODE4="Nodename 4" 
NODE5="Nodename 5"
declare -A WALLETS=(
    [$NODE1]="Wallet1"
    [$NODE2]="Wallet2"
    [$NODE3]="Wallet3"
    [$NODE4]="Wallet4"
    [$NODE5]="Wallet5"
)

# Nodenames to maintain order
keys=("$NODE1" "$NODE2" "$NODE3" "$NODE4" "$NODE5")

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'
BLINK='\e[1;5;32m'

print_logo() {
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

print_header() {
    local header="$1"
    echo -e "${GREEN}█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █${RESET}"
    echo -e "${GREEN}${header}${RESET}"
    echo -e "${GREEN}█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █ █${RESET}"
}

kill_all_processes() {
    pkill -f "npm exec @nosana/cli node view" || true
    pkill -f "sh -c 'npx @nosana/cli node view'" || true
    pkill -f "node --no-warnings .*nosana.*node view" || true
}

# Print logo and wait
clear
print_logo
sleep 3

# Check if npx is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}npx could not be found. Trying to install Node.js v20.${RESET}"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    if [ $? -ne 0 ]; then
        echo -e "${RED}Node.js installation failed. Exiting.${RESET}"
        exit 1
    fi
fi

# Check if @nosana/cli is installed
if ! npx @nosana/cli --version &> /dev/null; then
    echo -e "${RED}@nosana/cli is not installed. Installing now...${RESET}"
    npx @nosana/cli
fi   



# Loop through each wallet and run the command
for NAME in "${keys[@]}"; do
    WALLET=${WALLETS[$NAME]}
    clear
    print_logo
    echo -e "							"
    print_header "█ █ █ █ █                   Processing Node ${NAME}                   █ █ █ █ █
█ █ █ █ █         (${WALLET})      █ █ █ █ █"
    
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
    echo -e "Status for ${GREEN}${NAME}${RESET} (${WALLET}) has been stopped."

done
clear
print_logo
echo -e " "
print_header "█ █ █ █ █ █ █ █ █ █ █ █ █ █ █ All Nodes processed █ █ █ █ █ █ █ █ █ █ █ █ █ █ █"
