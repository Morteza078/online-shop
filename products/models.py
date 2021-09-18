from django.contrib.postgres.fields import ArrayField
from django.db import models
from translated_fields import TranslatedField
from django.utils.translation import gettext_lazy as _


# Create your models here.
class Category(models.Model):
    name = TranslatedField(models.CharField(_('name'), max_length=250))
    parent = models.ForeignKey("self", on_delete=models.CASCADE, null=True, blank=True, verbose_name=_('parent'))

    class Meta:
        verbose_name = _("Category")
        verbose_name_plural = _("Categories")


class Attribute(models.Model):
    name = TranslatedField(models.CharField(_('name'), max_length=250))
    category = models.ManyToManyField(Category,verbose_name=_('category'))
    values = ArrayField(models.CharField(_('values'), max_length=10), null=True, blank=True)

    class Meta:
        verbose_name = _("Attribute")
        verbose_name_plural = _("Attributes")

    def __str__(self):
        return f"{self.name}"


class ProductImage(models.Model):
    title = TranslatedField(models.CharField(_('image'), max_length=100))
    image = models.ImageField(_('image'), upload_to='products/%Y/%m/%d/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = _("ProductImage")
        verbose_name_plural = _("ProductImages")

    def __str__(self):
        return f"{self.title}"


class Product(models.Model):
    name = TranslatedField(models.CharField(_('image'), max_length=250))
    description = TranslatedField(models.TextField(_('description')))
    price = models.FloatField(_('price'))
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    images = models.ManyToManyField(ProductImage, related_name='images', verbose_name=_('images'))
    number_of_products = models.PositiveIntegerField(_('number of products'), default=0)

    class Meta:
        verbose_name = _("Product")
        verbose_name_plural = _("Products")

    def __str__(self):
        return f"{self.name}"
