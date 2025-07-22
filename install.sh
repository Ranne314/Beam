#! /bin/bash

# Check if python3 is installed, install if not
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
fi

# Install dependencies from requirements.txt if exists
if [ -f requirements.txt ]; then
    pip3 install --user -r requirements.txt
fi

# Create target directory
sudo mkdir -p /usr/lib/Beam

# Move src/app.py to target directory
sudo mv src/app.py /usr/lib/Beam/

# Create a launcher script
sudo tee /usr/bin/beam > /dev/null <<EOF
#!/usr/bin/bash
python3 /usr/lib/Beam/src/app.py "\$@"
EOF
sudo chmod +x /usr/bin/beam

# Copy icon to pixmaps with correct name and extension
sudo cp ./beam.ico /usr/share/pixmaps/beam.ico

# Create a desktop entry for the app
sudo tee /usr/share/applications/beam.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Beam
Exec=beam
Icon=/usr/share/pixmaps/beam.ico
Type=Application
Categories=Utility;
EOF

echo "Beam installed successfully. You can launch it from the applications menu or by typing 'beam'."