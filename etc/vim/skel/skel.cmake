cmake_minimum_required(VERSION 3.8)

project(app)

if(WIN32)
  include($ENV{MY_LIBTT_WIN}/default.cmake)
else()
  include($ENV{MY_LIBTT}/default.cmake)
endif()

add_executable(app main.cpp)
