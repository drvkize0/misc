#!/bin/bash

if [ -d "downloads" ]
then
rm -rf downloads
fi

boostdesc_names=( boostdesc_bgm.i \
	boostdesc_bgm_bi.i \
	boostdesc_bgm_hd.i \
	boostdesc_binboost_064.i \
	boostdesc_binboost_128.i \
	boostdesc_binboost_256.i \
	boostdesc_lbgm.i )

vgg_names=( vgg_generated_48.i \
	vgg_generated_64.i \
	vgg_generated_80.i \
	vgg_generated_120.i )

# download boostdesc
for item in ${boostdesc_names[*]}
do
wget https://raw.githubusercontent.com/opencv/opencv_3rdparty/34e4206aef44d50e6bbcd0ab06354b52e7466d26/$item -P ./downloads/boostdesc
done

# download vgg
for item in ${vgg_names[*]}
do
wget https://raw.githubusercontent.com/opencv/opencv_3rdparty/fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d/$item -P ./downloads/vgg
done

# download face
wget https://raw.githubusercontent.com/opencv/opencv_3rdparty/8afa57abc8229d611c4937165d20e2a2d9fc5a12/face_landmark_model.dat -P ./downloads/face