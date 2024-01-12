#!/bin/bash

# Check if the number of repetitions is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_repetitions>"
    exit 1
fi

# Number of times to execute the command
n=$1

# Base directory for experiments
base_dir="exps"

# Check if the base directory exists, if not, create it
if [ ! -d "$base_dir" ]; then
    mkdir -p "$base_dir"
    echo "exps folder not exist. Created exps first"
fi

# Create a directory based on the experiment name and current time
exp_name="MH05"
current_time=$(date +"%Y%m%d-%H%M%S")
log_dir="${base_dir}/${exp_name}_${current_time}"
echo "Creating $log_dir for $n times of exps"
mkdir -p "$log_dir"

# Loop and execute the command n times, logging each execution to a separate file
for (( i=1; i<=n; i++ ))
do
    logfile="${log_dir}/log_MH05_${i}.txt"
    echo "Starting exp$i..."

    # Special Variable SECONDS
    SECONDS=0
    main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,ground_truth_slam,gldemo,timewarp_gl,debugview,offload_data,audio_pipeline --vis=openvins --data=/home/ziliang/data/MH_05/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
    # main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,ground_truth_slam,gldemo,timewarp_gl,debugview,offload_data,audio_pipeline --vis=openvins --data=/experiment/Data/MH05/mav0 --demo_data=/experiment/Developer/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1

    duration=$SECONDS
    echo "exp$i Finished in $duration seconds"
    echo "Next exp starts in 10 seconds"
    sleep 10
done
