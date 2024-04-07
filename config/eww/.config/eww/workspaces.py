#!/bin/python

from socket import socket, AF_UNIX, SOCK_STREAM
from os import environ
from subprocess import Popen, PIPE
from json import loads, dumps
from sys import stdout

class Workspaces:
    """
    Constructor to create and connect to the hyprland ipc socket
    """
    def __init__(self):
        self.hyprland_socket = socket(AF_UNIX, SOCK_STREAM)
        self.hyprland_socket.connect(self.hyprland_address)

    """
    Deconstructor to disconnect from the hyprland ipc socket
    """
    def __del__(self):
        self.hyprland_socket.close()

    """
    Get the hyprland unix socket address
    """
    @property
    def hyprland_address(self):
        hyprland_instance_signature = environ.get('HYPRLAND_INSTANCE_SIGNATURE')
        return "/tmp/hypr/" + hyprland_instance_signature + "/.socket2.sock"

    """
    Listen for changes on the hyprland socket and print workspace changes to standard out
    """
    def listen(self):
        while(self.hyprland_socket.recv(1000)):
            self.print_workspaces()

    """
    Get and parse hyprland workspaces
    """
    def print_workspaces(self):
        workspaces_raw = Popen("hyprctl workspaces -j", shell=True, stdout=PIPE).stdout.read()
        monitors_raw = Popen("hyprctl monitors -j", shell=True, stdout=PIPE).stdout.read()
        workspaces_json = loads(workspaces_raw)
        monitors_json = loads(monitors_raw)
        formatted = self.format_workspaces(workspaces_json, monitors_json)
        stdout.write(dumps(formatted) + "\n")
        stdout.flush()

    """
    Format hyprland workspaces json
    """
    def format_workspaces(self, workspaces_json, monitors_json):
        active_workspaces = list(map(lambda m: m["activeWorkspace"]["id"], monitors_json))
        return list(map(lambda w: {
            "id": w["id"],
            "windows": w["windows"],
            "state": "active" if w["id"] in active_workspaces else "occupied" if w["windows"] > 0 else "empty"
        }, workspaces_json))

if __name__ == "__main__":
    workspaces = Workspaces()
    workspaces.print_workspaces()
    workspaces.listen()
