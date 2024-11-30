#!/bin/bash
# CREATED BY Bruno

# --> SECTION 0 <-- #

# Farben für Nachrichten
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Helper-Funktion für farbige Ausgaben
print_msg() {
    echo -e "${1}${2}${NC}"
}

# --> SECTION 1 <-- #

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

install_project() {
    print_msg "$GREEN" ">> Installing Laboratory Project..."
    ZIP_FILE="beta_release_v0.0.1.zip"
    INSTALL_DIR="/opt/laboratory"
    BIN_PATH="/usr/local/bin/laboratory"
    DOWNLOAD_URL="https://release.cyberbear.me/laboratory/$ZIP_FILE"
    TEMP_ZIP="/tmp/laboratory.zip"

    if command -v wget &>/dev/null; then
        DOWNLOADER="wget -qO"
    elif command -v curl &>/dev/null; then
        DOWNLOADER="curl -sL -o"
    else
        print_msg "$RED" ">> Error: Neither wget nor curl is installed."
        exit 1
    fi

    print_msg "$BLUE" ">> Downloading project files from $DOWNLOAD_URL..."
    $DOWNLOADER "$TEMP_ZIP" "$DOWNLOAD_URL" || {
        print_msg "$RED" ">> Error: Failed to download project files or file is empty."
        exit 1
    }

    if [ ! -s "$TEMP_ZIP" ]; then
        print_msg "$RED" ">> Error: Downloaded file is empty."
        exit 1
    fi

    print_msg "$BLUE" ">> Extracting project files..."
    sudo mkdir -p "$INSTALL_DIR"
    sudo unzip -qo "$TEMP_ZIP" -d "$INSTALL_DIR" || {
        print_msg "$RED" ">> Error: Extraction failed."
        exit 1
    }
    sudo rm -f "$TEMP_ZIP"

    if [ ! -f "$INSTALL_DIR/main.sh" ]; then
        print_msg "$RED" ">> Error: main.sh not found."
        exit 1
    fi

    sudo chmod +x "$INSTALL_DIR/main.sh"
    sudo ln -sf "$INSTALL_DIR/main.sh" "$BIN_PATH"
}


# --> SECTION 2 <-- #

# Get Linux-Distro-Informations from /etc/os-release #
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
    kali | parrot)
        print_msg "$RED" ">> This script does not support $ID Linux. Exiting..."
        exit 1
        ;;
    *)
        print_msg "$BLUE" ">> Detected Linux distribution: $ID"
        ;;
    esac
else
    print_msg "$RED" ">> Error: /etc/os-release not found. Unable to determine the Linux distribution."
    exit 1
fi


# Detect package manager function
detect_package_manager() {
    for manager in apt pacman dnf yum zypper apk; do
        if command -v "$manager" >/dev/null 2>&1; then
            echo "$manager"
            return
        fi
    done
    print_msg "$RED" ">> Unknown package manager. Exiting..."
    exit 1
}


# Install Docker, Compose, Python3, Pip, and yq
install_dependencies() {
    local package_manager="$1"

    print_msg "$BLUE" ">> Installing Docker, Compose, Python3, Pip, and yq with $package_manager"

    case "$package_manager" in
    apt)
        apt update && apt install -y docker.io docker-compose python3 python3-pip curl
        # Install yq (yq is not typically available in apt by default, so using the recommended installation method)
        curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
        ;;
    pacman)
        pacman -Suy --noconfirm && pacman -S --noconfirm docker docker-compose python python-pip curl
        # Install yq (using the pacman package manager or curl method)
        curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
        ;;
    dnf)
        dnf install -y docker-ce docker-compose python3 python3-pip curl
        # Install yq (using the dnf package manager or curl method)
        curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
        ;;
    zypper)
        zypper install -y docker docker-compose python3 python3-pip curl
        # Install yq (using the zypper package manager or curl method)
        curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
        ;;
    apk)
        apk add --no-cache docker docker-compose python3 py3-pip curl
        # Install yq (using the apk package manager or curl method)
        curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o /usr/local/bin/yq
        chmod +x /usr/local/bin/yq
        rc-update add docker default && /etc/init.d/docker start
        ;;
    *)
        print_msg "$RED" ">> Unsupported package manager: $package_manager"
        exit 1
        ;;
    esac

    systemctl start docker.service || service docker start
    print_msg "$GREEN" ">> Docker, Compose, Python3, Pip, and yq installed successfully."
}


#   Build custom Baseimage 
build_custom_image() {
    local bulder_file="./laboratory-image/builder"
    print_msg "$BLUE" ">> Execute builder"

    # check if file exists
    if [ ! -f "$bulder_file" ]; then
        print_msg "$RED" ">> Error: Builder script not found."
        exit 1
    fi

    # execute and check for success
    if $bulder_file; then
        print_msg "$GREEN" ">> Build finished successfully."
    else
        print_msg "$RED" ">> Error: Build process failed."
        exit 1
    fi
}

# Hauptausführung
main() {
    check_dependencies
    install_project
    #Setup Project
    local package_manager
    package_manager=$(detect_package_manager)
    install_dependencies "$package_manager"
    #build_custom_image

    print_msg "$GREEN" ">> Laboratory installed successfully!"
    print_msg "$GREEN" ">> You can now run the project with the command: laboratory"
}

main

# CREATED BY Bruno
