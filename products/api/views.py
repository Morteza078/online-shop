from rest_framework import generics
from rest_framework.pagination import PageNumberPagination

from products.api.serializers import ProductSerializer
from products.models import Product, ProductImage


# class ProductImageView(generics.ListAPIView):
#     queryset = ProductImage.objects.all()
#     serializer_class = ProductSerializer


class LargeResultsSetPagination(PageNumberPagination):
    page_size = 8
    page_size_query_param = 'page_size'
    max_page_size = 8


class PaginationView(generics.ListAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    pagination_class = LargeResultsSetPagination
