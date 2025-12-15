#!/bin/bash

#======================================================
# daily
#======================================================
f_cron_daily_update() {
  cmd.sh f_vim_plug_update
}
#======================================================
# weekly
#======================================================
f_cron_weekly_tags() {
  f_envs_tags
}
f_cron_weekly_build() {
  f_envs_tools
}
#======================================================
# monthly
#======================================================
f_cron_monthly_tags() {
  f_github_tags
}
f_cron_monthly_clean() {
  f_blender_clean
}
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
