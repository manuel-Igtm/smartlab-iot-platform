#!/bin/bash

# SmartLab IoT Platform - GitHub Setup Script
# This script helps you create the GitHub repository and push the initial commit

echo "🚀 SmartLab IoT Platform - GitHub Setup"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Please run this script from the smartlab-iot-platform directory"
    exit 1
fi

echo "📋 Next Steps:"
echo ""
echo "1. Go to https://github.com/new"
echo "2. Repository name: smartlab-iot-platform"
echo "3. Description: Production-grade IoT platform for laboratory monitoring. Django REST API + Embedded Systems + DevOps. Part of CTO Development Journey 2025."
echo "4. Set as: Public ✅"
echo "5. Do NOT initialize with README, .gitignore, or license (we already have them)"
echo "6. Click 'Create repository'"
echo ""
echo "7. After creating, run these commands:"
echo ""
echo "   git remote add origin https://github.com/manuel-Igtm/smartlab-iot-platform.git"
echo "   git push -u origin main"
echo ""
echo "8. Then add the repository to your GitHub Project:"
echo "   - Go to: https://github.com/users/manuel-Igtm/projects/1"
echo "   - Click '+' to add items"
echo "   - Link the smartlab-iot-platform repository"
echo ""

read -p "Press Enter to continue to GitHub..."
xdg-open "https://github.com/new" 2>/dev/null || open "https://github.com/new" 2>/dev/null || echo "Please open https://github.com/new in your browser"
