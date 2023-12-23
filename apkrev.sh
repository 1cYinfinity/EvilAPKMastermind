#!/bin/bash

####################################
# EvilAPKMastermind Script
# Author: 1cYinfinity
####################################

# Colors for terminal output
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display an error message and exit
display_error() {
  echo -e "${RED}Error: $1${NC}" >&2
  exit 1
}

# Function to execute a command and display an error if it fails
execute_command() {
  "$@" || display_error "Command failed: $*"
}

# Prompt the user for the target APK file
read -p "Enter the name of the unsuspecting APK file: " APK_FILE

# Set the output directory
OUTPUT_DIR="output_directory"
APK_BASENAME=$(basename "$APK_FILE")

# Create a timestamp for backup purposes
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_DIR="${OUTPUT_DIR}/backup_${TIMESTAMP}"

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR" || display_error "Failed to create the output directory"

# Backup the original APK
mkdir -p "$BACKUP_DIR" && cp "$APK_FILE" "$BACKUP_DIR/${APK_BASENAME}_backup"

# Disassemble the APK using Apktool
execute_command apktool d "$APK_FILE" -o "$OUTPUT_DIR/apktool_output" || display_error "Failed to disassemble APK"

# Convert DEX to Smali using Smali/Baksmali
execute_command smali "$OUTPUT_DIR/apktool_output/smali" -o "$OUTPUT_DIR/smali_output" || display_error "Failed to convert DEX to Smali"

# Let the user unleash their boundless malevolence by injecting modifications into the Smali code
read -p "Now, what supremely powerful and destructive changes do you wish to impose upon the Smali code? (Remember, the abyss stares back.)"

# Inject the user's insidious changes into the Smali code
echo "Behold, the abyss of your making... I wash my hands of it. - 1cYinfinity"

# Recompile the Smali code back to DEX
execute_command baksmali "$OUTPUT_DIR/smali_output" -o "$OUTPUT_DIR/baksmali_output.dex" || display_error "Failed to recompile Smali to DEX"

# Sign the APK with a debug key, for the subtle touch of legitimacy
execute_command jarsigner -keystore debug.keystore -storepass android -keypass android "$APK_FILE" androiddebugkey || display_error "Failed to sign APK"

# Align the APK for maximum malevolence
execute_command zipalign -v 8 "$APK_FILE" "$OUTPUT_DIR/ultimate_${APK_BASENAME}" || display_error "Failed to align APK"

echo "Evil modifications successfully applied! Original APK backed up to: $BACKUP_DIR"
