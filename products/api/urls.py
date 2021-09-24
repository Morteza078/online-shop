from django.urls import path

from products.api.views import PaginationView

urlpatterns = [
    path('', PaginationView.as_view(), name='api-product-list'),
    # path('product-images', ProductImageView.as_view(), name='api-product-image'),
]