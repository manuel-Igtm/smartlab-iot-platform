# Contributing to SmartLab IoT Platform

First off, thank you for considering contributing to this project! 🎉

This project is primarily a learning journey, but contributions, suggestions, and feedback are always welcome.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Requirements](#testing-requirements)

## 🤝 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help others learn and grow

## 🎯 How Can I Contribute?

### Reporting Bugs
Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md)

### Suggesting Features
Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md)

### Code Contributions
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write/update tests
5. Submit a pull request

### Documentation
- Fix typos or unclear explanations
- Add examples or tutorials
- Improve ADRs or API documentation

## 💻 Development Setup

### Prerequisites
```bash
- Docker & Docker Compose
- Python 3.11+
- Git
- VS Code (recommended)
```

### Setup Steps
```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/smartlab-iot-platform.git
cd smartlab-iot-platform

# Add upstream remote
git remote add upstream https://github.com/manuel-Igtm/smartlab-iot-platform.git

# Create a virtual environment (for local development)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r backend/requirements.txt
pip install -r backend/requirements-dev.txt

# Copy environment variables
cp .env.example .env

# Start services with Docker
docker-compose up -d

# Run migrations
docker-compose exec api python manage.py migrate

# Create superuser
docker-compose exec api python manage.py createsuperuser
```

## 📝 Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) specification:

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks
- `perf`: Performance improvements
- `ci`: CI/CD changes
- `build`: Build system changes

### Examples
```bash
feat(devices): add device registration endpoint

Implement POST /api/devices/ endpoint for registering new IoT devices.
Includes validation, authentication, and device ID generation.

Closes #12

---

fix(sensors): correct temperature conversion formula

The Celsius to Fahrenheit conversion was using the wrong formula.
Changed from (C * 9/5) + 30 to (C * 9/5) + 32.

Fixes #45

---

docs(adr): add ADR for MQTT broker selection

Document the decision to use Eclipse Mosquitto as the MQTT broker,
including alternatives considered and trade-offs.
```

## 🔄 Pull Request Process

### Before Submitting
- [ ] Code follows the project's coding standards
- [ ] All tests pass (`pytest`)
- [ ] New code has tests (>80% coverage)
- [ ] Documentation is updated
- [ ] Commit messages follow conventions
- [ ] No merge conflicts with main branch

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How was this tested?

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] ADR created (if architectural decision)

## Screenshots (if applicable)
```

### Review Process
1. Automated checks must pass (GitHub Actions)
2. Code review by maintainer
3. Address feedback
4. Approval and merge

## 🎨 Coding Standards

### Python (Backend)
- Follow [PEP 8](https://pep8.org/)
- Use [Black](https://black.readthedocs.io/) for formatting
- Use [isort](https://pycqa.github.io/isort/) for import sorting
- Use [flake8](https://flake8.pycqa.org/) for linting
- Use type hints (Python 3.11+)
- Max line length: 100 characters

### Example
```python
from typing import List, Optional
from django.db import models


class Device(models.Model):
    """IoT device model for managing connected sensors."""
    
    device_id: str = models.CharField(max_length=50, unique=True)
    name: str = models.CharField(max_length=100)
    is_active: bool = models.BooleanField(default=True)
    created_at: models.DateTimeField = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ["-created_at"]
        verbose_name = "Device"
        verbose_name_plural = "Devices"
    
    def __str__(self) -> str:
        return f"{self.name} ({self.device_id})"
    
    def activate(self) -> None:
        """Activate this device."""
        self.is_active = True
        self.save()
```

### C/C++ (Embedded)
- Follow [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
- Use meaningful variable names
- Comment complex logic
- Use `const` where applicable

### Git
- One feature per branch
- Keep commits atomic
- Write clear commit messages
- Rebase before PR (keep history clean)

## 🧪 Testing Requirements

### Unit Tests
- All new code must have tests
- Aim for >80% code coverage
- Use pytest fixtures
- Mock external dependencies

### Example Test
```python
import pytest
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.devices.models import Device


@pytest.mark.django_db
class TestDeviceAPI:
    """Test suite for Device API endpoints."""
    
    def test_create_device_success(self, api_client: APIClient, auth_headers: dict):
        """Test successful device creation."""
        url = reverse("device-list")
        data = {
            "device_id": "DEVICE001",
            "name": "Temperature Sensor 1",
            "type": "temperature"
        }
        
        response = api_client.post(url, data, **auth_headers)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert Device.objects.count() == 1
        assert Device.objects.first().device_id == "DEVICE001"
```

### Integration Tests
- Test API endpoints end-to-end
- Test MQTT message flow
- Test database interactions

### Running Tests
```bash
# Run all tests
docker-compose exec api pytest

# Run with coverage
docker-compose exec api pytest --cov=. --cov-report=html

# Run specific test file
docker-compose exec api pytest apps/devices/tests/test_api.py

# Run specific test
docker-compose exec api pytest apps/devices/tests/test_api.py::TestDeviceAPI::test_create_device_success
```

## 📚 Documentation Standards

### Code Documentation
- Docstrings for all public functions/classes
- Use Google-style docstrings
- Include type hints

### ADRs (Architecture Decision Records)
- Create ADR for significant decisions
- Use the template in `docs/adr/`
- Link to related issues/PRs

### API Documentation
- Document all endpoints
- Include request/response examples
- Use OpenAPI/Swagger annotations

## 🏷️ Issue Labels

- `bug`: Something isn't working
- `enhancement`: New feature request
- `documentation`: Documentation improvements
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention needed
- `question`: Further information requested
- `wontfix`: Will not be worked on

## 🌟 Recognition

Contributors will be:
- Added to CONTRIBUTORS.md
- Mentioned in release notes
- Credited in relevant documentation

## 📞 Questions?

- Open an issue with the `question` label
- Email: immanuelnjogu@students.tukenya.ac.ke
- LinkedIn: [immanuel-njogu](https://linkedin.com/in/immanuel-njogu)

---

**Remember**: This is a learning project. Mistakes are expected and celebrated as learning opportunities. Don't be afraid to ask questions or propose ideas! 🚀
