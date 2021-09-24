from django.urls import path

from products.views import IndexView, product_by_category

app_name = 'products'

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('category_product/<int:pk>/', product_by_category, name='product_category'),

]
