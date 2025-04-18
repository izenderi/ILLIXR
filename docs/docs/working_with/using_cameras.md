
# Using Cameras with ILLIXR

ILLIXR supports a wide range of cameras, most of which are for the purpose of feeding images and IMU measurements to the system. <br>
*To learn more about how it works, checkout [Getting Started][12].* <br>
*If you are interested in what topics these cameras feed into, checkout [ILLIXR plugins][P10].*


!!! info
   
    Before running any of these plugins below, it is important to not have `offline_cam` and `offline_imu` in your plugin list for the executable (either via yaml file or command line).

## Add Calibration Parameters
In order to add your camera's calibration extrinsics, you need to modify your choice of SLAM/VIO plugin. Follow these instructions to [modify a plugin][21].

-   [`OpenVINS`][E16]:
    
    Navigate to `ov_msckf/src`.<br>
    Uncomment [this line][E13] out in `slam2.cpp` in order to use ZED's calibration parameter for OpenVins. <br>
    You can add your own calibration parameters in the same file.     

## ZED Mini

1. **Install ZED SDK** 

    Install the latest version of the ZED SDK on [stereolabs.com][E11].<br>
    For more information, checkout the [ZED API documentation][E12].

2. **Get ZED's calibration parameters**

    Both OpenVINS have a decent calibration parameters for ZED. But if you wish to add your own: 
    
        /usr/local/zed/tools/ZED_Calibration

    Your original factory calibration file is stored here

        /usr/local/zed/settings/

    Or download it from [calib.stereolabs.com][E18].

3. **Enable ZED in OpenVINS plugin**

    This step is only required if using OpenVINS. Uncomment this [line][E19] in the OpenVINS plugin. 

4. **Run ILLIXR with ZED:**  

    Add `zed` to the plugins list in any yaml profile file and run ILLIXR normally.

## Intel Realsense 

ILLIXR has been tested with Intel RealSense D455, but it should work with any D or T series RealSense Camera. 

1. **Install librealsense (if you haven't already):**

    Instruction on how to install can be found [here][E14].

2. **Get RealSense calibration parameters:**

    Navigate to `enumerate-devices`
    
        ./PATH/TO/LIBREALSENSE/build/tools/enumerate-devices 

    Run this command to obtain the calibration parameters

        ./rs-enumerate-devices -c

3. **Run ILLIXR with RealSense:**  

    Add `realsense` to the plugins list in any yaml profile file and run ILLIXR normally.
    
    !!! note 
 
        We will release the corresponding `#define realsense` soon for OpenVINS + Realsense


[//]: # (- plugins -)

[P10]: ../illixr_plugins.md

[//]: # (- external -)

[E11]: https://www.stereolabs.com/docs/installation/linux/
[E12]: https://www.stereolabs.com/docs/api/
[E13]: https://github.com/ILLIXR/open_vins/blob/43b42dddaf9d3b8e6257e0bb8a91053b59a677e4/ov_msckf/src/slam2.cpp#L24
[E14]: https://github.com/IntelRealSense/librealsense/blob/development/doc/distribution_linux.md
[E16]: https://github.com/ILLIXR/open_vins
[E18]: https://www.stereolabs.com/developers/calib/
[E19]: https://github.com/ILLIXR/open_vins/blob/820a4dcba4423366233da1cb60d8b3b4bf2960e4/ov_msckf/src/slam2.cpp#L24

[//]: # (- Internal -)

[11]:   writing_your_plugin.md
[12]:   ../getting_started.md
[21]:   modifying_a_plugin.md
