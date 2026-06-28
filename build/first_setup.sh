#!/bin/zsh

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

if [ -n "$BASH_VERSION" ]; then
    echo "This script is running in Bash, which is not supported"
    exit 1
elif [ -n "$ZSH_VERSION" ]; then
    echo "This script is running in Zsh."
else
    echo "This script is running in an unknown shell."
fi

echo -e "${BLUE}Setting up binaries${RESET}"

jdk_dirs=(bin/Java/jdk*(N))
if (( ${#jdk_dirs} )) && [ -x "${jdk_dirs[1]}/Contents/Home/bin/java" ]; then
    echo -e "${GREEN}Java already available${RESET}"
else
    echo -e "${RED}Java not found. Downloading...${RESET}"
    rm -rf bin/Java
    mkdir -p bin/Java/
    arch=$(uname -m)
    # echo $arch

    if [ "$arch" = "x86_64" ]; then
        echo "Intel CPU"
        curl -L "https://download.oracle.com/java/25/latest/jdk-25_macos-x64_bin.tar.gz" -o "bin/Java/jdk.tar.gz"
    else
        echo "Apple Silicon"
        curl -L "https://download.oracle.com/java/25/latest/jdk-25_macos-aarch64_bin.tar.gz" -o "bin/Java/jdk.tar.gz"
    fi

    tar -xzf bin/Java/jdk.tar.gz --strip-components=1 -C bin/Java/
    rm bin/Java/jdk.tar.gz
fi

jdk_dirs=(bin/Java/jdk*(N))
java_path="${jdk_dirs[1]}/Contents/Home/bin/java"
echo "Using Java at path: $java_path"
"$java_path" --version

"$java_path" -jar bin/epubcheck-5.2.1/epubcheck.jar --version
if [ $? -eq 0 ]; then
    echo -e "${GREEN}epubchecker already available${RESET}"
    echo -e "${GREEN}Setup complete${RESET}"
    exit
else
    echo -e "${RED}epubchecker not found. Downloading...${RESET}"
    rm -rf bin/epubcheck-5.2.1
    curl -L "https://github.com/w3c/epubcheck/releases/download/v5.2.1/epubcheck-5.2.1.zip" -o "epub.zip"
    unzip "epub.zip" -d bin
    rm epub.zip
    "$java_path" -jar bin/epubcheck-5.2.1/epubcheck.jar --version
    echo -e "${GREEN}Setup complete${RESET}"
fi


