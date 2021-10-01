from django import template

from products.models import Category

register = template.Library()


@register.simple_tag
def title():
    return 'weblog'


@register.inclusion_tag('products/category.html')
def category():
    return {'categories': Category.objects.all()}


@register.simple_tag
def total_price(final_price, discount):
    return float((100*final_price)/(100-discount))
