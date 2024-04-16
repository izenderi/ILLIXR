#!/bin/bash

# Base directory for experiments
base_dir="sr_exp"

current_time=$(date +"%Y%m%d-%H%M%S")
log_dir="${base_dir}/${current_time}"
mkdir -p "$log_dir"

for i in 2 4 6 8 10 12 14 16 18 20 25 30 40 50
do
	echo "Starting to build 120 FPS and $i SR Delay..."
	file="./fps_exp/_120.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	file="./${base_dir}/plugin_${i}.cpp"
	cp $file ./plugins/gldemo/plugin.cpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished 120 FPS $i SR Delay build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	# TODO1: Change the --data and --demo_data to the correct path in V102
	logfile="${log_dir}/V102_120fps_${i}sr.log"
	echo "Starting exp: 120 fps $i sr delay..."
	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/data/V1_02/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp 120 fps $i sr delay Finished in $duration seconds"

	sleep 5
done

for i in 2 4 6 8 10 12 14 16 18 20 25 30 40 50
do
	echo "Starting to build 90 FPS and $i SR Delay..."
	file="./fps_exp/_90.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	file="./${base_dir}/plugin_${i}.cpp"
	cp $file ./plugins/gldemo/plugin.cpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished 90 FPS $i SR Delay build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	# TODO1: Change the --data and --demo_data to the correct path in V102
	logfile="${log_dir}/V102_90fps_${i}sr.log"
	echo "Starting exp: 90 fps $i sr delay..."
	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/data/V1_02/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp 90 fps $i sr delay Finished in $duration seconds"

	sleep 5
done

for i in 2 4 6 8 10 12 14 16 18 20 25 30 40 50
do
	echo "Starting to build 60 FPS and $i SR Delay..."
	file="./fps_exp/_60.hpp"
	cp $file ./include/illixr/global_module_defs.hpp
	echo "file passed: $file"
	file="./${base_dir}/plugin_${i}.cpp"
	cp $file ./plugins/gldemo/plugin.cpp
	echo "file passed: $file"
	bash rebuild.sh
	echo "Finished 60 FPS $i SR Delay build!"

	echo "Exp starts in 10 seconds"
	sleep 10

	# TODO1: Change the --data and --demo_data to the correct path in V102
	logfile="${log_dir}/V102_60fps_${i}sr.log"
	echo "Starting exp: 60 fps $i sr delay..."
	# Special Variable SECONDS
	SECONDS=0
	main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,gldemo,timewarp_gl --vis=openvins --data=/home/ziliang/data/V1_02/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
	duration=$SECONDS
	echo "exp 60 fps $i sr delay Finished in $duration seconds"

	sleep 5
done
