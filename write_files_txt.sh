#!/bin/bash

# write a file that lists all mp4s we're working with (the ones in the `reencoded` dir),
# with an "empty" video between

OUTDIR=reencoded
EMPTY_FILE_NAME=empty.mp4

touch filenames.txt
> filenames.txt
for f in "$OUTDIR"/*.mp4; do
	echo "$f" >> filenames.txt
	echo "$EMPTY_FILE_NAME" >> filenames.txt
done
cat filenames.txt
