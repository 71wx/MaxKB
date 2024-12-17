#!/bin/bash

chmod 777 /opt
mkdir /opt/maxkb
mkdir /opt/maxkb/model
mkdir /opt/maxkb/model/embedding
cd /opt/maxkb
cp /workspaces/MaxKB/installer/install_model.py .
pip install pycrawlers

pip3 install --upgrade pip setuptools
pip install pycrawlers
pip install transformers
python3 install_model.py
