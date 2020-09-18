fmt:
	@swiftformat --config .swiftformat ./

build:
	@swift build

test:
	@swift test --enable-test-discovery

.PHONY: fmt build test