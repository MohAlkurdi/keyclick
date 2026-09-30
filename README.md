# KeyClick

Mechanical keyboard sounds for your Mac. KeyClick lives in the menu bar and plays a real switch recording every time you press and release a key.

- 12 switch sounds: Cream, Holy Panda, MX Blue, MX Brown, Topre and more
- Different sounds for space, enter and backspace, and for press and release
- Volume, on/off, open at login
- Native Swift, no dependencies, ~200 lines

## Install

Download `KeyClick.zip` from [Releases](../../releases), unzip, and move `KeyClick.app` to Applications.
The first time, right-click the app and choose **Open** (it is not notarized yet).

macOS will ask for **Input Monitoring** permission. Allow it in
System Settings → Privacy & Security → Input Monitoring.

## Privacy

KeyClick uses a listen-only event tap: it can see *that* a key was pressed, never change or block it.
It only looks at which key group was hit (space, enter, backspace, other) to pick a sound.
It does not store, log or send anything, and it has no network code. macOS hides keystrokes in password fields from it.
Read [`Sources/KeyClick/Clicker.swift`](Sources/KeyClick/Clicker.swift) to check.

## Build

Requires Xcode 16 or newer.

```sh
make run                                           # build build/KeyClick.app and open it
make run SIGN_ID="Apple Development: you@example"  # keeps the permission across rebuilds
make zip                                           # build/KeyClick.zip for a release
```

With the default ad-hoc signature, macOS treats every rebuild as a new app: remove KeyClick from
Input Monitoring and allow it again after rebuilding.

## Sound packs

Each folder in `Sounds/` is one switch:

```
Sounds/<Switch name>/press/default/*.wav      # one is picked at random per key
Sounds/<Switch name>/press/{space,enter,backspace}/*.wav
Sounds/<Switch name>/release/...              # same layout for key release
```

Missing groups fall back to `default`. Files must be 48 kHz mono WAV.

## Credits

Switch recordings by Thomas Lai from [kbsim](https://github.com/tplai/kbsim) (MIT), converted by
[KeyTone](https://github.com/rushabhcodes/KeyTone). See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## License

MIT
