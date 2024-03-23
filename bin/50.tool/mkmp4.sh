#!/bin/bash

ffmpeg -framerate 8 -pattern_type glob -i '*.png' -r 24 -c:v libx264 -pix_fmt yuv420p out.mp4
