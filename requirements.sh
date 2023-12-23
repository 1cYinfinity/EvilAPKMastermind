#!/bin/bash

####################################
# EvilAPKMastermind Requirements Installer
# Author: 1cYinfinity
####################################

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display an error message and exit
display_error() {
  echo -e "${RED}Error: $1${NC}" >&2
  exit 1
}

# Function to display a success message
display_success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to check if a command is available
check_command() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install a package if it is not available
install_package() {
  sudo apt-get install -y "$1" || display_error "Failed to install $1"
}

# Check and install required dependencies
dependencies=("apktool" "smali" "zipalign" "openjdk-11-jdk")
for dep in "${dependencies[@]}"; do
  if ! check_command "$dep"; then
    echo "Installing $dep..."
    install_package "$dep"
  fi
done

# Display success message
display_success "EvilAPKMastermind requirements installed successfully!"
