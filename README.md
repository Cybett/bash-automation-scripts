
# System Management Script

This Bash script provides several utilities for system management, including checking the system date, gathering information about installed packages, users, and groups, and installing essential tools like `kubectl`, `helm`, and `terraform`.

## Usage

To run the script, use the following command:

```bash
./my_script.sh [OPTION]
```

## Options

- `1`: Check the system date and write it to `/tmp/system_date.txt`.
- `2`: Check installed packages, users, and groups, and store the information in `/tmp/sysinfo/`.
- `3`: Install and configure `kubectl`, `helm`, and `terraform` (latest versions).

### Examples

To check the system date:
```bash
./my_script.sh 1
```

To gather system info:
```bash
./my_script.sh 2
```

To install kubectl, helm, and terraform:
```bash
./my_script.sh 3
```

### Debug Mode

Add `--debug` to any command to enable debug messages. For example:
```bash
./my_script.sh 1 --debug
```

## Installation

Ensure that you have the required permissions to execute the script. You may need to run it with `sudo` if installing software or writing to system directories.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes or improvements.
