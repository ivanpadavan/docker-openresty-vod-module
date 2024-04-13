# Docker NGINX VOD Module


A Dockerized openresty build with the `nginx-vod-module` for serving VOD content to DASH, HLS, and MSS.

* Start server:
```
docker-compose up
```

* Test
Add an MP4 to your videos directory

* DASH - http://localhost:8080/dash/video.mp4/manifest.mpd
* HLS - http://localhost:8080/hls/video.mp4/master.m3u8
* MSS - http://localhost:8080/mss/video.mp4/manifest

```
λ curl -I http://localhost:8080/dash/video.mp4/manifest.mpd
HTTP/1.1 200 OK
```

Use one of the players below to test playback.

# Test Players
HTML5 Players for testing.

* https://shaka-player-demo.appspot.com
* http://video-dev.github.io/hls.js/demo/
* http://orange-opensource.github.io/hasplayer.js/ 




# References
* https://www.openresty.com
* https://github.com/kaltura/nginx-vod-module
