from django.urls import path

from .views import CustomerLoginView, CustomerLogoutView, ChangePasswordView, RegisterView, CustomerProfileView, \
    SendLinkResetPasswordView, Set_New_Password, EditProfileView

app_name = 'customer'

urlpatterns = [
    path('login/', CustomerLoginView.as_view(), name="login"),
    path('register/', RegisterView.as_view(), name="register"),
    path('logout/', CustomerLogoutView.as_view(), name="logout"),
    path('reset-password/', SendLinkResetPasswordView.as_view(), name="reset-password"),
    path('set-new-password/<uidb64>/<token>/', Set_New_Password, name="set-new-password"),
    path('change-password/', ChangePasswordView.as_view(), name="change_password"),
    path('profile/', CustomerProfileView.as_view(), name="profile"),
    path('edit-profile/', EditProfileView.as_view(), name="edit_profile"),
]
