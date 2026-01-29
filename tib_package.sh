#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 <target> [zip_file_name.zip or *]"
  exit 1
}

DEFAULT_ZIP_NAME="tib_package.zip"

# Argument parsing with literal '*' detection
if [ "$#" -eq 1 ]; then
  TARGET="$1"
  ZIPFILE_NAME="$DEFAULT_ZIP_NAME"
elif [ "$#" -eq 2 ]; then
  TARGET="$1"
  if [ "$2" = "*" ]; then
    ZIPFILE_NAME="$DEFAULT_ZIP_NAME"
  else
    ZIPFILE_NAME="$2"
  fi
else
  usage
fi

# Interpret "." as current directory
if [ "$TARGET" = "." ]; then
  TARGET="$(pwd)"
fi

# Validate the target (file or directory)
if [ ! -e "$TARGET" ]; then
  echo "Error: '$TARGET' does not exist."
  exit 1
fi

# Resolve absolute paths
TARGET_ABS=$(realpath "$TARGET")
ZIPFILE_PATH="$(dirname "$TARGET_ABS")/$ZIPFILE_NAME"
SCRIPT_PATH_ABS=$(readlink -f "$0")
SCRIPT_NAME=$(basename "$SCRIPT_PATH_ABS")

# Check if a file or directory needs to be zipped
if [ -f "$TARGET_ABS" ]; then
  # If a single file, zip that directly
  ITEMS_TO_ZIP=("$TARGET_ABS")
elif [ -d "$TARGET_ABS" ]; then
  # If a directory, change into that directory
  cd "$TARGET_ABS"
  
  # Check for any files (including hidden) using globbing options
  shopt -s nullglob dotglob
  all_items=(*)
  shopt -u nullglob dotglob
  if [ "${#all_items[@]}" -eq 0 ]; then
    echo "Warning: no files/folders inside '$TARGET_ABS'. Nothing to zip."
    exit 0
  fi

  # Create array of items to zip, excluding script and zip file
  mapfile -t ITEMS_TO_ZIP < <(
    find . -mindepth 1 \
      ! -name "$ZIPFILE_NAME" \
      ! -name "$SCRIPT_NAME"
  )

  if [ "${#ITEMS_TO_ZIP[@]}" -eq 0 ]; then
    echo "Warning: nothing to zip after exclusions."
    exit 0
  fi
else
  echo "Error: '$TARGET' is neither a file nor a directory."
  exit 1
fi

# Create zip quietly and recursively
zip -r -q "$ZIPFILE_PATH" "${ITEMS_TO_ZIP[@]}"

if [ $? -eq 0 ]; then
  echo "Zip created: '$ZIPFILE_PATH'"
  exit 0
else
  echo "Error: zip failed."
  exit 1
fi


