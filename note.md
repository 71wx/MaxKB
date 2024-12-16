
-------------------------------------------------------

RUN rm -rf /opt/maxkb/model



sudo su

mkdir /tmp/overlay2
chmod 777 /tmp/overlay2
mkdir /tmp/overlay2/l
chmod 777 /tmp/overlay2/l

cd /var/lib/docker
rm -rf overlay2
ln -s /tmp/overlay2 overlay2 

exit

docker build -t maxkb -f installer/Dockerfile .

docker build -t vector-model -f installer/Dockerfile-vector-model .
docker save -o vector-model.tar vector-model


docker build -t python-pg -f installer/Dockerfile-python-pg .
docker save -o python-pg.tar python-pg

-------------------------------------------------------

ls -ld /tmp
chmod 1777 /tmp
apt update
apt install procps
apt install net-tools
netstat -tulnp


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm list
nvm install 18
nvm use 18

rm -rf package-lock.json 
npm install
npm run dev



cp -r /opt/maxkb/app/ui/ /opt/maxkb/app/oui/

tar czvf ui.tar.gz ./ui

cd /opt/maxkb/app/oui
chmod 777 ui

-------------------------------------------------------
docker run -d --name=maxkb --restart=always -p 3000:3000 -p 8080:8080 -p 5432:5432 -p 11636:11636 -v ./data/oui:/opt/maxkb/app/oui -v ./data/pgdata:/var/lib/postgresql/data -v ./data/sandbox-python:/opt/maxkb/app/sandbox/python-packages cr2.fit2cloud.com/1panel/maxkb
