#!/bin/bash -e
./setup_mac.sh
./setup_xros.sh
./build_mac.sh
./build_xros.sh
./merge.sh