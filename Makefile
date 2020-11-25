setuptools:
	@brew bundle

fmt:
	@swiftformat --config .swiftformat ./

xcode:
	@swift package generate-xcodeproj

build: xcode
	@xcodebuild build -sdk iphoneos -scheme "Pancake-Package"

test: xcode
	@xcodebuild test -destination 'name=iPhone 8' -scheme 'Pancake-Package'

.PHONY: setuptools fmt xcode build test