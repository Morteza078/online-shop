from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
from random_words import RandomWords
from django.db import models
from translated_fields import TranslatedField


# Create your models here.
def random_string():
    word = RandomWords()
    return word.random_word() + word.random_word() + word.random_word()


class Customer(User):
    pass

    # user = models.OneToOneField(User, on_delete=models.CASCADE)
    class Meta:
        verbose_name_plural = 'Customers'


class DiscountCode(models.Model):
    code = models.CharField(max_length=100, unique=True, default=random_string)
    valid_from = models.DateTimeField()
    valid_to = models.DateTimeField()
    active = models.BooleanField()
    discount = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)])
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE)

    def __str__(self):
        return self.code


class Address(models.Model):
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE)
    country = models.CharField(max_length=50, null=True, blank=True)
    province = models.CharField(max_length=50, null=True, blank=True)
    city = models.CharField(max_length=50, null=True, blank=True)
    house_number = models.PositiveIntegerField(null=True, blank=True)
    exact_address = models.TextField(max_length=250)

    def __str__(self):
        return f"{self.exact_address}"
