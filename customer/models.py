from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import User, AbstractUser
from django.db import models
from translated_fields import TranslatedField


# Create your models here.


class CustomUser(AbstractUser):
    image = models.ImageField(upload_to='', null=True, blank=True)
    is_active = models.BooleanField(default=True)
    amount_of_shopings = models.PositiveIntegerField(default=0)


class Customer(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)

    class Meta:
        verbose_name_plural = 'Customers'


class Staff(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)

    # def create_staff(self, username, email=None, password=None, **extra_fields):
    #     extra_fields.setdefault('is_staff', True)
    #     extra_fields.setdefault('is_superuser', False)


class Address(models.Model):
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE)
    country = models.CharField(max_length=50, null=True, blank=True)
    province = models.CharField(max_length=50, null=True, blank=True)
    city = models.CharField(max_length=50, null=True, blank=True)
    house_number = models.PositiveIntegerField(null=True, blank=True)
    exact_address = models.TextField(max_length=250)

    def __str__(self):
        return f"{self.exact_address}"
