#!/bin/bash

# Check if the number of repetitions is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number_of_repetitions>"
    exit 1
fi

# Number of times to execute the command
n=$1

# Loop and execute the command n times, logging each execution to a separate file
for (( i=1; i<=n; i++ ))
do
    logfile="log_MH05_${i}.txt"
    echo "Starting exp$i..."

    # Special Variable SECONDS
    SECONDS=0
    main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,ground_truth_slam,gldemo,timewarp_gl,debugview,offload_data,audio_pipeline --vis=openvins --data=/home/ziliang/data/MH_05/mav0 --demo_data=/home/ziliang/Developer/Git/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1
    # main.dbg.exe --plugins=offline_imu,offline_cam,gtsam_integrator,pose_prediction,ground_truth_slam,gldemo,timewarp_gl,debugview,offload_data,audio_pipeline --vis=openvins --data=/experiment/Data/MH05/mav0 --demo_data=/experiment/Developer/ILLIXR/demo_data --enable_offload=false --enable_alignment=false --enable_verbose_errors=false --enable_pre_sleep=false > "$logfile" 2>&1

    duration=$SECONDS
    echo "exp$i Finished in $duration seconds"
done
