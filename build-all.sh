#!/bin/bash
# build-all.sh - Build for all desktop platforms with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🏗️  Building for all platforms..."

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo "❌ Error: go.mod not found. Are you in a Go project directory?"
    exit 1
fi

# Create bin directory
mkdir -p bin

# Get module name for binary naming
MODULE_NAME=$(go list -m)
BINARY_NAME=$(basename "$MODULE_NAME")

# Function to build for specific platform
build_platform() {
    local goos=$1
    local goarch=$2
    local extension=""
    
    # Add .exe extension for Windows
    if [ "$goos" = "windows" ]; then
        extension=".exe"
    fi
    
    local output="bin/${BINARY_NAME}-${goos}-${goarch}${extension}"
    
    echo "Building for ${goos}/${goarch}..."
    if GOOS=$goos GOARCH=$goarch go build -o "$output" ./; then
        echo "✅ ${goos}/${goarch} build successful"
        
        # Show file size
        if [ -f "$output" ]; then
            SIZE=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output" 2>/dev/null || echo "unknown")
            echo "   📦 Size: ${SIZE} bytes"
        fi
    else
        echo "❌ ${goos}/${goarch} build failed"
        return 1
    fi
}

# Track build results
SUCCESSFUL_BUILDS=0
FAILED_BUILDS=0

# Build for each platform
PLATFORMS=(
    "windows amd64"
    "windows 386"
    "windows arm64"
    "linux amd64"
    "linux 386"
    "linux arm64"
    "darwin amd64"
    "darwin arm64"
)

for platform in "${PLATFORMS[@]}"; do
    read -r goos goarch <<< "$platform"
    if build_platform "$goos" "$goarch"; then
        ((SUCCESSFUL_BUILDS++))
    else
        ((FAILED_BUILDS++))
        echo "⚠️  Continuing with remaining builds..."
    fi
done

echo
echo "🎉 Build summary:"
echo "✅ Successful builds: $SUCCESSFUL_BUILDS"
echo "❌ Failed builds: $FAILED_BUILDS"

if [ $FAILED_BUILDS -gt 0 ]; then
    echo "⚠️  Some builds failed. Check the output above for details."
    exit 1
fi

echo "🎉 All builds completed successfully!"
exit 0
