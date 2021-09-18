from django.urls import path

from .views import CustomerLoginView, CustomerLogoutView, ChangePasswordView, RegisterView, CustomerProfileView

app_name = 'customer'

urlpatterns = [
    path('auth/', CustomerLoginView.as_view(), name="auth"),
    path('register/', RegisterView.as_view(), name="register"),
    path('logout/', CustomerLogoutView.as_view(), name="logout"),
    path('change_password/', ChangePasswordView.as_view(), name="change_password"),
    path('profile/', CustomerProfileView.as_view(), name="profile"),
]
