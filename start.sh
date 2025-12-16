#!/bin/bash

# Social Media Automation - Quick Start Script
# This script helps you set up the n8n social media automation quickly

set -e

echo "================================================"
echo "  Social Media Automation Setup"
echo "  Daily Content Creator with n8n"
echo "================================================"
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed${NC}"
    echo "Please install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

echo -e "${GREEN}✅ Docker found${NC}"

# Check if Docker Compose is available (try both old and new syntax)
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo -e "${RED}❌ Docker Compose is not available${NC}"
    echo "Please install Docker Compose from: https://docs.docker.com/compose/install/"
    exit 1
fi

echo -e "${GREEN}✅ Docker Compose found${NC}"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Creating from .env.example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✅ Created .env file${NC}"
    echo -e "${YELLOW}⚠️  IMPORTANT: Edit .env file with your API credentials before continuing${NC}"
    echo ""
    read -p "Press Enter when you've configured your .env file..."
else
    echo -e "${GREEN}✅ .env file exists${NC}"
fi

echo ""
echo "Starting n8n with Docker Compose..."
echo ""

# Start Docker Compose
$DOCKER_COMPOSE up -d

echo ""
echo -e "${GREEN}✅ n8n is starting up!${NC}"
echo ""
echo "================================================"
echo "  Next Steps:"
echo "================================================"
echo ""
echo "1. Wait 30 seconds for n8n to fully start"
echo "2. Open your browser to: http://localhost:5678"
echo "3. Complete the initial n8n setup"
echo "4. Import the workflow:"
echo "   - Click 'Import from File'"
echo "   - Select: social-media-automation-workflow.json"
echo "5. Configure credentials for each service"
echo "6. Activate the workflow (toggle in top-right)"
echo ""
echo "================================================"
echo ""
echo "📚 Documentation:"
echo "   - Setup Guide: SETUP_GUIDE.md"
echo "   - Content Templates: CONTENT_TEMPLATES.md"
echo ""
echo "🔍 Check status: docker-compose ps (or 'docker compose ps')"
echo "📋 View logs: docker-compose logs -f n8n (or 'docker compose logs -f n8n')"
echo "🛑 Stop services: docker-compose down (or 'docker compose down')"
echo ""
echo "================================================"
echo ""

# Wait and check if n8n is running
echo "Checking n8n status..."
sleep 5

if $DOCKER_COMPOSE ps | grep -q "n8n.*Up"; then
    echo -e "${GREEN}✅ n8n is running successfully!${NC}"
    echo ""
    echo "Opening n8n in your browser in 10 seconds..."
    echo "(Press Ctrl+C to cancel)"
    sleep 10
    
    # Try to open browser (works on most systems)
    if command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:5678
    elif command -v open &> /dev/null; then
        open http://localhost:5678
    else
        echo "Please open http://localhost:5678 in your browser"
    fi
else
    echo -e "${YELLOW}⚠️  n8n may still be starting up${NC}"
    echo "Run '$DOCKER_COMPOSE logs -f n8n' to check status"
fi

echo ""
echo "Setup complete! 🎉"
