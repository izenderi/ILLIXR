## log_file

## timewarp latency breakdown:
plugins/timewarp_gl/plugin.cpp line 846 latency_rtd, latency_mtd ...

## IMU integration control
plugins/gtsam_integrator/plugin.cpp line 204 //// Need to integrate over a sliding window of 2 imu_type values.

# Make sure to set the following before running exp on Xavier
* jtop: set the power mode from the GUI or here
* jtop: jetson_clocks has to run to fix frequency (6 ctrl in jtop)