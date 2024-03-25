#!/bin/bash

# Base directory for experiments
base_dir="fps_exp"

# Create a directory based on the experiment name and current time
exp_name="fps_V102"
	
current_time=$(date +"%Y%m%d-%H%M%S")
log_dir="${base_dir}/${exp_name}_${current_time}"
mkdir -p "$log_dir"

for i in 30 40 50 60 70 80 90 100 110 120
do
	echo "Starting to build 120 SR and $i ATW Freq..."
	file="./fps_exp/120_${i}.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished 120 SR and $i ATW build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	logfile="${log_dir}/V102_120_${i}.log"
	echo "Starting exp: $i fps..."

	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/Developer/Git/ILLIXR/data/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp $i fps Finished in $duration seconds"
done

for i in 30 40 50 60 70 80 90 100 110 120
do
	echo "Starting to build $i SR and 120 ATW Freq..."
	file="./fps_exp/${i}_120.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished $i FPS build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	logfile="${log_dir}/V102_${i}_120.log"
	echo "Starting exp: $i fps..."

	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/Developer/Git/ILLIXR/data/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp $i fps Finished in $duration seconds"
done