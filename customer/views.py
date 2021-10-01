import translated_fields
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
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
    SetResetPassword, EditProfileForm

# Create your views here.
from customer.models import Customer, Address
from shop import settings


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


# class CustomerLogoutView(LoginRequiredMixin, LogoutView):
#     """
#     Customize Built-in View for Logout Customers
#     """
#     pass
def customer_logout(request):
    cart = request.session.get(settings.CART_SESSION_ID)
    logout(request)
    if cart:
        request.session[settings.CART_SESSION_ID] = cart
    return redirect(reverse('customer:login'))


class ChangePasswordView(LoginRequiredMixin, View):
    form_class = CustomerChangePassword
    template_name = 'customer/change_password.html'
    initial = {'key': 'value'}

    def get(self, request, *args, **kwargs):
        customer = Customer.objects.get(username=request.user)
        token = PasswordResetTokenGenerator().make_token(customer)
        form = self.form_class(initial=self.initial)
        return render(request, self.template_name, {'form': form, 'token': token})


class SendLinkResetPasswordView(View):
    form_class = ResetPasswordSendEmail
    template_name = 'customer/reset_password.html'
    initial = {'key': 'value'}

    def get(self, request, *args, **kwargs):
        form = self.form_class(initial=self.initial)
        return render(request, self.template_name, {'form': form})


def Set_New_Password(request, uidb64, token):
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


class EditProfileView(LoginRequiredMixin, View):

    def get(self, request, *args, **kwargs):
        try:
            customer = Customer.objects.get(id=request.user.id)
        except Customer.DoesNotExist:
            return redirect(reverse("customer:logout"))
        form = EditProfileForm(instance=customer)
        return render(request, "customer/edit_profile.html", {
            'form': form,
        })

    def post(self, request, *args, **kwargs):
        try:
            customer = Customer.objects.get(id=request.user.id)
        except Customer.DoesNotExist:
            return redirect(reverse("customer:logout"))
        form = EditProfileForm(instance=customer, data=request.POST, files=request.FILES)
        if form.is_valid():
            form.save()
            return redirect(reverse("customer:profile"))
        return render(request, "customer/edit_profile.html", {
            'form': form,
        })


@login_required
def add_address(request):
    if request.method == 'POST':
        customer = Customer.objects.get(id=request.POST['customer_id'])
        if request.POST['persian_address'] or request.POST['english_address']:
            new_address = Address.objects.create(exact_address_fa=request.POST['persian_address'],
                                                 exact_address_en=request.POST['english_address'])
            customer.addresses.add(new_address)
            customer.save()
            new_address.save()
    return redirect(reverse("customer:profile"))


@login_required
def remove_address(request, address_id):
    address = Address.objects.get(id=address_id)
    customer = Customer.objects.get(id=request.user.id)
    customer.addresses.remove(address)
    return redirect(reverse("customer:profile"))
