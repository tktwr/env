$rfc3339 = "yyyy-MM-dd HH:mm:ss.fffffff00zzz"
Get-Date -Format $rfc3339; wsl date --rfc-3339=ns; Get-Date -Format $rfc3339
