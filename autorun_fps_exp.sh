#!/bin/bash

# Base directory for experiments
base_dir="fps_exp"

# Create a directory based on the experiment name and current time
exp_name="fps_MH01"
	
current_time=$(date +"%Y%m%d-%H%M%S")
log_dir="${base_dir}/${exp_name}_${current_time}"
mkdir -p "$log_dir"

for i in 30 40 50 60 70 80 90 100 110 120 130 140
do
	echo "Starting to build $i FPS..."
	file="./fps_exp/_${i}.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished $i FPS build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	logfile="${log_dir}/MH01_${i}fps.log"
	echo "Starting exp: $i fps..."
	
	# build_dir="${base_dir}/build_ILLIXR/${i}fps_MH01"
	# rm -rf ./build
	# cp -rf $build_dir ./build/
	# echo "Copied $build_dir to build!"
	# cd ./build
	# cmake --install .
	# cd ..
	# echo "Installed $i fps experiment! exp starts now"

	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/experiment/Data/MH_01/mav0 --demo_data=/experiment/Developer/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp $i fps Finished in $duration seconds"
done
