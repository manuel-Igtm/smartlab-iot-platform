# 🔬 SmartLab IoT Platform

> A production-grade IoT platform for monitoring and controlling laboratory equipment in real-time. Built with Django REST Framework, Docker, and modern DevOps practices.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Django](https://img.shields.io/badge/django-5.0+-green.svg)](https://www.djangoproject.com/)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)

## 🎯 Project Vision

As a CTO-in-training, this project demonstrates:
- **Backend Excellence**: Django REST API with best practices
- **Embedded Integration**: Real-time sensor data from STM32/ESP32 devices
- **DevOps Culture**: Docker, CI/CD, monitoring, and observability
- **Documentation First**: ADRs, API docs, and runbooks
- **Production Ready**: Security, testing, and scalability

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Internet / Cloud                         │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│              NGINX Reverse Proxy (TLS)                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│        Django REST API (Gunicorn + Django 5.0)             │
│  ├─ Authentication (JWT/OAuth2)                            │
│  ├─ Device Management API                                  │
│  ├─ Real-time Sensor Data API                              │
│  ├─ Control Commands API                                   │
│  └─ WebSocket for live updates                             │
└──────────────┬───────────────────┬──────────────────────────┘
               │                   │
    ┌──────────▼─────────┐  ┌─────▼──────────┐
    │  PostgreSQL 16     │  │  Redis 7       │
    │  (Time-series)     │  │  (Cache/Queue) │
    └────────────────────┘  └────────────────┘
               │
    ┌──────────▼─────────────────────────────────────┐
    │        MQTT Broker (Mosquitto)                 │
    └──────────┬─────────────────────────────────────┘
               │
    ┌──────────▼─────────────────────────────────────┐
    │   IoT Devices (STM32/ESP32)                    │
    │   ├─ Temperature sensors (DS18B20)             │
    │   ├─ Humidity sensors (DHT22)                  │
    │   ├─ Pressure sensors (BMP280)                 │
    │   └─ Control relays & actuators                │
    └────────────────────────────────────────────────┘
```

## 🚀 Features

### Phase 1: Foundation (Current)
- [x] Project structure setup
- [ ] Django REST API scaffolding
- [ ] PostgreSQL database setup
- [ ] Docker Compose configuration
- [ ] Basic authentication (JWT)

### Phase 2: Core Functionality
- [ ] Device registration & management
- [ ] Real-time sensor data ingestion (MQTT)
- [ ] Time-series data storage
- [ ] RESTful API endpoints
- [ ] WebSocket live updates

### Phase 3: Advanced Features
- [ ] User management & permissions
- [ ] Alert system (threshold-based)
- [ ] Data visualization API
- [ ] Control commands (device control)
- [ ] Historical data analytics

### Phase 4: Production Ready
- [ ] Comprehensive testing (>80% coverage)
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Monitoring (Prometheus + Grafana)
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Security hardening

## 🛠️ Tech Stack

### Backend
- **Framework**: Django 5.0 + Django REST Framework
- **Database**: PostgreSQL 16 (with TimescaleDB extension)
- **Cache**: Redis 7
- **Message Queue**: Celery + Redis
- **MQTT Broker**: Eclipse Mosquitto

### DevOps
- **Containerization**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus + Grafana
- **Logging**: ELK Stack (Elasticsearch, Logstash, Kibana)
- **Reverse Proxy**: NGINX

### Embedded Devices
- **MCU**: STM32F4/ESP32
- **Protocol**: MQTT over WiFi
- **Sensors**: DS18B20, DHT22, BMP280
- **Language**: C/C++ (PlatformIO)

## 📦 Quick Start

### Prerequisites
```bash
# Required
- Docker & Docker Compose
- Python 3.11+
- Git

# Optional (for local development)
- PostgreSQL 16
- Redis 7
```

### Installation

```bash
# Clone the repository
git clone https://github.com/manuel-Igtm/smartlab-iot-platform.git
cd smartlab-iot-platform

# Create environment file
cp .env.example .env

# Start all services with Docker Compose
docker-compose up -d

# Run database migrations
docker-compose exec api python manage.py migrate

# Create superuser
docker-compose exec api python manage.py createsuperuser

# Access the API
# API: http://localhost:8000/api/
# Admin: http://localhost:8000/admin/
# Docs: http://localhost:8000/api/docs/
```

## 📚 Documentation

- [Architecture Decision Records (ADRs)](./docs/adr/README.md)
- [API Documentation](./docs/api/README.md)
- [Deployment Guide](./docs/deployment/README.md)
- [Contributing Guidelines](./CONTRIBUTING.md)
- [Development Setup](./docs/development.md)

## 🧪 Testing

```bash
# Run all tests
docker-compose exec api pytest

# Run with coverage
docker-compose exec api pytest --cov=. --cov-report=html

# Run specific test
docker-compose exec api pytest apps/devices/tests/test_models.py
```

## 🔒 Security

- JWT authentication with refresh tokens
- HTTPS/TLS in production (Let's Encrypt)
- SQL injection protection (Django ORM)
- CORS configuration
- Rate limiting (Django REST Framework)
- Environment variable management
- Regular security audits

## 📈 Performance

- Database query optimization (select_related, prefetch_related)
- Redis caching layer
- API response pagination
- WebSocket for real-time updates (no polling)
- Database indexing strategy
- Load testing with Locust

## 🤝 Contributing

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification.

```bash
# Create a feature branch
git checkout -b feat/your-feature-name

# Make your changes and commit
git commit -m "feat: add device status monitoring"

# Push and create PR
git push origin feat/your-feature-name
```

## 📊 Project Status

Track progress on the [GitHub Project Board](https://github.com/users/manuel-Igtm/projects/1)

## 🎓 Learning Objectives

This project is part of my CTO development journey. Key learning areas:

1. **Backend Architecture**: RESTful API design, database optimization
2. **DevOps**: Docker, CI/CD, infrastructure as code
3. **Embedded Systems**: IoT device communication, MQTT protocol
4. **Security**: Authentication, authorization, secure communication
5. **Documentation**: ADRs, API docs, technical writing
6. **Testing**: Unit, integration, and end-to-end testing
7. **Monitoring**: Observability, logging, metrics

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

## 👤 Author

**Immanuel N (manuel-Igtm)**
- Email: immanuelnjogu@students.tukenya.ac.ke
- GitHub: [@manuel-Igtm](https://github.com/manuel-Igtm)
- LinkedIn: [in/immanuel-njogu](https://linkedin.com/in/immanuel-njogu)

---

**Built with ❤️ as part of the CTO Development Journey 2025**
