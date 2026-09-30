# KeyClick

Mechanical keyboard sounds for your Mac. KeyClick lives in the menu bar and plays a real switch recording every time you press and release a key.

**[Try it in your browser](https://mohalkurdi.github.io/keyclick/)**

- 5 switches: MX Brown, MX Black, MX Red, MX Blue, Topre
- Every key has its own recording, for press and for release
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

Each folder in `Sounds/` is one switch, with one file per key named by its
[`KeyboardEvent.code`](https://developer.mozilla.org/en-US/docs/Web/API/UI_Events/Keyboard_event_code_values):

```
Sounds/<Switch name>/press/KeyA.wav
Sounds/<Switch name>/release/KeyA.wav
```

A key with no file borrows a random letter. Files must be 48 kHz stereo WAV.
`tools/slice_mechvibes.py` builds a pack from a Mechvibes sprite pack.

## Credits

Switch recordings from [Mechvibes](https://github.com/hainguyents13/mechvibes) by Hai Nguyen (MIT).
See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## Website

The landing page lives in `site/` (Astro). `cd site && npm install && npm run dev`.

## License

MIT
