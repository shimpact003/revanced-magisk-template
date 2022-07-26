#!/system/bin/sh

stock_youtube_path=$( pm path com.google.android.youtube | grep base | sed 's/package://g' )
stock_music_path=$( pm path com.google.android.apps.youtube.music | grep base | sed 's/package://g' )
umount -l $stock_youtube_path
umount -l $stock_music_path
