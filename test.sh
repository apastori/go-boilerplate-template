#!/bin/bash
# test.sh - Run tests with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🧪 Running tests..."

# Check if go.mod exists
if [ ! -f "go.mod" ]; then
    echo "❌ Error: go.mod not found. Are you in a Go project directory?"
    exit 1
fi

# Check if there are any test files
if ! find . -name "*_test.go" -type f | grep -q .; then
    echo "⚠️  No test files found"
    exit 0
fi

# Run tests with verbose output and coverage
echo "Running tests with coverage..."
if go test -v -race -coverprofile=coverage.out ./...; then
    echo "✅ All tests passed!"
    
    # Show coverage if coverage file exists
    if [ -f "coverage.out" ]; then
        echo "📊 Test coverage:"
        go tool cover -func=coverage.out | tail -1
    fi
else
    echo "❌ Tests failed"
    exit 1
fi

echo "🎉 Testing complete!"
exit 0
