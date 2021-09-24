from django.urls import path

from .views import RegisterAPIView, RequestPaswordResetEmail, CheckPasswordTokenView, SetNewPasswordAPIView, \
    SetChangePasswordView

urlpatterns = [
    path('', RegisterAPIView.as_view(), name='api-customer-list'),
    path('request-reset-email/', RequestPaswordResetEmail.as_view(), name='request-reset-email'),
    path('password-reset/<uidb64>/<token>/',
         CheckPasswordTokenView.as_view(), name='password-reset-confirm'),
    path('password-reset-complete/', SetNewPasswordAPIView.as_view(), name='password-reset-complete'),
    path('set-change-password', SetChangePasswordView.as_view(), name='set-change-password'),
    # path('edit-profile', EditProfileView.as_view(), name='edit-profile'),
]
