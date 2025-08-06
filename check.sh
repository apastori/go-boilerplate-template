#!/bin/bash
# check.sh - Check project health and dependencies

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🔍 Checking project health..."

# Check if Go is installed
if command -v go >/dev/null 2>&1; then
    GO_VERSION=$(go version)
    echo "✅ Go is installed: $GO_VERSION"
else
    echo "❌ Go is not installed"
    exit 1
fi

# Check if we're in a Go module
if [ -f "go.mod" ]; then
    echo "✅ Go module found"
    MODULE_NAME=$(go list -m)
    echo "   📦 Module: $MODULE_NAME"
else
    echo "❌ No go.mod found. Initialize with: go mod init your-module-name"
    exit 1
fi

# Check for security vulnerabilities
echo "🔒 Checking for security vulnerabilities..."
if go list -json -deps ./... | nancy sleuth 2>/dev/null; then
    echo "✅ No known vulnerabilities found"
elif command -v nancy >/dev/null 2>&1; then
    echo "⚠️  Security vulnerabilities detected"
else
    echo "💡 Install nancy for security scanning: go install github.com/sonatypeoss/nancy@latest"
fi

# Check module dependencies
echo "📋 Checking module dependencies..."
if go mod verify; then
    echo "✅ All dependencies verified"
else
    echo "❌ Dependency verification failed"
    exit 1
fi

# Check for outdated dependencies
echo "📅 Checking for module updates..."
if go list -u -m all | grep '\[' >/dev/null; then
    echo "⚠️  Some dependencies have updates available:"
    go list -u -m all | grep '\['
else
    echo "✅ All dependencies are up to date"
fi

echo "🎉 Project health check complete!"
exit 0
