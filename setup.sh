#!/bin/bash

# TranslatorJHU Development Setup Script

echo "🚀 Setting up TranslatorJHU Development Environment"
echo "=================================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18+ is required. Current version: $(node -v)"
    exit 1
fi

echo "✅ Node.js $(node -v) detected"

# Setup Backend
echo ""
echo "📦 Setting up Backend..."
cd TranslatorJHU-Backend

if [ ! -f package.json ]; then
    echo "❌ Backend package.json not found"
    exit 1
fi

echo "Installing backend dependencies..."
npm install

if [ ! -f .env ]; then
    echo "Creating .env file from template..."
    cp env.example .env
    echo "⚠️  Please edit .env file with your API keys before running the server"
fi

echo "✅ Backend setup complete"

# Setup Frontend
echo ""
echo "🎨 Setting up Frontend..."
cd ../TranslatorJHU-Frontend

if [ ! -f package.json ]; then
    echo "❌ Frontend package.json not found"
    exit 1
fi

echo "Installing frontend dependencies..."
npm install

echo "✅ Frontend setup complete"

# Return to root directory
cd ..

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Next steps:"
echo "1. Edit TranslatorJHU-Backend/.env with your API keys:"
echo "   - GEMINI_API_KEY (required)"
echo "   - GOOGLE_CLOUD_PROJECT_ID (required)"
echo "   - GOOGLE_APPLICATION_CREDENTIALS (required)"
echo "   - ELEVENLABS_API_KEY (recommended for TTS)"
echo ""
echo "2. Start the backend server:"
echo "   cd TranslatorJHU-Backend && npm run dev"
echo ""
echo "3. Build the Chrome extension:"
echo "   cd TranslatorJHU-Frontend && npm run build:extension"
echo ""
echo "4. Load the extension in Chrome:"
echo "   - Open chrome://extensions/"
echo "   - Enable Developer mode"
echo "   - Click 'Load unpacked' and select TranslatorJHU-Frontend/dist/"
echo ""
echo "📚 For more information, see the README files in each directory."
