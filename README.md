# Tibco Package Script

**Version:** 1.1

## Overview

The **Tibco Package Script** is a shell script designed to streamline the process of packaging both individual files and directory contents into ZIP files. It offers a flexible command-line interface that allows users to create zip archives with customizable naming options, easily catering to different use cases.

## Features

- **Supports Single File Zipping**: Allows users to zip a single file directly without needing to navigate into a directory.
- **Packages Directory Contents**: Zips all contents of a specified directory recursively, excluding the script and any existing ZIP files.
- **Custom Naming**: Users can specify a custom name for the ZIP file or use a default naming convention (`tib_package.zip`).
- **Flexible Usage**: The script can be invoked from various levels in the directory structure, handling relative and absolute paths effectively.
- **Error Handling**: Provides meaningful error messages for invalid inputs, such as non-existent files or directories.

## Usage

To use the script, follow these steps:

1. **Copy the script** `tib_package.sh` into your desired directory.

2. **Execute the script** with the following commands based on your requirements:

| Command                                          | Behavior                                                                                                           |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `./tib_package.sh /path/to/file.txt`            | Zips the specified file into `tib_package.zip` in the same directory as the file.                               |
| `./tib_package.sh /path/to/directory`           | Zips the contents of the specified directory into `tib_package.zip`.                                            |
| `./tib_package.sh /path/to/directory custom.zip`| Zips the contents of the specified directory into `custom.zip`.                                                 |
| `./tib_package.sh .`                            | Packages the current directory into `tib_package.zip`.                                                           |
| `./tib_package.sh . '*'`                        | Packages the current directory into `tib_package.zip` with explicit `*`, defaults to `tib_package.zip`.         |
| `unzip example.zip`                             | Unzips the contents of `example.zip` into the current directory.                                                |
| `unzip example.zip -d /path/to/directory`      | Unzips the contents of `example.zip` into the specified target directory.                                       |

## Requirements

- A Unix-like environment (Linux, macOS, etc.)
- Bash shell
- `zip` utility installed

## Installation

1. Clone or download the repository containing `tib_package.sh`.
2. Navigate to the directory where the script is located.
3. Ensure the script has executable permissions:
   ```bash
   chmod +x tib_package.sh
   ```

## How It Works

1. **Argument Parsing**: 
   - The script checks the number of arguments provided and sets the target and ZIP file name accordingly.
   - Supports a literal `*` to default to `tib_package.zip`.

2. **Target Validation**: 
   - Validates if the provided target exists and checks whether it's a file or a directory.
   - If the target doesn't exist, it will alert the user.

3. **File and Directory Handling**:
   - If a **file** is specified, the script creates a ZIP containing just that file.
   - If a **directory** is specified, it checks for any content within. If the directory is empty, a warning will be issued.

4. **Zipping Operation**:
   - It uses the `zip` command to create the archive quietly and recursively, excluding the script itself and any existing ZIP files in the target directory.

5. **Output**:
   - Upon successful completion, it prints the path of the created ZIP file. If an error occurs, it provides feedback accordingly.

### Example Scenarios

- **Zipping a Single File**:
  ```bash
  ./tib_package.sh /path/to/myfile.txt
  ```
  Creates `myfile.zip` in the same directory as the specified file.

- **Zipping a Directory**:
  ```bash
  ./tib_package.sh /path/to/mydirectory
  ```
  Creates `tib_package.zip` containing all files in `mydirectory`.

- **Using Custom ZIP Name**:
  ```bash
  ./tib_package.sh /path/to/mydirectory custom.zip
  ```
  Creates `custom.zip` containing all files in `mydirectory`.

---

This README provides detailed information about the upgraded script, emphasizing its flexibility and user-friendly features.
