from django.db import models
from random_words import RandomWords
from customer.models import Customer
from products.models import Product
from translated_fields import TranslatedField


# Create your models here.


def random_string():
    word = RandomWords()
    return word.random_word() + word.random_word() + word.random_word()


class OrderItem(models.Model):
    user = models.ForeignKey(Customer, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)

    def __str__(self):
        return f'{self.quantity} of {self.product.name}'


class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    items = models.ManyToManyField(OrderItem)
    start_date = models.DateTimeField(auto_now_add=True)
    ordered_date = models.DateTimeField()
    STATUS = (
        ('0', 'ready to send'),
        ('1', 'sending'),
        ('2', 'delivered'),
    )
    status = models.CharField(max_length=50, choices=STATUS, default='0')

    def __str__(self):
        return self.customer.username

    def total_price(self, discount_code):
        total_price = 0
        for item in self.items.all():
            total_price += item.product.price * item.quantity
        return total_price * discount_code


class OrderHistory(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    items = models.ManyToManyField(OrderItem)
    start_date = models.DateTimeField()
    ordered_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    total_price = models.PositiveIntegerField()
    class Meta:
        verbose_name_plural='OrderHistories'
