setuptools:
	@bundle install

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
	@bundle exec fastlane build

test:
	@bundle exec fastlane test

.PHONY: setuptools format xcode build test