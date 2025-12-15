#!/bin/bash

#------------------------------------------------------
# update
#------------------------------------------------------
f_cron_daily_update() {
  f_vim_plug_update
}
f_cron_monthly_update() {
  f_apt_update
  f_pip_upgrade
  f_vim_plug_update
}
#------------------------------------------------------
# tags
#------------------------------------------------------
f_cron_weekly_tags() {
  f_envs_tags
}
f_cron_monthly_tags() {
  f_github_tags
}
#------------------------------------------------------
# snap
#------------------------------------------------------
f_cron_monthly_snap() {
  f_snap
}
f_cron_monthly_snap_n() {
  f_snap_n
}
f_cron_monthly_snap_status() {
  f_snap_status
}
f_cron_monthly_snap_commit() {
  f_snap_commit
}
#------------------------------------------------------
# misc
#------------------------------------------------------
f_cron_weekly_build() {
  f_envs_tools
}
f_cron_monthly_clean() {
  f_blender_clean
}
f_cron_daily_sync_time() {
  sync-time.sh
}
#------------------------------------------------------
# init
#------------------------------------------------------
f_cron_init_install() {
  f_apt_update
  f_apt_install_min
  f_pip_upgrade
  f_pip_install_min
  f_vim_plug_upgrade
  f_vim_plug_install
}
