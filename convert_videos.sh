#!/bin/bash

# convert all of our videos (in `originals` dir) to mp4s of same size (in `reencoded` dir)
# if video is already in `reencoded`, do nothing

INDIR=originals
OUTDIR=reencoded
for f in "$INDIR"/*; do

	basename "$f"
	BASENAME="$(basename -- $f)"
	NAME=`echo "$BASENAME" | cut -d'.' -f1`

	if [ ! -f "$OUTDIR/$NAME.mp4" ]; then
		echo "Converting file $NAME!"
        # some of these args may need to change on other platforms, especially acodec and vcodec
		ffmpeg \
            -i $INDIR/$BASENAME \
            -acodec ac3_fixed \
            -vcodec libx264 \
            -vf scale='w=1280:h=720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2' \
            -r 60 \
            -strict experimental \
            $OUTDIR/$NAME.mp4
	fi

done


