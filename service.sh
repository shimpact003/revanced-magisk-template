#!/system/bin/sh
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 1; done

# https://issuetracker.google.com/issues/80270303?pli=1
cp /data/adb/modules/ReVanced/com.google.android.youtube.apk /data/local/tmp
pm install -d /data/local/tmp/com.google.android.youtube.apk
rm -rf /data/local/tmp/com.google.android.youtube.apk
rm -rf /data/adb/modules/ReVanced/com.google.android.youtube.apk

base_path="/data/adb/modules/ReVanced/revanced-root-signed.apk"
stock_path=$( pm path com.google.android.youtube | grep base | sed 's/package://g' )

chcon u:object_r:apk_data_file:s0  $base_path
mount -o bind $base_path $stock_path

sed '/tmp/d' /data/adb/modules/ReVanced/service.sh > changed.txt && mv changed.txt /data/adb/modules/ReVanced/service.sh
sed '/https/d' /data/adb/modules/ReVanced/service.sh > changed.txt && mv changed.txt /data/adb/modules/ReVanced/service.sh