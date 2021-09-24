from rest_framework import serializers
from rest_framework.fields import SerializerMethodField

from products.models import Product, ProductImage
from parler_rest.fields import TranslatedFieldsField


class ImageProductSerializer(serializers.ModelSerializer):

    class Meta:
        model=ProductImage
        fields = ['image']


class ProductSerializer(serializers.ModelSerializer):
    images = ImageProductSerializer(read_only=True, many=True)

    class Meta:
        model = Product
        fields = '__all__'
