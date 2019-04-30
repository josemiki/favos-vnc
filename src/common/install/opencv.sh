#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install OpenCV"
apt-get update 
apt-get -y install nano
apt-get update && apt-get -y upgrade
apt-get -y install build-essential cmake pkg-config
apt-get -y install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get -y install libxvidcore-dev libx264-dev
apt-get -y install libgtk-3-dev
apt-get -y install libatlas-base-dev gfortran
apt-get -y install python2.7-dev python3.5-dev
cd ~
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install virtualenv virtualenvwrapper
rm -rf ~/get-pip.py ~/.cache/pip

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

source ~/.bashrc

mkvirtualenv cv -p python2
workon cv
pip install numpy
apt-get -y install unzip
cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
unzip opencv_contrib.zip

cd ~/opencv-3.1.0/
mkdir build
cd build/
cmake -D CMAKE_BUILD_TYPE=RELEASE     -D CMAKE_INSTALL_PREFIX=/usr/local     -D INSTALL_PYTHON_EXAMPLES=ON     -D INSTALL_C_EXAMPLES=OFF     -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules     -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python -D WITH_CUDA=OFF -D WITH_MATLAB=OFF   -D BUILD_EXAMPLES=ON ..
make -j8
make install
ldconfig

cd ~/.virtualenvs/cv/lib/python2.7/site-packages/
ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so
cd ~
rm -rf opencv-3.1.0 opencv_contrib-3.1.0 opencv.zip opencv_contrib.zip
