#!/bin/bash

#------------------------------------------------------
# mycmake.sh
#------------------------------------------------------
mycmake-set-ninja-release() {
  mycmake.sh --set ninja Release
  source_bashrc
}

mycmake-set-ninja-debug() {
  mycmake.sh --set ninja Debug
  source_bashrc
}

mycmake-set-make-release() {
  mycmake.sh --set make Release
  source_bashrc
}

mycmake-set-make-debug() {
  mycmake.sh --set make Debug
  source_bashrc
}

mycmake-set-vs2017-release() {
  mycmake.sh --set vs2017 Release
  source_bashrc
}

mycmake-set-vs2017-debug() {
  mycmake.sh --set vs2017 Debug
  source_bashrc
}

mycmake-set-vs2017-reldeb() {
  mycmake.sh --set vs2017 RelWithDebInfo
  source_bashrc
}

mycmake-set-vs2019-release() {
  mycmake.sh --set vs2019 Release
  source_bashrc
}

mycmake-set-vs2019-debug() {
  mycmake.sh --set vs2019 Debug
  source_bashrc
}

mycmake-set-vs2019-reldeb() {
  mycmake.sh --set vs2019 RelWithDebInfo
  source_bashrc
}

