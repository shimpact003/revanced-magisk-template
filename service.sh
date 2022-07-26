#!/system/bin/sh
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 1; done

# https://issuetracker.google.com/issues/80270303?pli=1
cp /data/adb/modules/ReVanced/com.google.android.youtube.apk /data/local/tmp
pm install -d /data/local/tmp/com.google.android.youtube.apk
cp /data/adb/modules/ReVanced/com.google.android.apps.youtube.music.apk /data/local/tmp
pm install -d /data/local/tmp/com.google.android.apps.youtube.music.apk
rm -rf /data/local/tmp/com.google.android.youtube.apk
rm -rf /data/adb/modules/ReVanced/com.google.android.youtube.apk
rm -rf /data/local/tmp/com.google.android.apps.youtube.music.apk
rm -rf /data/adb/modules/ReVanced/com.google.android.apps.youtube.music.apk

base_youtube_path="/data/adb/modules/ReVanced/revanced-root-signed.apk"
stock_youtube_path=$( pm path com.google.android.youtube | grep base | sed 's/package://g' )
base_music_path="/data/adb/modules/ReVanced/revanced-music-root-signed.apk"
stock_music_path=$( pm path com.google.android.apps.youtube.music | grep base | sed 's/package://g' )

chcon u:object_r:apk_data_file:s0  $base_youtube_path
mount -o bind $base_youtube_path $stock_youtube_path
chcon u:object_r:apk_data_file:s0  $base_music_path
mount -o bind $base_music_path $stock_music_path

sed '/tmp/d' /data/adb/modules/ReVanced/service.sh > changed.txt && mv changed.txt /data/adb/modules/ReVanced/service.sh
sed '/https/d' /data/adb/modules/ReVanced/service.sh > changed.txt && mv changed.txt /data/adb/modules/ReVanced/service.sh
