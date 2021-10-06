import datetime

import pytz
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from customer.models import Customer, Address
from orders.generate_code import random_string
from products.models import Product
from translated_fields import TranslatedField

from django.utils.translation import gettext_lazy as _


# Create your models here.

class DiscountCode(models.Model):
    code = models.CharField(_("discount code"), max_length=100, unique=True, default=random_string)
    valid_from = models.DateTimeField(_("valid from"))
    valid_to = models.DateTimeField(_("valid to"))
    discount = models.IntegerField(_("discount"), validators=[MinValueValidator(0), MaxValueValidator(100)])
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name=_('owner'), related_name='codes')

    # ///////////
    class Meta:
        verbose_name = _("Discount code")
        verbose_name_plural = _("Discount codes")

    def __str__(self):
        return self.code


class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name=_('costumer'))
    start_date = models.DateTimeField(auto_now_add=True)
    ordered_date = models.DateTimeField(_("order date"), default=pytz.utc.localize(datetime.datetime.now() + datetime.timedelta(days=2)))
    READY_TO_SEND = '0'
    SENDING = '1'
    DELIVERED = '2'
    STATUS = (
        (READY_TO_SEND, _("ready to send")),
        (SENDING, _("sending")),
        (DELIVERED, _("delivered")),
    )
    status = models.CharField(_("status"), max_length=50, choices=STATUS, default=READY_TO_SEND)
    discount = models.IntegerField(_("discount"), validators=[MinValueValidator(0), MaxValueValidator(100)], default=0)
    address = models.ForeignKey(Address, on_delete=models.DO_NOTHING, verbose_name=_('address'))
    final_price = models.PositiveIntegerField(_("final price"))
    items = models.ManyToManyField('OrderItem', verbose_name=_('items'), )

    class Meta:
        verbose_name = _("Order")
        verbose_name_plural = _("Orders")
        ordering = ['-start_date']

    def __str__(self):
        return f'{self.customer.username} at {self.ordered_date}'


class OrderItem(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, verbose_name=_('product'))
    quantity = models.IntegerField(_("quantity"), default=1)

    class Meta:
        verbose_name = _("Order item")
        verbose_name_plural = _("Order items")

    def __str__(self):
        return f'{self.quantity} of {self.product.name}'
