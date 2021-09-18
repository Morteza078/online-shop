import json

from django.contrib.auth import login
from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.contrib.sites.shortcuts import get_current_site
from django.shortcuts import render, redirect
from django.urls import reverse
from django.utils.encoding import smart_bytes, smart_str, DjangoUnicodeDecodeError
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from rest_framework import status, generics, permissions
from rest_framework.decorators import api_view
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.permissions import IsAdminUser, AllowAny
from rest_framework.response import Response
from .utils import Util

from .serializers import CustomerRegisterSerializer, ResetPasswordEmailRequestSerializer, SetNewPasswordSerializer
from customer.models import Customer, CustomUser
from ..forms import CustomerRegisterForm


class RegisterAPIView(generics.ListCreateAPIView):
    queryset = Customer.objects.all()
    serializer_class = CustomerRegisterSerializer
    permission_classes = (AllowAny,)
    # permission_classes = [IsAdminUser]


# @api_view(['GET', 'POST'])
# def customer_register(request):
#     """
#     List all code snippets, or create a new snippet.
#     """
#     if request.method == 'GET':
#         customers = Customer.objects.all()
#         print('in get----------------------')
#         serializer = CustomerRegisterSerializer(customers, many=True)
#         return Response(serializer.data)
#
#     elif request.method == 'POST':
#         # print(request.data)
#         # print(dict(request.data))
#         # print(request.data.dict())
#         serializer = CustomerRegisterSerializer(data=request.data)
#         # print(serializer)
#         if serializer.is_valid():
#             serializer.save()
#             print(serializer)
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         print(serializer.errors)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# @api_view(['GET', 'POST'])
# def customer_list(request):
#     """
#     List all code customers , or create a new customer.
#     """
#     if request.method == 'GET':
#         customers = Customer.objects.all()
#         serializer = CustomerRegisterSerializer(customers, many=True)
#         return Response(serializer.data)
#
#     elif request.method == 'POST':
#         form = CustomerRegisterForm(request.POST, request.FILES)
#             serializer = CustomerRegisterSerializer(data=request.data)
#             if serializer.is_valid():
#                 serializer.save()
#                 print(form.cleaned_data['username'])
#                 print(auth(request, Customer.objects.get(username=form.cleaned_data['username'])))
#                 return redirect('products:index')
#             return render(request, 'customer/register.html', context={
#                 'form': form, 'serializer': serializer
#             })
#         return render(request, 'customer/register.html', context={
#             'form': form
#         })
class RequestPaswordResetEmail(generics.GenericAPIView):
    serializer_class = ResetPasswordEmailRequestSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        email = request.data['email']
        if Customer.objects.filter(email=email).exists():
            customer = Customer.objects.get(email=email)
            uidb64 = urlsafe_base64_encode(smart_bytes(customer.id))
            token = PasswordResetTokenGenerator().make_token(customer)
            current_site = get_current_site(request=request).domain
            relativeLink = reverse('password-reset-confirm', kwargs={
                'uidb64': uidb64,
                'token': token
            })
            absurl = 'http://' + current_site + relativeLink
            print(absurl)
            email_body = 'Hello,\n Use link below to reset your password \n' + absurl
            data = {
                'email_body': email_body,
                'to_email': customer.email,
                'email_subject': 'Reset your password'
            }
            Util.send_email(data)
            return Response({
                'success': 'we have sent you link to reset your password'
            }, status=status.HTTP_200_OK)
        return Response({'error': 'Don’t have an account?'}, status=status.HTTP_400_BAD_REQUEST)


class CheckPasswordTokenView(generics.GenericAPIView):
    def get(self, request, uidb64, token):
        try:
            id = smart_str(urlsafe_base64_decode(uidb64))
            customer = Customer.objects.get(id=id)

            if not PasswordResetTokenGenerator().check_token(customer, token):
                return Response({'error': 'Token is not valid, please request a new one'},
                                status=status.HTTP_401_UNAUTHORIZED)
            return Response({'success': True,
                             'message': 'credentials valid',
                             'uidb64': uidb64,
                             'token': token}, status=status.HTTP_200_OK)
        except DjangoUnicodeDecodeError as identifier:
            raise AuthenticationFailed('the reset link is invalid',401)


class SetNewPasswordAPIView(generics.GenericAPIView):
    serializer_class = SetNewPasswordSerializer

    def patch(self,request):
        serializer=self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response({'success':True ,'message':'Password reset success'},status=status.HTTP_200_OK)