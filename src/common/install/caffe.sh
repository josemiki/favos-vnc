#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Caffe"
workon cv
#apt-get -y install libopencv-dev python-opencv
apt-get -y install libopenblas-dev
apt-get -y install libatlas-base-dev
apt-get -y install libboost-all-dev
pip install protobuf

apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler 
apt-get -y install the python-dev 
apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev 
apt-get -y install protoc

git clone https://github.com/BVLC/caffe
cd caffe/
cp ~/install/Makefile.config .
###nano Makefile
make all
make test
make runtest
make pycaffe
export PYTHONPATH=~/caffe/python:$PYTHONPATH
