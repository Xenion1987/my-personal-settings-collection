#!/usr/bin/env python3

import subprocess
import json


def resolution_key(resolution):
    # Extract width and height from the resolution string and convert to integers
    width, height = map(int, resolution.split("x"))
    return width, height

def get_connected_displays():
    output = json.loads(subprocess.check_output(["swaymsg", "-t", "get_outputs"]))
    displays = []
    for display in output:
        name = display["name"]
        resolutions = []
        for mode in display["modes"]:
            resolution = str(mode["width"]) + "x" + str(mode["height"])
            refresh_rate = mode.get("current_mode", {}).get("refresh")
            if refresh_rate:
                resolution += f"@{refresh_rate}Hz"
            resolutions.append(resolution)
        resolutions = sorted(set(resolutions), key=resolution_key, reverse=True)  # Remove duplicates and sort resolutions
        displays.append({"name": name, "resolutions": resolutions})
    return displays

def print_display_info(display_info):
    print(f"Display: {display_info['name']}")
    print("Resolutions:")
    for resolution in display_info["resolutions"]:
        print("  -", resolution)

if __name__ == "__main__":
    connected_displays = get_connected_displays()
    for display in connected_displays:
        print_display_info(display)
        print()