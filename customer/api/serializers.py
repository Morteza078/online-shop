from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils.encoding import force_str
from django.utils.http import urlsafe_base64_decode
from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed

from customer.models import Customer, CustomUser
from django.utils.translation import gettext_lazy as _


class CustomerRegisterSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=70, label=_('username'))
    password = serializers.CharField(max_length=100, label=_('password'))
    confirm_password = serializers.CharField(max_length=100, label=_('confirm_password'), write_only=True)
    email = serializers.EmailField(max_length=70, label=_('email address'))

    def create(self, validated_data):
        user = Customer.objects.create_user(username=validated_data['username'],
                                            email=validated_data['email'])
        user.set_password(validated_data['password'])
        user.save()
        return validated_data

    def validate(self, attrs):
        username = attrs['username']
        password = attrs['password']
        email = attrs['email']
        confirm_password = attrs['confirm_password']
        print(CustomUser.objects.filter(email=email).exists())
        if CustomUser.objects.filter(username=username).exists():
            raise serializers.ValidationError(_('this username already exist'))
        elif CustomUser.objects.filter(email=email).exists():
            raise serializers.ValidationError(_('this email already exist'))
        elif password != confirm_password:
            raise serializers.ValidationError(_('The two password fields didn’t match'))
        return attrs


class ResetPasswordEmailRequestSerializer(serializers.Serializer):
    email = serializers.EmailField(min_length=2)

    class Meta:
        fields = ['email']


class SetNewPasswordSerializer(serializers.Serializer):
    password = serializers.CharField(min_length=6,
                                     max_length=100, write_only=True)
    token = serializers.CharField(min_length=1, write_only=True)
    uidb64 = serializers.CharField(min_length=1, write_only=True)

    class Meta:
        fields = ['password', 'token', 'uidb64']
    def validate(self, attrs):
        try:
            password=attrs['password']
            token=attrs['token']
            uidb64=attrs['uidb64']
            id=force_str(urlsafe_base64_decode(uidb64))
            customer=Customer.objects.get(id=id)
            if not PasswordResetTokenGenerator().check_token(customer,token):
                raise AuthenticationFailed('the reset link is invalid',401)
            customer.set_password(password)
            customer.save()
        except Exception as e:
            raise AuthenticationFailed('the reset link is invalid',401)
        return super().validate(attrs)
