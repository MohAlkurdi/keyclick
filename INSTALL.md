# Installing KeyClick (for AI agents)

You are installing KeyClick, a menu bar app that plays mechanical keyboard sounds, on the user's Mac.
Run these steps in a terminal. The same steps update an existing install.

## 1. Check the Mac

```sh
sw_vers -productVersion
```

Stop if the version is below 13.0: KeyClick needs macOS 13 or later.

## 2. Download and install

```sh
pkill -x KeyClick || true
curl -fL -o /tmp/KeyClick.zip https://github.com/MohAlkurdi/keyclick/releases/latest/download/KeyClick.zip
rm -rf /Applications/KeyClick.app
ditto -x -k /tmp/KeyClick.zip /Applications
rm /tmp/KeyClick.zip
```

## 3. Allow it to open

KeyClick is open source but not notarized by Apple, so Gatekeeper blocks a downloaded copy.
Remove the download flag so it opens:

```sh
xattr -dr com.apple.quarantine /Applications/KeyClick.app
```

## 4. Clear any old permission and launch

Each release is a new build, and macOS ties the Input Monitoring permission to the exact build.
A permission left over from an older build shows as enabled but does nothing, so reset it first:

```sh
tccutil reset ListenEvent com.mohalkurdi.KeyClick
open /Applications/KeyClick.app
open "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent"
```

## 5. Hand over to the user

An agent cannot grant Input Monitoring. Tell the user:

> Turn on **KeyClick** in the Input Monitoring list that just opened. If it isn't listed, click **+** and choose Applications → KeyClick. Then type anything; if it stays silent, quit KeyClick from its menu bar icon and open it again.

Confirm the app is running with `pgrep -x KeyClick`. Its keyboard icon is in the menu bar, where the user can pick a switch, set the volume and turn on Open at login.

## Uninstall

```sh
pkill -x KeyClick || true
rm -rf /Applications/KeyClick.app
tccutil reset ListenEvent com.mohalkurdi.KeyClick
defaults delete com.mohalkurdi.KeyClick
```
