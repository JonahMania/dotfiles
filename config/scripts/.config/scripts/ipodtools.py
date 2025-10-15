#!/bin/python3
from argparse import ArgumentParser
from pathlib import Path
from subprocess import check_output, run
from shutil import which
import json
import os

class IPodTools:
    def __init__(self, path: str):
        self.path = path
        self.mp3_files = []
        self.flac_files = []

        if os.path.isfile(self.path):
            p = Path(self.path)
            if p.suffix == ".mp3":
                self.mp3_files.append(p.absolute().as_posix()) 
            if p.suffix == ".flac":
                self.flac_files.append(p.absolute().as_posix()) 
        else:
            for p in Path(self.path).glob("**/*.mp3"):
                self.mp3_files.append(p.absolute().as_posix())
            for p in Path(self.path).glob("**/*.flac"):
                self.flac_files.append(p.absolute().as_posix())

        print(f"Found {len(self.mp3_files)} mp3 files")
        print(f"Found {len(self.flac_files)} flac files")

    def toMp3(self):
        if len(self.flac_files) == 0:
            print(f"No flac files found at path \"{self.path}\"")
            return

        response = self.promptBool(f"Convert {len(self.flac_files)} flac files to mp3? [y/n]:")
        if not response:
            return

        for flac_file in self.flac_files:
            mp3_file = Path(flac_file).with_suffix(".mp3")
            run(["ffmpeg", "-i", flac_file, "-ab", "320k", "-map_metadata", "0", "-id3v2_version",
                 "3", mp3_file])
            self.mp3_files.append(mp3_file)

        response = self.promptBool(
                f"Remove all {len(self.flac_files)} flac files under {self.path}? [y/n]: ")
        if response:
            for flac_file in self.flac_files:
                run(["rm", flac_file])
            self.flac_files = []

    def setArtist(self, artist: str):
        if not artist:
            artist = self.detectArtist()
            user_input = self.promptString(f"Artist name ({artist}):")
            if user_input != "":
                artist = user_input

        print(f"New artist: {artist}")
        response = self.promptBool(
                f"Update all {len(self.mp3_files)} files under {self.path}? [y/n]: ")
        if response:
            for mp3_file in self.mp3_files:
                output_file = Path(mp3_file)
                output_file = Path(output_file.parent,
                    f"{output_file.stem}__output__{output_file.suffix}")
                run(["ffmpeg", "-i", mp3_file, "-metadata", f"artist={artist}", "-codec",
                     "copy", output_file])
                run(["mv", output_file, mp3_file])

    def resizeImages(self):
        pass

    def detectArtist(self) -> str | None:
        names = {}
        for mp3_file in self.mp3_files:
            json_output = check_output(["ffprobe", mp3_file, "-of", "json", "-show_entries",
                                        "format_tags", "-v", "quiet"])
            output = json.loads(json_output)
            name = output["format"]["tags"]["artist"]
            names[name] = names[name] + 1 if name in names else 1
        return max(names, key=names.get) if len(names) > 0 else None

    def promptBool(self, question: str) -> bool:
        user_input = input(question).lower()
        return user_input == "yes" or user_input == "y"

    def promptString(self, question: str) -> str:
        return input(question)

def getArgs():
    parser = ArgumentParser()

    # Required arguments
    parser.add_argument("path", type=str, action="store",
                        help="A filepath or directory path to search")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--to-mp3", action="store_true", help="convert all files to mp3")
    group.add_argument("--set-artist", action="store_true", help="set an artist in all files")
    group.add_argument("--create-images", action="store_true", help="create IPod friendly image sizes")
    group.add_argument("--all", action="store_true", help="run all commands")

    # Optional arguments
    parser.add_argument("--artist-name", type=str, action="store", help="an artist name to use")

    return parser.parse_args()

def main():
    args = getArgs()
    ipod = IPodTools(args.path)

    if not which("ffmpeg"):
        print("Please install ffmpeg to use this tool")
        return

    if args.to_mp3:
        ipod.toMp3()
    if args.set_artist:
        ipod.setArtist(args.artist_name)
    if args.create_images:
        print("create images")
    if args.all:
        ipod.toMp3()
        ipod.setArtist(args.artist_name)

if __name__ == "__main__":
    main()
