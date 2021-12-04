sudo snap install intellij-idea-community --classic

sudo apt  install git

sudo snap install docker

sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
