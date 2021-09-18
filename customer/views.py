from django.contrib.auth import login, authenticate
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.contrib.auth.views import LoginView, LogoutView, PasswordChangeView
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseBadRequest
from django.shortcuts import render, redirect

# Create your views here.
from django.urls import reverse, reverse_lazy
from django.utils.encoding import smart_str, DjangoUnicodeDecodeError
from django.utils.http import urlsafe_base64_decode
from django.views import generic, View
from django.views.generic import TemplateView

from customer.forms import CustomerLoginForm, CustomerRegisterForm, CustomerChangePassword, ResetPasswordSendEmail, \
    SetResetPassword

# Create your views here.
from customer.models import Customer


class CustomerLoginView(LoginView):
    """
    Customize Built-in View for Login Customers
    """

    authentication_form = CustomerLoginForm
    template_name = "customer/login.html"

    def get(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            if 'next' in request.GET:
                return HttpResponseRedirect(request.GET['next'])
            return redirect('products:index')
        return super().get(request, *args, **kwargs)


class RegisterView(View):
    form_class = CustomerRegisterForm
    template_name = 'customer/register.html'
    initial = {'key': 'value'}

    def get(self, request, *args, **kwargs):
        form = self.form_class(initial=self.initial)
        return render(request, self.template_name, {'form': form})


class CustomerProfileView(LoginRequiredMixin, View):
    """
    View for Customer See Profile Detials and Edit it
    """

    def get(self, request, *args, **kwargs):
        try:
            customer = Customer.objects.get(id=request.user.id)
        except Customer.DoesNotExist:
            return redirect(reverse("customer:logout"))
        return render(request, "customer/profile.html", {
            'customer': customer,
        })


class CustomerLogoutView(LoginRequiredMixin, LogoutView):
    """
    Customize Built-in View for Logout Customers
    """
    pass


class ChangePasswordView(LoginRequiredMixin, PasswordChangeView):
    """
    Inheritanced from Built-in View for Change Customer Password in New Template
    """
    form_class = CustomerChangePassword
    success_url = reverse_lazy("products:index")
    template_name = "customer/change_password.html"


class SendLinkResetPasswordView(View):
    form_class = ResetPasswordSendEmail
    template_name = 'customer/reset_password.html'
    initial = {'key': 'value'}

    def get(self, request, *args, **kwargs):
        form = self.form_class(initial=self.initial)
        return render(request, self.template_name, {'form': form})


def Set_New_Password(request, uidb64, token):
    print(uidb64)
    print(token)
    try:
        id = smart_str(urlsafe_base64_decode(uidb64))
        customer = Customer.objects.get(id=id)

        if not PasswordResetTokenGenerator().check_token(customer, token):
            return HttpResponse({'error': 'Token is not valid, please request a new one'},
                                status=401)
        form = SetResetPassword
        context = {'success': True,
                   'message': 'credentials valid',
                   'uidb64': uidb64,
                   'token': token,
                   'form': form}
        return render(request, 'customer/set_reset_password.html', context)
    except UnicodeDecodeError as e:
        raise DjangoUnicodeDecodeError('Token is not valid, please request a new one', *e.args)
