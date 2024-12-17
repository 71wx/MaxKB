#!/bin/bash

cd /workspaces/MaxKB
rm -rf  /opt/maxkb/app/


cp -r . /opt/maxkb/app/
cd /opt/maxkb/app

pip install poetry
if [ "$(uname -m)" = "x86_64" ]; then sed -i 's/^torch.*/torch = {version = "^2.2.1+cpu", source = "pytorch"}/g' pyproject.toml; fi
cat pyproject.toml
poetry install

# Set environment variables
export MAXKB_VERSION="dev20241217"
export MAXKB_CONFIG_TYPE="ENV"
export MAXKB_DB_NAME="postgres"
export MAXKB_DB_HOST="127.0.0.1"
export MAXKB_DB_PORT="5432"
export MAXKB_DB_USER="username"
export MAXKB_DB_PASSWORD="password"
export MAXKB_EMBEDDING_MODEL_NAME="/opt/maxkb/model/embedding/shibing624_text2vec-base-chinese"
export MAXKB_EMBEDDING_MODEL_PATH="/opt/maxkb/model/embedding"
export MAXKB_SANDBOX="1"
export LANG="en_US.UTF-8"
export POSTGRES_USER="username"
export POSTGRES_PASSWORD="password"

cd /opt/maxkb/app

mkdir -p /opt/maxkb/app/sandbox/python-packages
find /opt/maxkb/app -mindepth 1 -not -name 'sandbox' -exec chmod 700 {} + 
chmod 755 /tmp  
useradd --no-create-home --home /opt/maxkb/app/sandbox --shell /bin/bash sandbox 
chown sandbox:sandbox /opt/maxkb/app/sandbox

cd /opt/maxkb/app
python /opt/maxkb/app/main.py start
