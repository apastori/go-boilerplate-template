#!/bin/bash
# format.sh - Format Go code and tidy modules with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🔧 Formatting Go code..."

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo "❌ Error: go.mod not found. Are you in a Go project directory?"
    exit 1
fi

# Format Go code
if go fmt ./...; then
    echo "✅ Go formatting successful"
else
    echo "❌ Go formatting failed"
    exit 1
fi

# Tidy modules
if go mod tidy; then
    echo "✅ Module tidying successful"
else
    echo "❌ Module tidying failed"
    exit 1
fi

echo "🎉 Formatting complete!"
exit 0
