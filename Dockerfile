FROM jupyter/minimal-notebook:177037d09156
# Get the latest image tag at:
# https://hub.docker.com/r/jupyter/minimal-notebook/tags/
# Inspect the Dockerfile at:
# https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook/Dockerfile

# install additional package...
mkdir /mnt/mphdatastorage
if [ ! -d "/etc/smbcredentials" ]; then
mkdir /etc/smbcredentials
fi
if [ ! -f "/etc/smbcredentials/mphdatastorage.cred" ]; then
    bash -c 'echo "username=mphdatastorage" >> /etc/smbcredentials/mphdatastorage.cred'
    bash -c 'echo "password=6L2odFkARAqHukeXyCfUC/DzTXKOX0+J4wTi/zfGixr+RIVSis+4ESjItY9qF/2TT44juruXO2sarig8/tSAlQ==" >> /etc/smbcredentials/mphdatastorage.cred'
fi
chmod 600 /etc/smbcredentials/mphdatastorage.cred

bash -c 'echo "//mphdatastorage.file.core.windows.net/projectfileshare01 /mnt/mphdatastorage cifs nofail,vers=3.0,credentials=/etc/smbcredentials/mphdatastorage.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
mount -t cifs //mphdatastorage.file.core.windows.net/projectfileshare01 /mnt/mphdatastorage -o vers=3.0,credentials=/etc/smbcredentials/mphdatastorage.cred,dir_mode=0777,file_mode=0777,serverino