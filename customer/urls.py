from django.urls import path

from .views import CustomerLoginView, ChangePasswordView, RegisterView, CustomerProfileView, \
    SendLinkResetPasswordView, Set_New_Password, EditProfileView, customer_logout, add_address, remove_address

app_name = 'customer'

urlpatterns = [
    path('login/', CustomerLoginView.as_view(), name="login"),
    path('register/', RegisterView.as_view(), name="register"),
    path('logout/', customer_logout, name="logout"),
    path('reset-password/', SendLinkResetPasswordView.as_view(), name="reset-password"),
    path('set-new-password/<uidb64>/<token>/', Set_New_Password, name="set-new-password"),
    path('change-password/', ChangePasswordView.as_view(), name="change_password"),
    path('profile/', CustomerProfileView.as_view(), name="profile"),
    path('edit-profile/', EditProfileView.as_view(), name="edit_profile"),
    path('add-address/', add_address, name="add_address"),
    path('remove-address/<int:address_id>', remove_address, name="remove_address"),
]
