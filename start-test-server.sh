#!/bin/bash

# Simple script to start a test HTTP server for widget testing

echo "🚀 Starting Widget Test Server..."
echo ""
echo "This will start a simple HTTP server to test the widget embed."
echo "Make sure your Remo AI backend and frontend are running first!"
echo ""
echo "Backend should be on: http://localhost:8000"
echo "Frontend should be on: http://localhost:5173"
echo ""

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    echo "Starting Python 3 HTTP server on port 8080..."
    echo "Open http://localhost:8080/company-website.html in your browser"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    cd "$(dirname "$0")"
    python3 -m http.server 8080
elif command -v python &> /dev/null; then
    echo "Starting Python HTTP server on port 8080..."
    echo "Open http://localhost:8080/company-website.html in your browser"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    cd "$(dirname "$0")"
    python -m SimpleHTTPServer 8080
else
    echo "❌ Python not found. Please install Python or use another method:"
    echo ""
    echo "Option 1: Install Python"
    echo "Option 2: Use Node.js: npm install -g http-server && http-server -p 8080"
    echo "Option 3: Use PHP: php -S localhost:8080"
    exit 1
fi








