FFMPEG_FLAGS="
--enable-gpl
--enable-version3

--enable-decoder=h264
--enable-decoder=hevc
--enable-decoder=aac
--enable-decoder=mp3
--enable-decoder=vp9
--enable-decoder=opus

--enable-demuxer=mp4
--enable-demuxer=mkv
--enable-demuxer=ts
--enable-demuxer=flv

--enable-parser=h264
--enable-parser=hevc
--enable-parser=aac

--enable-protocol=file
--enable-protocol=http
--enable-protocol=https

--enable-swscale
--enable-swresample
"
