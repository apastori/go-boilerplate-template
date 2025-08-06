#!/bin/bash
# build.sh - Build the application with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🔨 Building application..."

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo "❌ Error: go.mod not found. Are you in a Go project directory?"
    exit 1
fi

# Create bin directory if it doesn't exist
mkdir -p bin

# Get the module name for better binary naming
MODULE_NAME=$(go list -m)
BINARY_NAME=$(basename "$MODULE_NAME")

# Build the application
echo "Building ${BINARY_NAME}..."
if go build -o "bin/${BINARY_NAME}.exe" ./; then
    echo "✅ Build successful! Binary at bin/${BINARY_NAME}.exe"
    
    # Show binary info
    if [ -f "bin/${BINARY_NAME}.exe" ]; then
        SIZE=$(stat -f%z "bin/${BINARY_NAME}.exe" 2>/dev/null || stat -c%s "bin/${BINARY_NAME}.exe" 2>/dev/null || echo "unknown")
        echo "📦 Binary size: ${SIZE} bytes"
    fi
else
    echo "❌ Build failed"
    exit 1
fi

echo "🎉 Build complete!"
exit 0
