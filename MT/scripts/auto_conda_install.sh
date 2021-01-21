##download conda
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
##permission adjust 
chmod +x Miniconda3-latest-Linux-x86_64.sh
##install
sudo bash ./Miniconda3-latest-Linux-x86_64.sh -b -f -p /usr/local
##conda inition
conda init bash
##permission_to_write
sudo chown -R $USER ~/.conda
