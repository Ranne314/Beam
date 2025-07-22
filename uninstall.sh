#!/bin/bash

set -e

# Remove launcher script
sudo rm -f /usr/bin/beam

# Remove application directory and files
sudo rm -rf /usr/lib/Beam

# Remove icon from pixmaps
sudo rm -f /usr/share/pixmaps/beam.ico

# Remove desktop entry
sudo rm -f /usr/share/applications/beam.desktop

echo "Beam has been uninstalled."