# SmartLab IoT Platform - Backend

Django REST Framework backend for real-time IoT device management and sensor data ingestion.

## 🏗️ Architecture

- **Framework**: Django 5.0 + Django REST Framework
- **Database**: PostgreSQL (prepared for TimescaleDB)
- **Cache**: Redis
- **Authentication**: JWT (SimpleJWT)
- **API Docs**: drf-spectacular (OpenAPI 3.0)
- **Real-time**: Django Channels (WebSocket)
- **Messaging**: MQTT (Paho MQTT)

## 📁 Project Structure

```
backend/
├── config/          # Project settings & URLs
│   ├── settings.py
│   ├── urls.py
│   ├── health.py    # Health check endpoints
│   └── wsgi.py
├── devices/         # Device management app
├── sensors/         # Sensor data ingestion app
├── users/           # User management app
├── alerts/          # Alert & notification app
└── manage.py
```

## 🚀 Quick Start

### 1. Set up environment

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# or
venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Copy environment variables
cp .env.example .env
# Edit .env with your configuration
```

### 2. Database setup

```bash
# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser
```

### 3. Run development server

```bash
python manage.py runserver
```

The API will be available at:
- **API**: http://localhost:8000/api/
- **Health**: http://localhost:8000/api/health/
- **Docs**: http://localhost:8000/api/docs/
- **Admin**: http://localhost:8000/admin/

## 🔌 API Endpoints

### System

- `GET /api/health/` - Health check with service status
- `GET /api/ping/` - Simple availability check
- `GET /api/docs/` - Interactive API documentation (Swagger UI)
- `GET /api/schema/` - OpenAPI 3.0 schema

### Authentication (Coming Soon)

- `POST /api/auth/login/` - Obtain JWT tokens
- `POST /api/auth/refresh/` - Refresh access token
- `POST /api/auth/logout/` - Logout (blacklist refresh token)

### Devices (Coming Soon)

- `GET /api/devices/` - List all devices
- `POST /api/devices/` - Register new device
- `GET /api/devices/{id}/` - Get device details
- `PATCH /api/devices/{id}/` - Update device
- `DELETE /api/devices/{id}/` - Deactivate device

### Sensors (Coming Soon)

- `GET /api/sensors/` - List sensor data
- `POST /api/sensors/` - Create sensor reading
- `GET /api/sensors/{id}/` - Get sensor details

## 🧪 Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=.

# Run specific app tests
pytest devices/tests/
```

## 📝 Code Quality

```bash
# Format code
black .

# Sort imports
isort .

# Lint
flake8 .

# All checks
black . && isort . && flake8 .
```

## 🐳 Docker

```bash
# Build image
docker build -t smartlab-backend .

# Run with docker-compose (from project root)
docker-compose up
```

## 🔐 Environment Variables

Required variables (see `.env.example`):

- `SECRET_KEY` - Django secret key
- `DEBUG` - Debug mode (True/False)
- `ALLOWED_HOSTS` - Comma-separated allowed hosts
- `DB_*` - Database connection settings
- `REDIS_URL` - Redis connection URL
- `MQTT_*` - MQTT broker settings
- `JWT_*` - JWT token configuration

## 📚 Documentation

- [Architecture Decision Records](../docs/adr/)
- [API Documentation](http://localhost:8000/api/docs/) (when running)
- [Django REST Framework Docs](https://www.django-rest-framework.org/)

## 🔄 Development Workflow

1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes and add tests
3. Run code quality checks
4. Commit with conventional commits: `feat: add device registration`
5. Push and create pull request

## 📦 Dependencies

Core packages:
- Django 5.0
- djangorestframework 3.14
- djangorestframework-simplejwt 5.3
- psycopg2-binary 2.9 (PostgreSQL driver)
- redis 5.0
- paho-mqtt 1.6 (MQTT client)
- channels 4.0 (WebSockets)
- drf-spectacular 0.27 (API docs)

Development:
- pytest & pytest-django (testing)
- black, isort, flake8 (code quality)

## 🎯 Next Steps

- [ ] Implement Device model and API
- [ ] Add JWT authentication endpoints
- [ ] Create sensor data ingestion pipeline
- [ ] Set up WebSocket connections
- [ ] Integrate MQTT subscriber
- [ ] Add TimescaleDB for time-series data
- [ ] Implement alert system
- [ ] Add CI/CD pipeline

## 📄 License

MIT License - See [LICENSE](../LICENSE) for details
