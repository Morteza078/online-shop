from django.contrib.postgres.fields import ArrayField
from django.db import models


# Create your models here.
class Category(models.Model):
    name = models.CharField(max_length=250, )
    parent = models.ForeignKey("self", on_delete=models.CASCADE, null=True, blank=True)


class Attribute(models.Model):
    name = models.CharField(max_length=250)
    category = models.ManyToManyField(Category)
    values = ArrayField(models.CharField(max_length=10), null=True, blank=True)


class ProductImage(models.Model):
    image = models.ImageField(upload_to='products/%Y/%m/%d/')
    uploaded_at = models.DateTimeField(auto_now_add=True)


class Product(models.Model):
    name = models.CharField(max_length=250)
    description = models.TextField()
    price = models.FloatField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    images = models.ManyToManyField(ProductImage, related_name='images', null=True, blank=True)
    inventory = models.PositiveIntegerField(default=0)
