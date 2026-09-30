APP := build/KeyClick.app
# Any stable identity (e.g. "Apple Development: …") keeps the Input Monitoring grant across rebuilds; "-" is ad-hoc.
SIGN_ID ?= -
BUILD := swift build -c release --arch arm64 --arch x86_64

.PHONY: app run zip clean

app:
	$(BUILD)
	rm -rf $(APP) && mkdir -p $(APP)/Contents/MacOS $(APP)/Contents/Resources
	cp "$$($(BUILD) --show-bin-path)/KeyClick" $(APP)/Contents/MacOS/
	cp Info.plist $(APP)/Contents/
	cp -R Sounds THIRD_PARTY_NOTICES.md $(APP)/Contents/Resources/
	codesign --force --sign "$(SIGN_ID)" $(APP)

run: app
	open $(APP)

zip: app
	ditto -c -k --keepParent $(APP) build/KeyClick.zip

clean:
	rm -rf .build build
