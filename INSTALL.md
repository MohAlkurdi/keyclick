# Installing KeyClick (for AI agents)

You are installing KeyClick, a menu bar app that plays mechanical keyboard sounds, on the user's Mac.
Run these steps in a terminal. The same steps update an existing install.

## 1. Check the Mac

```sh
sw_vers -productVersion
```

Stop if the version is below 13.0: KeyClick needs macOS 13 or later.

## 2. Note the installed build

A KeyClick installed before 0.2.0 was signed differently, and its Input Monitoring permission will not carry over.
Check before replacing it:

```sh
codesign -dv /Applications/KeyClick.app 2>&1 | grep -q "Signature=adhoc" && echo "old build" || echo "none or current"
```

## 3. Install

With Homebrew (if `command -v brew` finds it):

```sh
pkill -x KeyClick || true
brew install --cask --force mohalkurdi/tap/keyclick   # --force replaces a copy installed by hand
```

Without Homebrew:

```sh
pkill -x KeyClick || true
curl -fL -o /tmp/KeyClick.zip https://github.com/MohAlkurdi/keyclick/releases/latest/download/KeyClick.zip
rm -rf /Applications/KeyClick.app
ditto -x -k /tmp/KeyClick.zip /Applications
rm /tmp/KeyClick.zip
# KeyClick is open source but not notarized by Apple; clear the download flag so Gatekeeper lets it open.
xattr -dr com.apple.quarantine /Applications/KeyClick.app
```

## 4. Launch

If step 2 printed "old build", first clear the permission the old build left behind. It would show as enabled but do
nothing. Do not reset it otherwise: current builds keep the permission across updates.

```sh
tccutil reset ListenEvent com.mohalkurdi.KeyClick   # only after "old build"
```

```sh
open /Applications/KeyClick.app
open "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent"
```

## 5. Hand over to the user

An agent cannot grant Input Monitoring. Tell the user:

> Turn on **KeyClick** in the Input Monitoring list that just opened. If it isn't listed, click **+** and choose Applications → KeyClick. Then type anything; if it stays silent, quit KeyClick from its menu bar icon and open it again.

Confirm the app is running with `pgrep -x KeyClick`. Its keyboard icon is in the menu bar, where the user can pick a switch, set the volume and turn on Open at login. ⌃⌥K turns the sound on and off. KeyClick updates itself from then on.

## Uninstall

With Homebrew: `brew uninstall --cask --zap keyclick`. Otherwise:

```sh
pkill -x KeyClick || true
rm -rf /Applications/KeyClick.app
tccutil reset ListenEvent com.mohalkurdi.KeyClick
defaults delete com.mohalkurdi.KeyClick
```
