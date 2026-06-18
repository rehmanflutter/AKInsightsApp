#!/bin/bash

# AK Insights App - Complete Starter Script
# This script starts both backend and frontend

echo "🚀 Starting AK Insights App..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "${YELLOW}⚠️  Node.js is not installed!${NC}"
    echo "Please install Node.js from: https://nodejs.org/"
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "${YELLOW}⚠️  Flutter is not installed!${NC}"
    echo "Please install Flutter from: https://flutter.dev/"
    exit 1
fi

# Check if backend dependencies are installed
if [ ! -d "backend/node_modules" ]; then
    echo "${YELLOW}📦 Installing backend dependencies...${NC}"
    cd backend
    npm install
    cd ..
fi

echo "${GREEN}✅ All dependencies ready!${NC}"
echo ""
echo "Starting services..."
echo ""

# Start backend server in background
echo "🔧 Starting backend server on port 3000..."
cd backend
npm start &
BACKEND_PID=$!
cd ..

# Wait a bit for backend to start
sleep 3

# Check if backend is running
if curl -s http://localhost:3000/health > /dev/null; then
    echo "${GREEN}✅ Backend server is running!${NC}"
else
    echo "${YELLOW}⚠️  Backend server might not be running properly${NC}"
fi

echo ""
echo "🎨 Starting Flutter app on Chrome..."
flutter run -d chrome --web-port=8080 &
FLUTTER_PID=$!

echo ""
echo "${GREEN}================================================${NC}"
echo "${GREEN}✅ AK Insights App is Running!${NC}"
echo "${GREEN}================================================${NC}"
echo ""
echo "📍 Flutter App: http://localhost:8080"
echo "📍 Backend API: http://localhost:3000"
echo "📍 Health Check: http://localhost:3000/health"
echo ""
echo "Press Ctrl+C to stop all services"
echo ""

# Wait for user interrupt
wait $BACKEND_PID $FLUTTER_PID
