#!/bin/bash

if [ -d "downloads" ]
then
rm -rf downloads
fi

wget https://raw.githubusercontent.com/opencv/opencv_3rdparty/32e315a5b106a7b89dbed51c28f8120a48b368b4/ippicv/ippicv_2019_lnx_intel64_general_20180723.tgz -P ./downloads/ippicv
