from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django import forms
from django.utils.translation import gettext_lazy as _

from customer.models import Customer, CustomUser


class CustomerLoginForm(AuthenticationForm):
    class Meta:
        model = Customer
        fields = ('username', 'password')


# class CustomerRegisterForm(UserCreationForm):
#
#     class Meta:
#         model = Customer
#         fields = ('username', 'password1', 'password2')
class CustomerRegisterForm(forms.Form):
    username = forms.CharField(max_length=100, label=_('username'))
    email = forms.CharField(max_length=100, label=_('email'))
    password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('password'))
    confirm_password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('confirm password'))


class ResetPasswordSendEmail(forms.Form):
    email = forms.CharField(max_length=100, label=_('email'))


class SetResetPassword(forms.Form):
    new_password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('new_password'))


# def clean(self):
#     cleaned_data = super().clean()
#     password = cleaned_data.get('password')
#     confirm_password = cleaned_data.get('confirm_password')
#     username = cleaned_data.get('username')
#     # print(Customer.objects.filter(username=username).exists())
#     if CustomUser.objects.filter(username=username).exists():
#         raise forms.ValidationError(_('this username already exist'))
#     elif password != confirm_password or password is None or confirm_password is None:
#         raise forms.ValidationError(_('The two password fields didn’t match'))
#     return cleaned_data


class CustomerChangePassword(PasswordChangeForm):
    """
    Inheritanced from Built-in Change Password Form
    """

    pass
