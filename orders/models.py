# from django.core.validators import MinValueValidator, MaxValueValidator
# from django.db import models
# from random_words import RandomWords
# from products.models import Product
#
#
# # Create your models here.
#
#
def random_string():
    word = RandomWords()
    return word.random_word() + word.random_word() + word.random_word()
#
#
# class DiscountCode(models.Model):
#     code = models.CharField(max_length=100, unique=True, default=random_string)
#     valid_from = models.DateTimeField()
#     valid_to = models.DateTimeField()
#     active = models.BooleanField()
#     discount = models.IntegerField(validators=[MinValueValidator(0), MaxValueValidator(100)])
#
#     def __str__(self):
#         return self.code
#
#
# class OrderItem(models.Model):
#     user = models.ForeignKey(Customer, on_delete=models.CASCADE)
#     product = models.ForeignKey(Product, on_delete=models.CASCADE)
#     quantity = models.IntegerField(default=1)
#
#     def __str__(self):
#         return f'{self.quantity} of {self.product.name}'
#
#
# class Order(models.Model):
#     customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
#     items = models.ManyToManyField(OrderItem)
#     start_date = models.DateTimeField(auto_now_add=True)
#     ordered_date = models.DateTimeField()
#     STATUS = (
#         ('0', 'ready to send'),
#         ('1', 'sending'),
#         ('2', 'delivered'),
#     )
#     status = models.CharField(max_length=50, choices=STATUS, default='0')
#
#     def __str__(self):
#         return self.costumer.username
#
#     # def total_price(self):
#     #     return sum(
#     #         [(item.product.price) * (item.quantity) for item in self.items]) * self.customer.discountcode.discount
#
#
# class OrderHistory(models.Model):
#     customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
#     items = models.ManyToManyField(OrderItem)
#     start_date = models.DateTimeField()
#     ordered_date = models.DateTimeField()
#     status = models.CharField(max_length=50)
#     total_price = models.PositiveIntegerField()
