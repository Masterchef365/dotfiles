# The 16.04 installer works with 16.10.
# download drivers
curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb

# download key to allow installation
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

# install actual package
sudo dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb

#  install cuda (but it'll prompt to install other deps, so we try to install twice with a dep update in between
sudo apt-get update
sudo apt-get install cuda-9-0  

curl -O https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.3.1/prod/9.0_2018927/Ubuntu16_04-x64/libcudnn7-dev_7.3.1.20-1-cuda9.0_amd64
curl -O https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.3.1/prod/9.0_2018927/Ubuntu16_04-x64/libcudnn7_7.3.1.20-1-cuda9.0_amd64
sudo dpkg -i libcudnn7_7.3.1.20-1-cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.3.1.20-1-cuda9.0_amd64.deb
