#!/bin/bash  
# clean.sh - Clean build artifacts and caches with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🧹 Cleaning project..."

# Function to run command and handle errors
run_command() {
    local cmd="$1"
    local description="$2"
    
    if eval "$cmd"; then
        echo "✅ $description successful"
    else
        echo "⚠️  $description failed (continuing...)"
    fi
}

# Clean Go cache and test cache
run_command "go clean ./..." "Go clean"
run_command "go clean -testcache" "Test cache clean"
run_command "go clean -modcache" "Module cache clean"

# Remove build directories
if [ -d "bin" ]; then
    if rm -rf bin/; then
        echo "✅ Removed bin/ directory"
    else
        echo "❌ Failed to remove bin/ directory"
        exit 1
    fi
fi

if [ -d "dist" ]; then
    if rm -rf dist/; then
        echo "✅ Removed dist/ directory"
    else
        echo "❌ Failed to remove dist/ directory"
        exit 1
    fi
fi

echo "🎉 Cleaning complete!"
exit 0
