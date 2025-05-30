#include "plugin.hpp"

#include "illixr/relative_clock.hpp"

#include <opencv2/imgproc.hpp>

using namespace ILLIXR;
using namespace ILLIXR::data_format;

[[maybe_unused]] webcam::webcam(const std::string& name_, phonebook* pb_)
    : threadloop{name_, pb_}
    , switchboard_{pb_->lookup_impl<switchboard>()}
    , frame_pub_{switchboard_->get_writer<monocular_cam_type>("webcam")} {
    const char* video_stream = switchboard_->get_env_char("INPUT_VIDEO");
    load_video_              = video_stream != nullptr;
    if (load_video_) {
        capture_.open(video_stream);
    } else {
        capture_.open(0);
    }
    if (!capture_.isOpened()) {
        throw std::runtime_error("Cannot open camera");
    }
#if (CV_MAJOR_VERSION >= 3) && (CV_MINOR_VERSION >= 2)
    capture_.set(cv::CAP_PROP_FRAME_WIDTH, 640);
    capture_.set(cv::CAP_PROP_FRAME_HEIGHT, 480);
    capture_.set(cv::CAP_PROP_FPS, 30);
#endif
}

void webcam::_p_one_iteration() {
    cv::Mat camera_frame_raw;
    capture_ >> camera_frame_raw;
    if (camera_frame_raw.empty())
        return;
    cv::Mat camera_frame;
    cv::cvtColor(camera_frame_raw, camera_frame, cv::COLOR_BGR2RGB);
    time_point current_time(
        std::chrono::duration<long, std::nano>{std::chrono::system_clock::now().time_since_epoch().count()});
    frame_pub_.put(frame_pub_.allocate<monocular_cam_type>({current_time, camera_frame}));
}

PLUGIN_MAIN(webcam)
