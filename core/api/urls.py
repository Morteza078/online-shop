from django.urls import path, include

urlpatterns = [
    path('customer/', include('customer.api.urls')),
    path('products/', include('products.api.urls')),
    path('orders/', include('orders.api.urls')),
    path('auth/', include('rest_framework.urls')),
]

