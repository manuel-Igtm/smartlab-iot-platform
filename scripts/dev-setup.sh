#!/bin/bash
# SmartLab IoT Platform - Development Setup Script

set -e

echo "🚀 SmartLab IoT Platform - Development Setup"
echo "============================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env with your configuration before continuing"
    echo "Press Enter when ready..."
    read
fi

# Build and start services
echo ""
echo "🐳 Building Docker images..."
docker-compose build

echo ""
echo "🚀 Starting services..."
docker-compose up -d

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check service health
echo ""
echo "🔍 Checking service health..."
docker-compose ps

# Run migrations
echo ""
echo "📦 Running database migrations..."
docker-compose exec api python manage.py migrate

# Create superuser (optional)
echo ""
read -p "Create Django superuser? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose exec api python manage.py createsuperuser
fi

# Display status
echo ""
echo "✅ Setup complete!"
echo ""
echo "🌐 Services running:"
echo "  - API:          http://localhost:8000"
echo "  - Health:       http://localhost:8000/api/health/"
echo "  - API Docs:     http://localhost:8000/api/docs/"
echo "  - Admin:        http://localhost:8000/admin/"
echo "  - PostgreSQL:   localhost:5432"
echo "  - Redis:        localhost:6379"
echo "  - MQTT:         localhost:1883"
echo "  - MQTT WS:      localhost:9001"
echo ""
echo "📝 Useful commands:"
echo "  docker-compose logs -f api       # View API logs"
echo "  docker-compose exec api python manage.py shell  # Django shell"
echo "  docker-compose down              # Stop all services"
echo "  docker-compose down -v           # Stop and remove volumes"
