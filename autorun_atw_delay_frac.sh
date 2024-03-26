#!/bin/bash

# Base directory for experiments
base_dir="atw_delay_frac"

# Create a directory based on the experiment name and current time
exp_name="atw_delay_frac_V102"
	
current_time=$(date +"%Y%m%d-%H%M%S")
log_dir="${base_dir}/${exp_name}_${current_time}"
mkdir -p "$log_dir"

for i in 70 80 90 95 100 110 120 130
do
	echo "Starting to build $i ATW Delay Frac..."
	file="./atw_delay_frac/_${i}.cpp"
	cp $file ./plugins/timewarp_gl/plugin.cpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished $i ATW Delay Frac build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	logfile="${log_dir}/V102_60_${i}.log"
	echo "Starting exp: $i ATW Delay Frac"

	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/Developer/Git/ILLIXR/data/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp $i ATW Delay Frac Finished in $duration seconds"
done