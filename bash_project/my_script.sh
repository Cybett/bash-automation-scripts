#!/bin/bash

DEBUG=false

show_help() {
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  1: Check system date and write it to /tmp/system_date.txt"
    echo "  2: Check installed packages, users, and groups, and store the info in /tmp/sysinfo/"
    echo "  3: Install and configure kubectl, helm, and terraform (latest versions)"
    echo "  --debug: Enable debug messages"
}

if [[ "$*" == *"--debug"* ]]; then
    DEBUG=true
    set -x
fi

if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

trap 'echo "Error occurred. Exiting..."; exit 1' ERR

if [[ $1 -eq 1 ]]; then
    date > /tmp/system_date.txt
    echo "System date written to /tmp/system_date.txt"
    exit 0
fi

if [[ $1 -eq 2 ]]; then
    mkdir -p /tmp/sysinfo
    dpkg -l > /tmp/sysinfo/installed_packages.txt
    cut -d: -f1 /etc/passwd > /tmp/sysinfo/users.txt
    cut -d: -f1 /etc/group > /tmp/sysinfo/groups.txt
    echo "System info saved in /tmp/sysinfo/"
    exit 0
fi

if [[ $1 -eq 3 ]]; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/

    echo "Installing helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    echo "Installing terraform..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform -y

    kubectl version --client > /tmp/kubectl_version.txt
    helm version > /tmp/helm_version.txt
    terraform version > /tmp/terraform_version.txt

    echo "kubectl version:"
    cat /tmp/kubectl_version.txt
    echo "helm version:"
    cat /tmp/helm_version.txt
    echo "terraform version:"
    cat /tmp/terraform_version.txt

    exit 0
fi

