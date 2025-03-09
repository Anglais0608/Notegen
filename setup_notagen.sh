#!/bin/bash

# Update and install dependencies
echo "Updating system and installing necessary packages..."
sudo apt update && sudo apt install -y git unzip wget python3-pip

# Install Gradle (if not installed)
if ! command -v gradle &> /dev/null; then
    echo "Gradle not found. Installing Gradle..."
    wget https://services.gradle.org/distributions/gradle-8.5-bin.zip -P /tmp
    sudo unzip -d /opt/gradle /tmp/gradle-8.5-bin.zip
    echo "export PATH=\$PATH:/opt/gradle/gradle-8.5/bin" >> ~/.bashrc
    source ~/.bashrc
else
    echo "Gradle is already installed."
fi

# Clone the NotaGen repository
echo "Cloning NotaGen repository..."
git clone https://github.com/ElectricAlexis/NotaGen.git
cd NotaGen || exit

# Install Python dependencies (if applicable)
echo "Installing Python dependencies..."
pip3 install -r requirements.txt

# Build project (if needed)
if [ -f "build.gradle" ]; then
    echo "Building the project with Gradle..."
    gradle build
fi

echo "Setup complete! You can now run NotaGen."
