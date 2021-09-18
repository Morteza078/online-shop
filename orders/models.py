from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from customer.models import Customer
from orders.generate_code import random_string
from products.models import Product
from translated_fields import TranslatedField

from django.utils.translation import gettext_lazy as _


# Create your models here.

class DiscountCode(models.Model):
    code = models.CharField(_("discount code"), max_length=100, unique=True, default=random_string)
    valid_from = models.DateTimeField(_("valid from"))
    valid_to = models.DateTimeField(_("valid to"))
    active = models.BooleanField(_("active"))
    discount = models.IntegerField(_("discount"), validators=[MinValueValidator(0), MaxValueValidator(100)])
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name=_('owner'))

    class Meta:
        verbose_name = _("Discount code")
        verbose_name_plural = _("Discount codes")

    def __str__(self):
        return self.code


class OrderItem(models.Model):
    user = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name=_('user'))
    product = models.ForeignKey(Product, on_delete=models.CASCADE, verbose_name=_('product'))
    quantity = models.IntegerField(_("quantity"), default=1)

    class Meta:
        verbose_name = _("Order item")
        verbose_name_plural = _("Order items")

    def __str__(self):
        return f'{self.quantity} of {self.product.name}'


class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name=_('costumer'))
    items = models.ManyToManyField(OrderItem, verbose_name=_('items of order'))
    start_date = models.DateTimeField(auto_now_add=True)
    ordered_date = models.DateTimeField(_("order date"), )
    STATUS = (
        ('0', _("ready to send")),
        ('1', _("sending")),
        ('2', _("delivered")),
    )
    status = models.CharField(_("status"), max_length=50, choices=STATUS, default='0')

    class Meta:
        verbose_name = _("Order")
        verbose_name_plural = _("Orders")

    def __str__(self):
        return self.customer.username

    def total_price(self, discount_code):
        total_price = 0
        for item in self.items.all():
            total_price += item.product.price * item.quantity
        return total_price * discount_code


class OrderHistory(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE,verbose_name=_('costumer'))
    items = models.ManyToManyField(OrderItem,verbose_name=_('order item'))
    start_date = models.DateTimeField(_("start date"))
    ordered_date = models.DateTimeField(_("Ordered date"))
    status = TranslatedField(models.CharField(_("status"), max_length=50))
    final_price = models.PositiveIntegerField(_("final price"))

    class Meta:
        verbose_name = _("Order history")
        verbose_name_plural = _("Order histories")

    def __str__(self):
        return self.customer.username
