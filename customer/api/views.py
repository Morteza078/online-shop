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
from rest_framework.permissions import IsAdminUser, AllowAny, IsAuthenticated
from rest_framework.response import Response
from .utils import Util
from django.utils.translation import gettext_lazy as _
from .serializers import CustomerRegisterSerializer, ResetPasswordEmailRequestSerializer, SetNewPasswordSerializer, \
    SetChangePasswordSerializer
from customer.models import Customer, CustomUser
from ..forms import CustomerRegisterForm


class RegisterAPIView(generics.ListCreateAPIView):
    queryset = Customer.objects.all()
    serializer_class = CustomerRegisterSerializer
    permission_classes = (AllowAny,)
    # permission_classes = [IsAdminUser]


class RequestPaswordResetEmail(generics.GenericAPIView):
    serializer_class = ResetPasswordEmailRequestSerializer

    def post(self, request):
        email = request.data['email']
        if Customer.objects.filter(email=email).exists():
            customer = Customer.objects.get(email=email)
            uidb64 = urlsafe_base64_encode(smart_bytes(customer.id))
            token = PasswordResetTokenGenerator().make_token(customer)
            current_site = get_current_site(request=request).domain
            relativeLink = reverse('customer:set-new-password', kwargs={
                'uidb64': uidb64,
                'token': token
            })
            absurl = 'http://' + current_site + relativeLink
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
            raise AuthenticationFailed('the reset link is invalid', 401)


class SetNewPasswordAPIView(generics.GenericAPIView):
    serializer_class = SetNewPasswordSerializer

    def patch(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response({'success': True, 'message': 'Password reset success'}, status=status.HTTP_200_OK)


class SetChangePasswordView(generics.GenericAPIView):
    serializer_class = SetChangePasswordSerializer
    # permission_classes = (permissions.IsAuthenticated,)


    def patch(self, request):
        username = request.data['username']
        customer = Customer.objects.get(username=username)
        serializer = self.get_serializer(data=request.data)
        # Check old password
        if not customer.check_password(request.data['old_password']):
            return Response({"old_password": _("Wrong password.")}, status=status.HTTP_400_BAD_REQUEST)
        if serializer.is_valid():
            # set_password also hashes the password that the user will get
            customer.set_password(request.data['new_password1'])
            customer.save()
            response = {
                'status': 'success',
                'message': _('Password updated successfully'),
            }

            return Response(response, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# class EditProfileView(generics.GenericAPIView):
#     serializer_class = EditProfileSerializer
#     # permission_classes = (permissions.IsAuthenticated,)
#
#     def put(self, request):
#         #old_username = request.data['old_username']
#         # username=request.data['username']
#         print(request.data['image'])
#         # customer = Customer.objects.get(username='morteza')
#         # serializer = self.get_serializer(data=request.data)
#         # print(request.data['image'])
#         # if serializer.is_valid():
#         #     customer.image=request.data['image']
#         #     customer.save()
#         #     response = {
#         #         'status': 'success',
#         #         'message': _('Password updated successfully'),
#         #     }
#         #     return Response(response, status=status.HTTP_200_OK)
#         return Response({'success':'fdlsfjsl'}, status=status.HTTP_400_BAD_REQUEST)
