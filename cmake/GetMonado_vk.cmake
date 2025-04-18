# module to download, build and install the Monado ILLIXR_vk plugin
get_external_for_plugin(OpenXR_APP)

find_program(MONADO_VK_FOUND
             monado_vk-service
             HINTS ${CMAKE_INSTALL_PREFIX}/bin
)

find_library(MONADO_VK_OXR_LIB_FOUND
             libopenxr_monado_vk${ILLIXR_BUILD_SUFFIX}.so
             HINTS ${CMAKE_INSTALL_PREFIX}/lib
)

find_library(MONADO_LIBRARY_FOUND
             libmonado.so
             HINTS ${CMAKE_INSTALL_PREFIX}/lib
)

if (MONADO_VK_FOUND AND MONADO_VK_OXR_LIB_FOUND AND MONADO_LIBRARY_FOUND)
    message(STATUS "Looking for monado_vk - found")
    set(Monado_vk_EXTERNAL NO)
else ()
    message(STATUS "Looking for monado_vk - not found\n      will be built from source")


    ExternalProject_Add(MonadoVK
                        GIT_REPOSITORY https://github.com/ILLIXR/monado_vulkan_integration.git   # Git repo for source code
                        GIT_TAG b4d67519ec3e4a5e0af7038bed62740fbf08712c       # sha5 hash for specific commit to pull (if there is no specific tag to use)

                        PREFIX ${CMAKE_BINARY_DIR}/_deps/monado_vk             # the build directory
                        DEPENDS ${Vulkan_DEP_STR}                              # dependencies of this module
                        #arguments to pass to CMake
                        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DILLIXR_PATH=${CMAKE_SOURCE_DIR}/include -DXRT_HAVE_LIBUDEV=ON -DXRT_HAVE_LIBUSB=ON -DXRT_HAVE_LIBUVC=OFF -DXRT_HAVE_V4L2=ON -DXRT_HAVE_SDL2=OFF -DXRT_BUILD_DRIVER_ANDROID=OFF -DXRT_BUILD_DRIVER_ARDUINO=OFF -DXRT_BUILD_DRIVER_DAYDREAM=OFF -DXRT_BUILD_DRIVER_DEPTHAI=OFF -DXRT_BUILD_DRIVER_EUROC=OFF -DXRT_BUILD_DRIVER_HANDTRACKING=OFF -DXRT_BUILD_DRIVER_HDK=OFF -DXRT_BUILD_DRIVER_HYDRA=OFF -DXRT_BUILD_DRIVER_NS=OFF -DXRT_BUILD_DRIVER_OHMD=OFF -DXRT_BUILD_DRIVER_OPENGLOVES=OFF -DXRT_BUILD_DRIVER_PSMV=OFF -DXRT_BUILD_DRIVER_PSVR=OFF -DXRT_BUILD_DRIVER_QWERTY=OFF -DXRT_BUILD_DRIVER_REALSENSE=OFF -DXRT_BUILD_DRIVER_REMOTE=OFF -DXRT_BUILD_DRIVER_RIFT_S=OFF -DXRT_BUILD_DRIVER_SURVIVE=OFF -DXRT_BUILD_DRIVER_ULV2=OFF -DXRT_BUILD_DRIVER_VF=OFF -DXRT_BUILD_DRIVER_VIVE=OFF -DXRT_BUILD_DRIVER_HANDTRACKING=OFF -DXRT_BUILD_DRIVER_WMR=OFF -DXRT_BUILD_DRIVER_SIMULAVR=OFF -DXRT_BUILD_DRIVER_SIMULATED=OFF -DXRT_BUILD_SAMPLES=OFF -DXRT_FEATURE_TRACING=OFF -DXRT_FEATURE_SERVICE=ON -DXRT_FEATURE_WINDOW_PEEK=OFF -DXRT_OPENXR_INSTALL_ABSOLUTE_RUNTIME_PATH=ON

                        # custom install command to get the name of the plugin correct
                        INSTALL_COMMAND cmake --install ./ && ln -sf ${CMAKE_INSTALL_PREFIX}/lib/libopenxr_monado_vk.so ${CMAKE_INSTALL_PREFIX}/lib/libopenxr_monado_vk${ILLIXR_BUILD_SUFFIX}.so
    )
    set(Monado_vk_EXTERNAL Yes)
    set(Monado_vk_DEP_STR Monado_VK)
endif ()
set(MONADO_RUNTIME "${CMAKE_INSTALL_PREFIX}/share/openxr/1/openxr_monado_vk.json" PARENT_SCOPE)
