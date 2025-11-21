"""
Health check views for SmartLab IoT Platform
"""
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework import status
from django.db import connection
from django.core.cache import cache
import os


@api_view(['GET'])
@permission_classes([AllowAny])
def health_check(request):
    """
    Health check endpoint
    Returns system status and version information
    """
    health_status = {
        "status": "healthy",
        "version": "1.0.0",
        "environment": os.getenv('ENVIRONMENT', 'development'),
        "services": {}
    }
    
    # Check database connection
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
        health_status["services"]["database"] = "connected"
    except Exception as e:
        health_status["services"]["database"] = f"error: {str(e)}"
        health_status["status"] = "degraded"
    
    # Check Redis cache
    try:
        cache.set('health_check', 'ok', 10)
        cache_value = cache.get('health_check')
        if cache_value == 'ok':
            health_status["services"]["cache"] = "connected"
        else:
            health_status["services"]["cache"] = "error: unexpected value"
            health_status["status"] = "degraded"
    except Exception as e:
        health_status["services"]["cache"] = f"error: {str(e)}"
        health_status["status"] = "degraded"
    
    response_status = status.HTTP_200_OK if health_status["status"] == "healthy" else status.HTTP_503_SERVICE_UNAVAILABLE
    
    return Response(health_status, status=response_status)


@api_view(['GET'])
@permission_classes([AllowAny])
def ping(request):
    """
    Simple ping endpoint for basic availability check
    """
    return Response({"message": "pong"}, status=status.HTTP_200_OK)
