#!/system/bin/sh
[ ! "$MODDIR" ] && MODDIR=${0%/*}
while [[ "$(getprop sys.boot_completed)" -ne 1 ]] && [[ ! -d "/sdcard" ]];do sleep 1; done
while [[ `getprop sys.boot_completed` -ne 1 ]];do sleep 1; done
sdcard_rw() {
until [[ $(getprop sys.boot_completed) -eq 1 || $(getprop dev.bootcomplete) -eq 1 ]]; do sleep 1; done
}
sdcard_rw
local interval=60
TARGET_FILE="/data/adb/tricky_store/target.txt"
touch "$TARGET_FILE"
installed_apps() {
	CURRENT_PACKAGES=$(pm list packages | sed 's/^package://; s/$/!/' | grep -v 'me.bmax.apatch\$' | grep -v 'com.android.patch\$' | grep -v 'com.google.android.gms\$')
    EXISTING_PACKAGES=$(grep -v '^#' "$TARGET_FILE")
	for NEW_PACKAGE in $CURRENT_PACKAGES; do
        if ! echo "$EXISTING_PACKAGES" | grep -q "$NEW_PACKAGE"; then
            echo "$NEW_PACKAGE" >> "$TARGET_FILE"
        fi
    done
}	
remove_uninstalled_apps() {
	CURRENT_PACKAGES=$(pm list packages | sed 's/^package://')
	while read -r REMOVE_PACKAGE; do
        if ! echo "$CURRENT_PACKAGES" | grep -q "$REMOVE_PACKAGE"; then
            sed -i "/^$REMOVE_PACKAGE!$/d" "$TARGET_FILE"
        fi
    done < "$TARGET_FILE"
}	
while true; do
    screen_status=$(dumpsys window | grep "mScreenOn" | grep true)
    if [[ "${screen_status}" ]]; then
    installed_apps
    remove_uninstalled_apps
	fi
    local now=$(date +%s)
    sleep $(( interval - (now % interval) ))
done


