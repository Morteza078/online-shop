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


class EditProfileForm(forms.ModelForm):
    first_name = forms.CharField(required=False)
    last_name = forms.CharField(required=False)
    image=forms.ImageField(widget=forms.FileInput,required=False)

    class Meta:
        model = Customer
        fields = ('username', 'first_name', 'last_name', 'email', 'image',)

    # def clean(self):
    #     cleaned_data = self.data
    #     username = cleaned_data['username']
    #     email = cleaned_data['email']
    #     if CustomUser.objects.filter(username=username).exists():
    #         raise forms.ValidationError({_('this username already exist')})
    #     elif CustomUser.objects.filter(email=email).exists():
    #         raise forms.ValidationError({_('this email already exist')})
    #     return cleaned_data

