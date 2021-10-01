from django.contrib import admin
from orders.models import OrderItem, Order, DiscountCode

# Register your models here.

admin.site.register(OrderItem)
admin.site.register(Order)
admin.site.register(DiscountCode)
