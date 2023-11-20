#! /bin/bash
 
cd /tmp
wget https://github.com/yhirose/cpp-httplib/archive/refs/tags/v0.14.1.tar.gz
tar -xvzf v0.14.1.tar.gz
cd cpp-httplib-0.14.1
meson setup build
ninja
sudo ninja install
sudo ldconfig
