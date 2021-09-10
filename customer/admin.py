from django.contrib import admin

# Register your models here.
from customer.models import Customer,Address,DiscountCode

admin.site.register(Customer)
admin.site.register(Address)
admin.site.register(DiscountCode)
