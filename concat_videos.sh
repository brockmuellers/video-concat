#!/bin/bash

# concatenate videos listed in the FILES file

# Sometimes scaling/SAR issues will pop up!
# First figure out which video is the culprit (might need to trim down
# `filenames.txt` until you've narrowed it down to one video), and then run the
# following command. Specific scale values don't seem to ultimately matter,
# so look at the output video and try out different scale values if it doesn't
# look right.
# 	`ffmpeg -i input.mp4 -vf scale=1280x720,setsar=1:1 output.mp4`

FILES=filenames.txt
OUTPUT=output.mp4

COUNTER=0
CMDINPUTS=""
CMDFILTER=""

while read f; do
	CMDINPUTS+="-i $f "
	CMDFILTER+="[$COUNTER:v:0][$COUNTER:a:0]"
	COUNTER=$((COUNTER+1))
done < $FILES

FILTERCOMPLEX=$CMDFILTER"concat=n=$COUNTER:v=1:a=1[outv][outa]"

ffmpeg $CMDINPUTS -filter_complex "$FILTERCOMPLEX" -map "[outv]" -map "[outa]" $OUTPUT

echo $CMDINPUTS
echo $CMDFILTER
echo $COUNTER
