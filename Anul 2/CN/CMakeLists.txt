cmake_minimum_required(VERSION 3.17)
project(CN)

set(CMAKE_CXX_STANDARD 14)

add_executable(CN main.cpp)

if(WIN32)
    target_link_libraries(CN wsock32 ws2_32)
endif()