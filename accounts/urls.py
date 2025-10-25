from django.urls import path
from accounts.views import RegistrationView, LoginView,LogoutView
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    # Auth routes (APIView-based)
    path('api/auth/register/', RegistrationView.as_view(), name='register'),
    path('api/auth/login/', LoginView.as_view(), name='login'),
    path('refresh/', TokenRefreshView.as_view()),
    path('api/auth/logout/', LogoutView.as_view(),name='logout')
    
]