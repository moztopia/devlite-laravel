#!/bin/bash

##### initializeCommand.sh
#
# Do you need to do something BEFORE the container load starts? This command
# runs in your local workstation's environment.
#
# set -eux
# export initializeCommand=true

##### Automatically populate the .env files from the template.

export PROJECT_NAME=$(basename "$PWD")

envsubst < .env.template > .env

##### If your workspace folder does not match your current
    # folder's basename, you can expect this to abort.

ABORT_CONFIG_FILE=$PWD/.devcontainer/devcontainer.json
ABORT_WORKSPACE_NAME=$(basename $(jq -r '.workspaceFolder' "$ABORT_CONFIG_FILE"))

clear
echo ""   
echo "   ██████╗ ███████╗██╗   ██╗██╗     ██╗████████╗███████╗"
echo "   ██╔══██╗██╔════╝██║   ██║██║     ██║╚══██╔══╝██╔════╝"
echo "   ██║  ██║█████╗  ██║   ██║██║     ██║   ██║   █████╗  "
echo "   ██║  ██║██╔══╝   ██║ ██║ ██║     ██║   ██║   ██╔══╝  "
echo "   ██████╔╝███████╗ ╚████╔╝ ███████╗██║   ██║   ███████╗"
echo "   ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝   ╚═╝   ╚══════╝"
echo "           -- L A R A V E L"   
echo ""

if [ "$ABORT_WORKSPACE_NAME" != "$PROJECT_NAME" ]; then
    
    echo -e "\e[33mUpdate '\e[0mworkspaceFolder\e[33m' to match your repo before starting the container."
    echo -e "Read \e[0m/readme.md\e[33m and follow instructions (under 30 sec)."
    echo -e "CTRL-C to cancel execution.\e[0m ... \e[31mABORTING\e[0m"
    echo -e ""

    sleep 8640000
    exit 0
fi

echo -e "\e[1;36mDevlite-Laravel:${PROJECT_NAME} initialization successful.\e[0m"
echo -e ""
echo -e "   -- note: If this is the first run; it may take 20+ minutes to build"
echo -e "            this container. Subsequent runs should only take seconds."
echo -e ""

##### Clear the Docker Container local log folders

echo -e "Clearing any old container logs..."
echo -e ""

rm -f $PWD/.devcontainer/mariadb/log/*.log
rm -f $PWD/.devcontainer/redis/log/*.log

echo -e "Launching the server build/load process. Be patient..."
echo -e ""

##### Add your changes below here.