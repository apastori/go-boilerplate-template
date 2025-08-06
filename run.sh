#!/bin/bash
# run.sh - Run the application with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🚀 Running application..."

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo "❌ Error: go.mod not found. Are you in a Go project directory?"
    exit 1
fi

# Check if main.go exists
if [ ! -f "main.go" ] && [ ! -d "cmd" ]; then
    echo "❌ Error: No main.go found in root or cmd/ directory"
    exit 1
fi

echo "Starting application..."
if go run ./; then
    echo "✅ Application finished successfully"
else
    echo "❌ Application failed"
    exit 1
fi
exit 0
