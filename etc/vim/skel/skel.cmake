cmake_minimum_required(VERSION 3.8)

project(app)

include($ENV{MY_LIBTT_WIN}/config.cmake)

add_executable(app main.cpp)
