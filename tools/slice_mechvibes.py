#!/usr/bin/env python3
"""Cut a Mechvibes sprite pack into per-key press and release WAVs.

usage: slice_mechvibes.py <sprite.ogg> <config.dx-v2.json> <out dir>

Each key in the sprite is one whole keystroke. We find the press onset, then the
release transient (the loudest hit 50 ms or more after the bottom-out), and cut between them.
Output: <out>/press/<KeyboardEvent.code>.wav and <out>/release/<code>.wav, 48 kHz stereo.
Needs ffmpeg on PATH.
"""
import json
import subprocess
import sys
import wave
from array import array
from pathlib import Path

RATE = 48_000
MS = RATE // 1000
SKIP = ("Numpad", "NumLock", "ScrollLock", "Pause", "PrintScreen", "Insert")
# Keys a Mac has that the recordings lack: borrow the nearest recorded neighbour.
ALIASES = {"MetaLeft": "AltLeft", "MetaRight": "AltLeft", "AltRight": "AltLeft", "ControlRight": "ControlLeft"}


def decode(path):
    raw = subprocess.run(
        ["ffmpeg", "-v", "error", "-i", str(path), "-ac", "2", "-ar", str(RATE), "-f", "s16le", "-"],
        check=True, capture_output=True,
    ).stdout
    return array("h", raw)


def envelope(pcm, start, end):
    """Peak level per millisecond, both channels."""
    return [max(abs(s) for s in pcm[2 * i : 2 * (i + MS)]) for i in range(start, end, MS)]


def split(pcm, start_ms, end_ms):
    start, end = start_ms * MS, min(end_ms * MS, len(pcm) // 2)
    env = envelope(pcm, start, end)
    top = max(env)
    onset = next(i for i, v in enumerate(env) if v > 0.08 * top)
    # A press can hit twice (switch contact, then bottom-out up to ~40 ms later); skip past both.
    bottom_out = max(range(onset, min(onset + 60, len(env))), key=env.__getitem__)
    search = bottom_out + 50
    if search >= len(env) - 5:
        return (start + max(onset - 1, 0) * MS, end), None
    peak = max(range(search, len(env)), key=env.__getitem__)
    if env[peak] < 0.04 * top:
        return (start + max(onset - 1, 0) * MS, end), None
    cut = peak
    while cut > search and env[cut - 1] < env[cut] and env[cut - 1] > 0.15 * env[peak]:
        cut -= 1
    cut -= 2
    return (start + max(onset - 1, 0) * MS, start + cut * MS), (start + cut * MS, end)


def frames(pcm, span, gain, fade_in_ms, fade_out_ms):
    a, b = span
    out = array("h", pcm[2 * a : 2 * b])
    n = len(out) // 2
    fi, fo = fade_in_ms * MS, fade_out_ms * MS
    for i in range(n):
        g = gain * min(1.0, (i + 1) / fi if fi else 1.0, (n - i) / fo if fo else 1.0)
        for c in (0, 1):
            out[2 * i + c] = max(-32767, min(32767, int(out[2 * i + c] * g)))
    return out


def write(path, pcm):
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "wb") as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(RATE)
        w.writeframes(pcm.tobytes())


def main(sprite, config, out):
    pcm = decode(sprite)
    defs = json.loads(Path(config).read_text())["definitions"]
    keys = {k: v["timing"] for k, v in defs.items() if not k.startswith(SKIP)}
    cuts = {k: split(pcm, int(t[0][0]), int(t[1][1])) for k, t in keys.items()}

    press_peaks = sorted(max(abs(s) for s in pcm[2 * p[0] : 2 * p[1]]) for p, _ in cuts.values())
    gain = 0.5 * 32767 / press_peaks[len(press_peaks) // 2]

    out = Path(out)
    for key, (press, release) in cuts.items():
        for name in [key] + [a for a, src in ALIASES.items() if src == key]:
            write(out / "press" / f"{name}.wav", frames(pcm, press, gain, 0, 4))
            if release:
                write(out / "release" / f"{name}.wav", frames(pcm, release, gain, 1, 8))

    missing = [k for k, (_, r) in cuts.items() if r is None]
    lengths = sorted((p[1] - p[0]) // MS for p, _ in cuts.values())
    print(f"{out.name}: {len(cuts)} keys, gain {gain:.2f}, press {lengths[0]}-{lengths[-1]} ms, no release: {missing or 'none'}")


if __name__ == "__main__":
    main(*sys.argv[1:4])
