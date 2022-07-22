#! /bin/bash
#
# Diffusion youtube avec ffmpeg

# Configurer youtube avec une résolution 720p. La vidéo n'est pas scalée.

VBR="80k"                                    # reduce lag by lowering VBR
FPS="10"                                       # lower this fps for good performance
QUAL="ultrafast"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://x.rtmp.youtube.com/live2"  # URL de base RTMP youtube

SOURCE="video.mp4"              # Name it whatever you want it will be the name of your .mp4 source
KEY="$KEY"                                     # Clé à récupérer sur l'event youtube

ffmpeg \
    -stream_loop -1 -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"
