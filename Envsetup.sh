#!/bin/bash
set -e
echo "Starting Maven project setup..."

# Step 1: Install Java 17
if ! java -version &>/dev/null; then
    echo "Installing Java 17..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk
else
    echo "Java is already installed:"
    java -version
fi

# Set JAVA_HOME
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which java))))
if ! grep -q "JAVA_HOME=$JAVA_HOME_PATH" /etc/environment; then
    echo "Setting JAVA_HOME..."
    echo "JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /etc/environment
    echo "export JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /etc/profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile
    source /etc/profile
    echo "JAVA_HOME set to $JAVA_HOME_PATH"
else
    echo "JAVA_HOME is already set."
fi

# Step 2: Install Maven
if ! mvn -version &>/dev/null; then
    echo "Installing Maven..."
    sudo apt install -y maven
else
    echo "Maven is already installed:"
    mvn -version
fi
echo "Environment setup completed. You can now build and run the application manually."
