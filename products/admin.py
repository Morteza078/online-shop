from django.contrib import admin

# Register your models here.
from .models import Product, Attribute, Category, ProductImage

admin.site.register(Attribute)
admin.site.register(Category)
admin.site.register(ProductImage)
admin.site.register(Product)
