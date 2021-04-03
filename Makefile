format:
	@swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./Package.swift \
		./Sources/ \
		./Tests/ 

xcode:
	@bundle exec fastlane xcode

build:
	@swift build

test:
	@swift test --enable-test-discovery

.PHONY: format build test