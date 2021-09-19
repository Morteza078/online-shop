from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django import forms
from django.utils.translation import gettext_lazy as _

from customer.models import Customer, CustomUser


class CustomerLoginForm(AuthenticationForm):
    class Meta:
        model = Customer
        fields = ('username', 'password')


class CustomerRegisterForm(forms.Form):
    username = forms.CharField(max_length=100, label=_('username'))
    email = forms.CharField(max_length=100, label=_('email'))
    password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('password'))
    confirm_password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('confirm password'))


class ResetPasswordSendEmail(forms.Form):
    email = forms.CharField(max_length=100, label=_('email'))


class SetResetPassword(forms.Form):
    new_password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('new_password'))


class CustomerChangePassword(forms.Form):
    old_password = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('old_password'))
    new_password1 = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('new_password1'))
    new_password2 = forms.CharField(max_length=100, widget=forms.PasswordInput, label=_('new_password2'))
