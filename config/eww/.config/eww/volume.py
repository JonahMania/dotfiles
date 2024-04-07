#!/bin/python

from subprocess import Popen, PIPE
from re import findall
from argparse import ArgumentParser

class Volume:
    """
    Gets the current volume as an integer between 0 and 100
    """
    def get(self):
        volume_string = Popen("pactl get-sink-volume 0", shell=True, stdout=PIPE).stdout.read()
        return findall("([0-9]+)%", str(volume_string))[0]

    """
    Sets the current volume as an integer between 0 and 100
    """
    def set(self, volume):
        if volume >= 0 and volume <= 100:
            Popen("pactl set-sink-volume 0 " + str(volume) + "%", shell=True)

    """
    Increases the current volume by some integar volume between 0 and 100
    """
    def increase(self, volume):
        if volume >= 0 and volume <= 100:
            Popen("pactl set-sink-volume 0 +" + str(volume) + "%", shell=True)

    """
    Decreases the current volume by some integar volume between 0 and 100
    """
    def decrease(self, volume):
        if volume >= 0 and volume <= 100:
            Popen("pactl set-sink-volume 0 -" + str(volume) + "%", shell=True)

if __name__ == "__main__":
    parser = ArgumentParser(prog="volume")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-g", "--get", action="store_true", help="Get the current volume")
    group.add_argument("-s", "--set", type=int, help="Set the current volume")
    group.add_argument("-i", "--increase", type=int, help="Increase the current volume")
    group.add_argument("-d", "--decrease", type=int, help="Decrease the current volume")

    args = parser.parse_args()

    volume = Volume()

    if args.get:
        print(volume.get())
    elif args.set:
        volume.set(args.set)
    elif args.increase:
        volume.increase(args.increase)
    elif args.decrease:
        volume.decrease(args.decrease)
