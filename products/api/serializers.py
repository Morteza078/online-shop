from rest_framework import serializers

from products.models import Product, ProductImage


class ImageProductSerializer(serializers.ModelSerializer):

    class Meta:
        model=ProductImage
        fields = ['image']


class ProductSerializer(serializers.ModelSerializer):
    images = ImageProductSerializer(read_only=True, many=True)

    class Meta:
        model = Product
        fields = '__all__'
