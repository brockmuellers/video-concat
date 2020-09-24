# video-concat
Concat videos using ffmpeg. Videos can be any size or format.

## Instructions

#### Create directories
Create two new directories in the repo's root directory: `originals` and `reencoded`.

#### Collect videos
Collect videos, which can be of any size or format. Put them in the `originals` directory. They should have unique names, regardless of extension.

#### Convert videos to have matching parameters
Run `convert_videos.sh`. This produces a new video for each video in the `originals` directory. All of the new videos will be written to `reencoded`, and will have the same codecs, format (mp4), dimensions (1280x720), and aspect ratio (will be padded with black if necessary). 

If a video already exists in `reencoded`, the script will do nothing. This means that you can add new videos to `originals` and rerun the script without reconverting all videos.

Depending on your operating system, you may need to edit the ffmpeg args in the script, especially `acodec` and `vcodec`. Use google - there's lots of ffmpeg info online.

#### Produce list of video filenames
Run `write_files_txt.sh`. This produces a new file (`filenames.txt`), with one entry per video in `reencoded`, and an `empty.mp4` entry between each one. 

The `empty.mp4` video is a two second, black video, which has matching parameters to the `reencoded` videos.

#### Order videos as desired
Rearrange entries in `filenames.txt`, if desired. The order of entries will be the order of videos in the final output.

#### Concatenate videos
Run `concat_videos.sh`, which will produce an `output.mp4` from the videos in `filenames.txt`.

Occasionally scaling/SAR issues will pop up. To fix:
1) First figure out which video is the culprit (might need to trim down `filenames.txt` and repeatedly run `concat_videos.sh` until you've narrowed it down to one video).
2) Run the following command: `ffmpeg -i originals/{NAME}.{EXTENSION} -vf scale=1280x720,setsar=1:1 originals/{NAME}1.mp4`
3) Look at the output video. The aspect ratio may be off. Try rerunning the command with different `scale` values until the output looks right.
4) Replace the problematic video with the new one, and clear the reencoded video so we can reencode the new version: `rm originals/{NAME}.{EXTENSION} && mv originals/{NAME}1.mp4 originals/{NAME}.mp4`
5) Clear the old reencoded video and reencode the new version: `rm reencoded/{NAME}.mp4 && convert_videos.sh`
6) Now try to concat the videos again! There may be more than one problematic video so this process may need to happen multiple times. All of this could probably be automated, but that's a feature for the future.

#### System

Using `ffmpeg version 3.4.6-0ubuntu0.18.04.1`

#### Suggested use
Collect celebratory videos from friends and family for some special person's birthday or accomplishment. Concatenate the videos, and give the special person the result. If you're lucky, you may alleviate a modicum of our collective COVID isolatoin.
