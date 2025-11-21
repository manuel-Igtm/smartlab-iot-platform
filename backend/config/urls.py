"""
URL configuration for SmartLab IoT Platform
"""
from django.contrib import admin
from django.urls import path, include
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
from config.health import health_check, ping

urlpatterns = [
    # Admin
    path('admin/', admin.site.urls),
    
    # Health & Monitoring
    path('api/health/', health_check, name='health-check'),
    path('api/ping/', ping, name='ping'),
    
    # API Documentation
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    
    # API Endpoints (to be added)
    # path('api/devices/', include('devices.urls')),
    # path('api/sensors/', include('sensors.urls')),
    # path('api/users/', include('users.urls')),
    # path('api/alerts/', include('alerts.urls')),
]
