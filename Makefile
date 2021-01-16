setuptools:
	@brew bundle
	@bundle install

fmt:
	@swiftformat Sources/ Tests/

xcode:
	@bundle exec fastlane xcode

build:
	@bundle exec fastlane build

test:
	@bundle exec fastlane test

.PHONY: setuptools fmt xcode build test