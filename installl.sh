#!/bin/bash

# Color definition
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Helper-Function
print_msg() {
    echo -e "${1}${2}${NC}"
}

#############################
# Check if executed as root #
#############################
if [ "$(id -u)" -ne 0 ]; then
    print_msg "$RED" ">> This script must be run as root or root privileges."
    exit 1
fi

# Installationfunction
install_project() {
    print_msg "$GREEN" ">> Installing Laboratory Project..."

    # Zielverzeichnis
    INSTALL_DIR="/opt/laboratory"
    BIN_PATH="/usr/local/bin/laboratory"

    # Dateien kopieren
    if [ ! -d "$INSTALL_DIR" ]; then
        sudo mkdir -p "$INSTALL_DIR"
        sudo cp -r ./* "$INSTALL_DIR"
    else
        print_msg "$RED" ">> Error: Installation directory already exists at $INSTALL_DIR."
        exit 1
    fi

    # Skript ausführbar machen und symlink erstellen
    if [ -f "$INSTALL_DIR/main.sh" ]; then
        sudo chmod +x "$INSTALL_DIR/main.sh"
        sudo ln -sf "$INSTALL_DIR/main.sh" "$BIN_PATH"
    else
        print_msg "$RED" ">> Error: main.sh not found in $INSTALL_DIR."
        exit 1
    fi

    print_msg "$GREEN" ">> Laboratory installed successfully!"
    print_msg "$GREEN" ">> You can now run the project with the command: laboratory"
}

# execute
install_project
