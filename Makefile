format:
	@swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./Package.swift \
		./Sources/ \
		./Tests/ 

build:
	@swift build

test:
	@swift test --enable-test-discovery

.PHONY: format build test