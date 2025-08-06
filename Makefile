# === Configuration ===

APP_NAME := myapp
BIN_DIR := bin

.PHONY: format clean build test run help

# help command explains each of the following commands available
help:
	@echo "Available commands:"
	@echo "  make format  - Format Go code and tidy modules"
	@echo "  make clean   - Clean build cache and remove binaries"
	@echo "  make build   - Build the application"
	@echo "  make test    - Run tests"
	@echo "  make run     - Run the application"
	@echo "  make all     - Format, test, and build"

# Format Go code and tidy dependencies
format:
	@echo "Formatting Go code..."
	go fmt ./...
	go mod tidy
	@echo "Formatting complete!"

# Clean build artifacts and caches
clean:
	@echo "Cleaning..."
	go clean ./...
	go clean -testcache
	go clean -modcache
	rm -rf $(BIN_DIR)/ dist/
	@echo "Cleaning complete!"

# Build for current platform
build:
	@echo "Building for current platform..."
	mkdir -p $(BIN_DIR)
	go build -o $(BIN_DIR)/$(APP_NAME) .
	@echo "Build complete! Binary at $(BIN_DIR)/$(APP_NAME).exe"

# Build for all desktop platforms
build-all: build-windows build-linux build-mac
	@echo "All builds complete!"

# Build for Windows (64-bit and 32-bit)
build-windows:
	@echo "Building for Windows..."
	mkdir -p $(BIN_DIR)
	GOOS=windows GOARCH=amd64 go build -o $(BIN_DIR)/$(APP_NAME)-windows-amd64.exe ./
	GOOS=windows GOARCH=386 go build -o $(BIN_DIR)/$(APP_NAME)-windows-386.exe ./
	GOOS=windows GOARCH=arm64 go build -o $(BIN_DIR)/$(APP_NAME)-windows-arm64.exe ./

# Build for Linux (64-bit, 32-bit, ARM)
build-linux:
	@echo "Building for Linux..."
	mkdir -p $(BIN_DIR)
	GOOS=linux GOARCH=amd64 go build -o $(BIN_DIR)/$(APP_NAME)-linux-amd64 ./
	GOOS=linux GOARCH=386 go build -o $(BIN_DIR)/$(APP_NAME)-linux-386 ./
	GOOS=linux GOARCH=arm64 go build -o $(BIN_DIR)/$(APP_NAME)-linux-arm64 ./

# Build for macOS (Intel and Apple Silicon)
build-mac:
	@echo "Building for macOS..."
	mkdir -p $(BIN_DIR)
	GOOS=darwin GOARCH=amd64 go build -o $(BIN_DIR)/$(APP_NAME)-macos-intel ./
	GOOS=darwin GOARCH=arm64 go build -o $(BIN_DIR)/$(APP_NAME)-macos-m1 ./

# Build for specific platform (usage: make build-target GOOS=linux GOARCH=amd64)
build-target:
	@echo "Building for $(GOOS)/$(GOARCH)..."
	mkdir -p $(BIN_DIR)
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(BIN_DIR)/$(APP_NAME)-$(GOOS)-$(GOARCH)$(if $(filter windows,$(GOOS)),.exe,) ./

# Run tests
test:
	@echo "Running tests..."
	go test ./...

# Run the application
run:
	@echo "Running application..."
	go run ./

# Format, test, and build
all: format test build

# Install dependencies
deps:
	@echo "Installing dependencies..."
	go mod download
	go mod verify
