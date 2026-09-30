APP := build/KeyClick.app
# A stable identity keeps the Input Monitoring grant across updates; "-" (ad-hoc) loses it on every build.
SIGN_ID ?= -
VERSION ?= $(shell /usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" Info.plist)
BUILD := swift build -c release --arch arm64 --arch x86_64

.PHONY: app run zip clean

app:
	$(BUILD)
	rm -rf $(APP) && mkdir -p $(APP)/Contents/MacOS $(APP)/Contents/Resources $(APP)/Contents/Frameworks
	cp "$$($(BUILD) --show-bin-path)/KeyClick" $(APP)/Contents/MacOS/
	ditto "$$($(BUILD) --show-bin-path)/Sparkle.framework" $(APP)/Contents/Frameworks/Sparkle.framework
	# Sparkle's XPC services are only for sandboxed apps.
	rm -rf $(APP)/Contents/Frameworks/Sparkle.framework/XPCServices $(APP)/Contents/Frameworks/Sparkle.framework/Versions/B/XPCServices
	cp Info.plist $(APP)/Contents/
	plutil -replace CFBundleShortVersionString -string $(VERSION) $(APP)/Contents/Info.plist
	plutil -replace CFBundleVersion -string $(VERSION) $(APP)/Contents/Info.plist
	cp -R AppIcon.icns Sounds THIRD_PARTY_NOTICES.md $(APP)/Contents/Resources/
	codesign --force --deep --sign "$(SIGN_ID)" $(APP)

run: app
	open $(APP)

zip: app
	ditto -c -k --keepParent $(APP) build/KeyClick.zip

clean:
	rm -rf .build build
