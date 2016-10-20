all: build

build:
	swift build

build-release:
	swift build --configuration release

test:
	swift test

runtest:
	swift test --skip-build

docs:
	swift package generate-xcodeproj

clean:
	swift build --clean

.PHONY: build build-release test runtest docs clean
