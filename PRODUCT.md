# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Stack

Astro (user's choice), static output deployed to GitHub Pages. The site lives in `site/` inside the app repo.

## Users

People typing on a MacBook or other flat keyboard who miss, or never had, the feel of a mechanical keyboard: writers, programmers, students. They are not switch collectors; switch names (Holy Panda, Topre) are detail, not the hook.

## Product Purpose

KeyClick is a macOS menu bar app that plays a real mechanical switch recording on every key press and release, so a quiet laptop keyboard sounds and feels like a mechanical one. Success: a visitor downloads it, grants Input Monitoring, and keeps it on while typing.

## Positioning

Free and open source (MIT), native Swift with no dependencies, around 200 lines anyone can read. Listen-only: it never reads which character was typed, stores nothing, and has no network code. Competing apps are paid (Klack) or built on Electron (Mechvibes).

## Operating Context

Runs in the menu bar with no Dock icon or window. The first launch asks for Input Monitoring in System Settings → Privacy & Security. The build is not notarized yet, so the first launch needs right-click → Open. Requires macOS 13 or later, on Apple silicon or Intel.

## Capabilities and Constraints

- Every key has its own recording, for press and for release; key auto-repeat is silent.
- 5 switches: MX Brown (tactile), MX Black (linear), MX Red (linear), MX Blue (clicky), Topre.
- On/off, volume, switch picker, open at login.
- Distribution: GitHub Releases zip. No App Store, no Homebrew yet.
- Money: free download with an optional tip. Tip destination not decided yet.

## Brand Commitments

Name: KeyClick, chosen to be understood by non-native English speakers. Copy should stay plain and easy for them too.

## Evidence on Hand

- The app itself and its source (`Sources/KeyClick/`), the switch recordings in `Sounds/` (MIT, Mechvibes by Hai Nguyen).
- No users, testimonials, download counts, press or reviews exist. Do not invent any.
- No app icon or screenshots exist yet.

## Product Principles

1. The sound is the product: let people hear it before they install anything.
2. Trust is earned by openness: say exactly what the app can and cannot see, and link the code.
3. Plain words over clever ones; the audience includes non-native English readers.
4. Small and native over feature-rich.
