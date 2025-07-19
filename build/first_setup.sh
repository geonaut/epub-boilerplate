#!/bin/zsh

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

echo -e "${BLUE}Setting up binaries${RESET}"

bin/Java/jdk-24.0.2.jdk/Contents/Home/bin/java --version
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Java already available${RESET}"
else
    echo "Java not found. Downloading..."
    rm -rf bin/Java
    mkdir -p bin/Java/
    curl -L "https://download.oracle.com/java/24/latest/jdk-24_macos-aarch64_bin.tar.gz" | tar -xzf - --strip-components=1 -C bin/Java/
    bin/Java/jdk-24.0.2.jdk/Contents/Home/bin/java --version
fi

bin/Java/jdk-24.0.2.jdk/Contents/Home/bin/java -jar bin/epubcheck-5.2.1/epubcheck.jar --version
if [ $? -eq 0 ]; then
    echo -e "${GREEN}epubchecker already available${RESET}"
else
    echo "Java not found. Downloading..."
    rm -rf bin/epubcheck-5.2.1
    curl -L "https://github.com/w3c/epubcheck/releases/download/v5.2.1/epubcheck-5.2.1.zip" -o "epub.zip"
    unzip "epub.zip" -d bin
    rm epub.zip
    bin/Java/jdk-24.0.2.jdk/Contents/Home/bin/java -jar bin/epubcheck-5.2.1/epubcheck.jar --version
fi

echo -e "${GREEN}Setup complete${RESET}"
