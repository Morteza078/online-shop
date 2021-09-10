from django.contrib import admin

# Register your models here.
from customer.models import Customer, Address, Staff,CustomUser

admin.site.register(Customer)
admin.site.register(Address)
admin.site.register(Staff)
admin.site.register(CustomUser)
