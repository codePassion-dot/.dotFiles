#!/usr/bin/env python3
# Prints one JSON line for Waybar: {"text": "...", "class": "...", "tooltip": "..."}
# Env:
#   SEGS     -> number of cells (default 6)
#   PCT_POS  -> "start" or "end" (default "end")

import os
import json
import shutil
import subprocess
import sys
from typing import Tuple

WPCTL = shutil.which("wpctl") or "/usr/bin/wpctl"


def run_wpctl(args: list[str]) -> str:
    try:
        out = subprocess.run(
            [WPCTL, *args],
            check=False,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
        return out.stdout or ""
    except Exception:
        return ""


def get_volume() -> Tuple[str, float | None]:
    """
    Returns ("MUTED", None) if muted,
            ("OK", value) with 0..1 float,
            ("ERR", None) on error
    """
    line = run_wpctl(["get-volume", "@DEFAULT_AUDIO_SINK@"]).strip()
    if not line:
        return "ERR", None
    # Examples: "Volume: 0.45", "Volume: 0.45 [MUTED]"
    muted = "[MUTED]" in line
    try:
        val = float(line.split()[1])
    except Exception:
        return "ERR", None
    if muted:
        return "MUTED", None
    return "OK", max(0.0, min(1.0, val))


def get_sink_name() -> str:
    info = run_wpctl(["inspect", "@DEFAULT_AUDIO_SINK@"])
    # Prefer node.description, fallback node.name
    desc = None
    name = None
    for raw in info.splitlines():
        s = raw.strip()
        if s.startswith("node.description = "):
            desc = s.split("=", 1)[1].strip().strip('"')
            break
        if s.startswith("node.name = "):
            name = s.split("=", 1)[1].strip().strip('"')
    return desc or name or "Default Sink"


def ramp_bar(v: float, segs: int) -> str:
    """Left→right ramp where later cells can be taller (lo-fi mountains)."""
    v = max(0.0, min(1.0, v))
    segs = max(3, min(12, segs))
    glyphs = ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]  # 1..8
    prog = v * segs
    out = []
    for i in range(1, segs + 1):
        t = prog - (i - 1)
        if t < 0:
            t = 0.0
        if t > 1:
            t = 1.0
        g = i / segs
        idx = int(1 + 7 * t * g + 1e-9)
        idx = max(1, min(8, idx))
        out.append(glyphs[idx - 1])
    return "".join(out)


def main() -> None:
    segs = int(os.getenv("SEGS", "6") or "6")
    pct_pos = (os.getenv("PCT_POS", "end") or "end").lower()

    sink = get_sink_name()
    status, val = get_volume()

    # Error / no sink
    if status == "ERR":
        payload = {"text": "--", "class": "muted", "tooltip": sink}
        print(json.dumps(payload, ensure_ascii=False))
        return

    # Muted
    if status == "MUTED":
        ramp = ramp_bar(0.0, segs)
        payload = {"text": f" {ramp}", "class": "muted", "tooltip": f"{sink} (muted)"}
        print(json.dumps(payload, ensure_ascii=False))
        return

    # Normal
    v = float(val or 0.0)
    pct = int(round(v * 100))
    icon = ""
    if pct >= 66:
        icon = ""
    elif pct >= 33:
        icon = ""
    ramp = ramp_bar(v, segs)

    if pct_pos == "start":
        text = f"{icon} {pct:3d}% {ramp}"
    else:
        text = f"{icon} {ramp} {pct:3d}%"

    payload = {"text": text, "class": "normal", "tooltip": sink}
    print(json.dumps(payload, ensure_ascii=False))


if __name__ == "__main__":
    try:
        main()
    except Exception:
        # Never break Waybar; fall back gracefully
        print(
            json.dumps(
                {"text": "--", "class": "muted", "tooltip": "volbar error"},
                ensure_ascii=False,
            )
        )
        sys.exit(0)
