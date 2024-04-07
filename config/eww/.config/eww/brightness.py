#!/bin/python

from subprocess import Popen, PIPE
from argparse import ArgumentParser
from os import listdir, path

class Brightness:
    def __init__(self, path):
        """
        """
        self.device_path = path if path else self.default_path()
        self.max = self.get_max()

    def get(self):
        """
        """
        command = f"cat {self.device_path}/brightness"
        value = int(Popen(command, shell=True, stdout=PIPE).stdout.read().decode("utf-8").strip())
        return self.to_percent(value)

    def set(self, brightness):
        """
        """
        value = self.to_raw(brightness)
        command = f"echo {value} > {self.device_path}/brightness"
        Popen(command, shell=True)

    def increase(self, brightness):
        """
        """
        value = self.get()
        value += brightness
        self.set(value)

    def decrease(self, brightness):
        """
        """
        value = self.get()
        value -= brightness
        self.set(value)

    def default_path(self):
        """
        """
        sys_path = "/sys/class/backlight"
        files = listdir(sys_path)
        return path.join(sys_path, files[0])

    def get_max(self):
        """
        Gets the max raw brightness value

        :return: The max raw brightness value
        """
        command = f"cat {self.device_path}/max_brightness"
        return int(Popen(command, shell=True, stdout=PIPE).stdout.read().decode("utf-8").strip())

    def to_raw(self, percent):
        """
        """
        if percent < 0 or percent > 100:
            raise ValueError("Percentage value must be between 0 and 100")
        return round((percent / 100) * self.max)

    def to_percent(self, raw):
        """
        Converts a raw brightness value to a percent value

        :param raw: Raw value to convert (must be greater than 0 and less than the max brightness
                    value)
        :return: Percent value
        """
        if raw < 0 or raw > self.max:
            raise ValueError(f"Raw value must be between 0 and {self.max}")
        return round((raw / self.max) * 100)

if __name__ == "__main__":
    parser = ArgumentParser(prog="brightness")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-g", "--get", action="store_true", help="Get the current brightness")
    group.add_argument("-s", "--set", type=int, help="Set the current brightness")
    group.add_argument("-i", "--increase", type=int, help="Increase the current brightness")
    group.add_argument("-d", "--decrease", type=int, help="Decrease the current brightness")
    parser.add_argument("-p", "--path", type=str, help="System brightness file path")

    args = parser.parse_args()

    brightness = Brightness(args.path)

    if args.get:
        print(brightness.get())
    elif args.set:
        brightness.set(args.set)
    elif args.increase:
        brightness.increase(args.increase)
    elif args.decrease:
        brightness.decrease(args.decrease)
