---
title: ffmpeg note
date: 2019-11-10 21:59:24
tags:
---

# ffmpeg note

+ To Convert video to 720p
```bash
ffmpeg -i input.mp4 -s 1280x720 -b:v 1024k -bufsize 1024k output.avi
```

+ To set the video bitrate of the output file to 64 kbit/s:
```bash
ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi
```
+ To force the frame rate of the output file to 24 fps:
```
ffmpeg -i input.avi -r 24 output.avi
```
+ To remove audio
```bash
# -c:v copy copies the video stream.
# -an removes the audio stream.
ffmpeg -i input.mp4 -c:v copy -an output.mp4
```

+ To cut mp3

```bash
ffmpeg -i input.mp3 -ss 00:00:00 -t 00:00:01 -acodec copy output.mp3
```