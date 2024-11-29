#!/bin/bash

# Farben für Nachrichten
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Helper-Funktion für farbige Ausgaben
print_msg() {
    echo -e "${1}${2}${NC}"
}

# Funktion zum Überprüfen, ob ein Tool installiert ist
check_dependencies() {
    print_msg "$BLUE" ">> Checking dependencies..."
    MISSING_TOOLS=()

    for tool in wget curl unzip; do
        if ! command -v "$tool" &>/dev/null; then
            MISSING_TOOLS+=("$tool")
        fi
    done

    if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
        print_msg "$RED" ">> Error: Missing required tools: ${MISSING_TOOLS[*]}"
        print_msg "$RED" ">> Please install them using your package manager and try again."
        exit 1
    fi
    print_msg "$GREEN" ">> All dependencies are installed."
}

# Installationsfunktion
install_project() {
    print_msg "$GREEN" ">> Installing Laboratory Project..."

    # Zielverzeichnis und URL
    INSTALL_DIR="/opt/laboratory"
    BIN_PATH="/usr/local/bin/laboratory"
    DOWNLOAD_URL="https://github.com/The-Cyberlab/beta_release_v0.0.1.zip"
    TEMP_ZIP="/tmp/laboratory.zip"

    # Überprüfen, ob `wget` oder `curl` verfügbar ist
    if command -v wget &>/dev/null; then
        DOWNLOADER="wget -qO"
    elif command -v curl &>/dev/null; then
        DOWNLOADER="curl -sL -o"
    else
        print_msg "$RED" ">> Error: Neither wget nor curl is installed. Please install one of them and try again."
        exit 1
    fi

    # Dateien herunterladen
    print_msg "$BLUE" ">> Downloading project files from $DOWNLOAD_URL..."
    $DOWNLOADER "$TEMP_ZIP" "$DOWNLOAD_URL" || {
        print_msg "$RED" ">> Error: Failed to download project files."
        exit 1
    }

    # Entpacken
    print_msg "$BLUE" ">> Extracting project files..."
    sudo mkdir -p "$INSTALL_DIR"
    sudo unzip -qo "$TEMP_ZIP" -d "$INSTALL_DIR" || {
        print_msg "$RED" ">> Error: Failed to extract project files."
        exit 1
    }
    sudo rm -f "$TEMP_ZIP"

    # Skript ausführbar machen und Symlink erstellen
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

# Hauptausführung
main() {
    check_dependencies
    install_project
}

main
