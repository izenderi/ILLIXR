#pragma once

#ifdef HAVE_ZED
    #include "illixr/data_format/camera_data.hpp"
    #include "illixr/data_format/opencv_data_types.hpp"
    #include "illixr/data_format/pose.hpp"

    #include <utility>

namespace ILLIXR::data_format {
/**
 * camera type for ZED, can hold images for left eye, eight eye, rgb image, and pose
 */
struct [[maybe_unused]] cam_type_zed : cam_base_type {
    std::size_t    serial_no;
    multi_pose_map poses;

    cam_type_zed(time_point _time, cv::Mat _img0, cv::Mat _img1, cv::Mat _rgb, cv::Mat _depth, cv::Mat _confidence,
                 std::size_t _serial_no, multi_pose_map _poses)
        : cam_base_type(_time,
                        {{image::LEFT_EYE, _img0},
                         {image::RIGHT_EYE, _img1},
                         {image::RGB, _rgb},
                         {image::DEPTH, _depth},
                         {image::CONFIDENCE, _confidence}},
                        camera::ZED)
        , serial_no{_serial_no}
        , poses{std::move(_poses)} { }
};

} // namespace ILLIXR::data_format
#endif
