#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 <target_directory> [zip_file_name.zip or *]"
  exit 1
}

DEFAULT_ZIP_NAME="tib_package.zip"

# Argument parsing with literal '*' detection
if [ "$#" -eq 1 ]; then
  TARGET_DIR="$1"
  ZIPFILE_NAME="$DEFAULT_ZIP_NAME"
elif [ "$#" -eq 2 ]; then
  TARGET_DIR="$1"
  if [ "$2" = "*" ]; then
    ZIPFILE_NAME="$DEFAULT_ZIP_NAME"
  else
    ZIPFILE_NAME="$2"
  fi
else
  usage
fi

# Interpret "." as current directory
if [ "$TARGET_DIR" = "." ]; then
  TARGET_DIR="$(pwd)"
fi

# Validate directory
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: '$TARGET_DIR' is not a directory."
  exit 1
fi

# Resolve absolute paths
TARGET_DIR_ABS=$(cd "$TARGET_DIR" && pwd)
ZIPFILE_PATH="$TARGET_DIR_ABS/$ZIPFILE_NAME"
SCRIPT_PATH_ABS=$(readlink -f "$0")
SCRIPT_NAME=$(basename "$SCRIPT_PATH_ABS")

# Change into target directory
cd "$TARGET_DIR_ABS"

# Check for any files (including hidden) using globbing options
shopt -s nullglob dotglob
all_items=(*)
shopt -u nullglob dotglob
if [ "${#all_items[@]}" -eq 0 ]; then
  echo "Warning: no files/folders inside '$TARGET_DIR_ABS'. Nothing to zip."
  exit 0
fi

# Build list to include, excluding script and zip file
mapfile -t to_zip < <(
  find . -mindepth 1 \
    ! -name "$ZIPFILE_NAME" \
    ! -name "$SCRIPT_NAME"
)

if [ "${#to_zip[@]}" -eq 0 ]; then
  echo "Warning: nothing to zip after exclusions."
  exit 0
fi

# Create zip quietly and recursively
zip -r -q "$ZIPFILE_NAME" "${to_zip[@]}"

if [ $? -eq 0 ]; then
  echo "Zip created: '$ZIPFILE_PATH'"
  exit 0
else
  echo "Error: zip failed."
  exit 1
fi

