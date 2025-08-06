#!/bin/bash
# dev.sh - Complete development workflow with error handling

set -e  # Exit on any error
set -u  # Exit on undefined variables

echo "🚀 Starting development workflow..."

# Function to run script and handle errors
run_script() {
    local script="$1"
    local description="$2"
    
    echo
    echo "======================================"
    echo "Running: $description"
    echo "======================================"
    
    if [ -f "$script" ] && [ -x "$script" ]; then
        if ./"$script"; then
            echo "✅ $description completed successfully"
        else
            echo "❌ $description failed"
            exit 1
        fi
    else
        echo "❌ Script $script not found or not executable"
        echo "💡 Make sure to run: chmod +x *.sh"
        exit 1
    fi
}

# Run the development workflow
run_script "format.sh" "Code formatting"
run_script "test.sh" "Testing"
run_script "build.sh" "Building"

echo "🎉 Development workflow completed successfully!"
echo "✅ Your code is formatted, tested, and built!"
exit 0
