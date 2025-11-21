# 🐳 Docker Setup Guide

Complete Docker environment for SmartLab IoT Platform with PostgreSQL, Redis, and MQTT.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Docker Network                        │
│                                                           │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │
│  │   API    │  │ Postgres │  │  Redis   │  │  MQTT   │ │
│  │  Django  │  │    DB    │  │  Cache   │  │ Mosquit │ │
│  │  :8000   │  │  :5432   │  │  :6379   │  │ :1883   │ │
│  └──────────┘  └──────────┘  └──────────┘  └─────────┘ │
└─────────────────────────────────────────────────────────┘
```

## 📦 Services

| Service | Image | Port | Purpose |
|---------|-------|------|---------|
| **api** | Custom (Python 3.11) | 8000 | Django REST API |
| **postgres** | postgres:16-alpine | 5432 | Primary database |
| **redis** | redis:7-alpine | 6379 | Cache & sessions |
| **mqtt** | eclipse-mosquitto:2 | 1883, 9001 | MQTT broker |

## 🚀 Quick Start

### 1. Initial Setup

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your settings
nano .env

# Run automated setup
./scripts/dev-setup.sh
```

### 2. Manual Setup

```bash
# Build images
docker-compose build

# Start all services
docker-compose up -d

# Check status
docker-compose ps

# Run migrations
docker-compose exec api python manage.py migrate

# Create superuser
docker-compose exec api python manage.py createsuperuser

# View logs
docker-compose logs -f api
```

## 🔌 Access Points

Once running:

- **API**: http://localhost:8000
- **Health Check**: http://localhost:8000/api/health/
- **API Documentation**: http://localhost:8000/api/docs/
- **Django Admin**: http://localhost:8000/admin/
- **PostgreSQL**: `localhost:5432`
- **Redis**: `localhost:6379`
- **MQTT**: `localhost:1883` (TCP)
- **MQTT WebSocket**: `localhost:9001`

## 🛠️ Common Commands

### Service Management

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Restart specific service
docker-compose restart api

# View logs
docker-compose logs -f api
docker-compose logs -f postgres
docker-compose logs -f mqtt

# Check service health
docker-compose ps
```

### Django Management

```bash
# Run migrations
docker-compose exec api python manage.py migrate

# Create migrations
docker-compose exec api python manage.py makemigrations

# Django shell
docker-compose exec api python manage.py shell

# Create superuser
docker-compose exec api python manage.py createsuperuser

# Collect static files
docker-compose exec api python manage.py collectstatic --no-input
```

### Database Operations

```bash
# Access PostgreSQL shell
docker-compose exec postgres psql -U postgres -d smartlab_dev

# Backup database
docker-compose exec postgres pg_dump -U postgres smartlab_dev > backup.sql

# Restore database
cat backup.sql | docker-compose exec -T postgres psql -U postgres smartlab_dev

# View database logs
docker-compose logs -f postgres
```

### Redis Operations

```bash
# Access Redis CLI
docker-compose exec redis redis-cli

# Check Redis keys
docker-compose exec redis redis-cli KEYS '*'

# Monitor Redis
docker-compose exec redis redis-cli MONITOR

# Clear cache
docker-compose exec redis redis-cli FLUSHDB
```

### MQTT Operations

```bash
# Subscribe to all topics
docker-compose exec mqtt mosquitto_sub -t '#' -v

# Publish test message
docker-compose exec mqtt mosquitto_pub -t 'test/topic' -m 'Hello MQTT'

# Subscribe to device topics
docker-compose exec mqtt mosquitto_sub -t 'devices/+/sensors/#' -v

# View MQTT logs
docker-compose logs -f mqtt
```

## 🐛 Debugging

### View all service logs

```bash
docker-compose logs -f
```

### Access container shell

```bash
# API container
docker-compose exec api /bin/sh

# Postgres container
docker-compose exec postgres /bin/bash

# Redis container
docker-compose exec redis /bin/sh

# MQTT container
docker-compose exec mqtt /bin/sh
```

### Check service health

```bash
# API health endpoint
curl http://localhost:8000/api/health/

# Postgres connection
docker-compose exec api python manage.py dbshell

# Redis connection
docker-compose exec redis redis-cli ping

# MQTT connection
docker-compose exec mqtt mosquitto_sub -t '$$SYS/#' -C 1
```

## 🔄 Development Workflow

### Hot Reload

The API service has volume mounting enabled for hot reload:

```yaml
volumes:
  - ./backend:/app/backend
```

Changes to Python files will automatically reload the Django development server.

### Running Tests

```bash
# Run all tests
docker-compose exec api pytest

# Run with coverage
docker-compose exec api pytest --cov=.

# Run specific app tests
docker-compose exec api pytest devices/tests/
```

### Code Quality

```bash
# Format code
docker-compose exec api black .

# Sort imports
docker-compose exec api isort .

# Lint
docker-compose exec api flake8 .
```

## 🗑️ Cleanup

### Stop and remove containers

```bash
docker-compose down
```

### Remove volumes (deletes data!)

```bash
docker-compose down -v
```

### Remove images

```bash
docker-compose down --rmi all
```

### Full cleanup

```bash
docker-compose down -v --rmi all --remove-orphans
```

## 🔐 Production Considerations

For production deployment:

1. **Use secrets management** (Docker secrets, Kubernetes secrets)
2. **Enable MQTT authentication** (edit `mosquitto.conf`)
3. **Use production-grade web server** (Gunicorn + Nginx)
4. **Configure SSL/TLS** for all services
5. **Set up backups** for PostgreSQL
6. **Use managed services** (RDS, ElastiCache, IoT Core)
7. **Implement monitoring** (Prometheus, Grafana)
8. **Set resource limits** in docker-compose.yml

## 📚 Additional Resources

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Django Docker Guide](https://docs.djangoproject.com/en/5.0/howto/deployment/checklist/)
- [PostgreSQL Docker](https://hub.docker.com/_/postgres)
- [Redis Docker](https://hub.docker.com/_/redis)
- [Eclipse Mosquitto](https://mosquitto.org/documentation/)

## 🆘 Troubleshooting

### Port already in use

```bash
# Check what's using the port
sudo lsof -i :8000

# Change port in docker-compose.yml or .env
```

### Service not healthy

```bash
# Check logs
docker-compose logs [service_name]

# Restart service
docker-compose restart [service_name]
```

### Database connection refused

```bash
# Check if postgres is running
docker-compose ps postgres

# Check postgres logs
docker-compose logs postgres

# Verify environment variables
docker-compose exec api env | grep DB_
```

### Out of disk space

```bash
# Clean up Docker system
docker system prune -a --volumes

# Remove unused images
docker image prune -a

# Remove unused volumes
docker volume prune
```
