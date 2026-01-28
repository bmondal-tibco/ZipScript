# Tibco Package Script

**Version:** 1.0

## Overview

The **Tibco Package Script** is a shell script designed to facilitate the packaging of directory contents into a zip file. This script provides a simple command-line interface for users to create zip archives of specified directories, with customizable naming options.

## Features

- Package contents of a directory into a zip file.
- Default naming convention for zip files.
- Support for custom zip file names.
- Flexible usage from different directory levels.

## Usage

To use the script, follow these steps:

1. **Copy the script** `tib_package.sh` into any directory of your choice.

2. **Execute the script** with the following commands based on your requirements:

| Command                        | Behavior                                                                                     |
|-------------------------------|----------------------------------------------------------------------------------------------|
| `./tib_package.sh .`          | Packages the current directory into `tib_package.zip` if the script is in the current directory. |
| `../tib_package.sh .`         | Packages the current directory into `tib_package.zip` if the script is one directory above the current directory. |
| `./tib_package.sh . '*'`      | Packages the current directory into `tib_package.zip` with explicit `*`, defaults to `tib_package.zip` in the current directory. |
| `../tib_package.sh . '*'`     | Packages the current directory into `tib_package.zip` with explicit `*`, defaults to `tib_package.zip` if the script is one directory above. |
| `./tib_package.sh dir`        | Zips the contents of the specified directory into a default zip file named `tib_package.zip`. |
| `./tib_package.sh dir '*'`    | Zips the contents of the specified directory into `custom.zip`, where explicit `*` defaults to `tib_package.zip`. |
| `./tib_package.sh dir custom.zip` | Zips the contents of the specified directory into `custom.zip`.                          |

## Requirements

- A Unix-like environment (Linux, macOS, etc.)
- Bash shell

## Installation

1. Clone or download the repository containing `tib_package.sh`.
2. Navigate to the directory where the script is located.
3. Ensure the script has executable permissions:
   ```bash
   chmod +x tib_package.sh
