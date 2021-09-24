from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.utils.encoding import force_str
from django.utils.http import urlsafe_base64_decode
from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed
from customer.models import Customer, CustomUser
from django.utils.translation import gettext_lazy as _


class CustomerRegisterSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=70, label=_('username'))
    password = serializers.CharField(min_length=6, max_length=100, label=_('password'))
    confirm_password = serializers.CharField(min_length=6, max_length=100, label=_('confirm_password'), write_only=True)
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
            password = attrs['password']
            token = attrs['token']
            uidb64 = attrs['uidb64']
            id = force_str(urlsafe_base64_decode(uidb64))
            customer = Customer.objects.get(id=id)
            if not PasswordResetTokenGenerator().check_token(customer, token):
                raise AuthenticationFailed('the reset link is invalid', 401)
            customer.set_password(password)
            customer.save()
        except Exception as e:
            raise AuthenticationFailed('the reset link is invalid', 401)
        return super().validate(attrs)


class SetChangePasswordSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=70, label=_('username'))
    old_password = serializers.CharField(min_length=6, max_length=100, write_only=True)
    new_password1 = serializers.CharField(min_length=6, max_length=100, write_only=True)
    new_password2 = serializers.CharField(min_length=6, max_length=100, write_only=True)

    class Meta:
        fields = ['username', 'old_password', 'new_password1', 'new_password2']

    def validate(self, attrs):
        if attrs['new_password1'] != attrs['new_password2']:
            raise serializers.ValidationError({"matching": _("Password fields didn't match.")})

        return super().validate(attrs)




#
# class Base64ImageField(serializers.ImageField):
#     """
#     A Django REST framework field for handling image-uploads through raw post data.
#     It uses base64 for encoding and decoding the contents of the file.
#
#     Heavily based on
#     https://github.com/tomchristie/django-rest-framework/pull/1268
#
#     Updated for Django REST framework 3.
#     """
#
#     def to_internal_value(self, data):
#         from django.core.files.base import ContentFile
#         import base64
#         import six
#         import uuid
#
#         # Check if this is a base64 string
#         if isinstance(data, six.string_types):
#             # Check if the base64 string is in the "data:" format
#             if 'data:' in data and ';base64,' in data:
#                 # Break out the header from the base64 content
#                 header, data = data.split(';base64,')
#
#             # Try to decode the file. Return validation error if it fails.
#             try:
#                 decoded_file = base64.b64decode(data)
#             except TypeError:
#                 self.fail('invalid_image')
#
#             # Generate file name:
#             file_name = str(uuid.uuid4())[:12] # 12 characters are more than enough.
#             # Get the file name extension:
#             file_extension = self.get_file_extension(file_name, decoded_file)
#
#             complete_file_name = "%s.%s" % (file_name, file_extension, )
#
#             data = ContentFile(decoded_file, name=complete_file_name)
#
#         return super(Base64ImageField, self).to_internal_value(data)
#
#     def get_file_extension(self, file_name, decoded_file):
#         import imghdr
#
#         extension = imghdr.what(file_name, decoded_file)
#         extension = "jpg" if extension == "jpeg" else extension
#
#         return extension



# class EditProfileSerializer(serializers.Serializer):
#     username = serializers.CharField(max_length=70, label=_('username'), required=False)
#     old_username = serializers.CharField(max_length=70, label=_('old_username'), required=False)
#     first_name = serializers.CharField(max_length=70, label=_('first name'), required=False)
#     last_name = serializers.CharField(max_length=70, label=_('last name'), required=False)
#     email = serializers.EmailField(max_length=70, label=_('email address'), required=False)
#     old_email = serializers.EmailField(max_length=70, label=_('old_email address'), required=False)
#     image =serializers.ImageField(required=False)
#
#     def validate(self, attrs):
#         username = attrs['username']
#         email = attrs['email']
#         if CustomUser.objects.filter(username=username).exists():
#             raise serializers.ValidationError({"unique": _('this username already exist')})
#         elif CustomUser.objects.filter(email=email).exists():
#             raise serializers.ValidationError({"unique": _('this email already exist')})
#         return attrs
