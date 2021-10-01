from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import User, AbstractUser
from django.db import models
from translated_fields import TranslatedField
from django.utils.translation import gettext_lazy as _


# Create your models here.


class CustomUser(AbstractUser):
    image = models.ImageField(_('image'), upload_to='profiles/', null=True, blank=True)
    is_active = models.BooleanField(_('active'), default=True)
    email = models.EmailField(_('email address'), unique=True)

    class Meta:
        verbose_name = _("Custom user")
        verbose_name_plural = _("Custom users")

    # def __str__(self):
    #     return f"{self.username}"


class Customer(CustomUser):
    addresses = models.ManyToManyField('Address', verbose_name=_('owner'))

    class Meta:
        verbose_name = _("Customer")
        verbose_name_plural = _("Customers")

    def __str__(self):
        return f"{self.username}"


class Staff(CustomUser):
    # user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("Staff")
        verbose_name_plural = _("Staffs")

    def __str__(self):
        return f"{self.get_full_name()}"


class Address(models.Model):
    country = TranslatedField(models.CharField(_('country'), max_length=50, null=True, blank=True))
    province = TranslatedField(models.CharField(_('province'), max_length=50, null=True, blank=True))
    city = TranslatedField(models.CharField(_('city'), max_length=50, null=True, blank=True))
    house_number = models.PositiveIntegerField(_('house_number'), null=True, blank=True)
    exact_address = TranslatedField(models.TextField(_('exact address'), max_length=250))

    class Meta:
        verbose_name = _("Address")
        verbose_name_plural = _("Addresses")

    def __str__(self):
        return f"{self.exact_address}"
