add_executable(cpphttpserver main.cpp)
find_package(AWSSDK REQUIRED COMPONENTS lambda sts)

# TODO: try static linking
target_link_libraries(cpphttpserver
    # Keep the list of files sorted from down to top.
    ${AWSSDK_LINK_LIBRARIES}
    nghttp2_asio
    nghttp2
    boost_thread
    boost_filesystem
    boost_system
    ssl
    crypto
    dl
    pthread
)


