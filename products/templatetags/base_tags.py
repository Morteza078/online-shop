from django import template

from products.models import Category

register = template.Library()


@register.simple_tag
def title():
    return 'weblog'


@register.inclusion_tag('products/category.html')
def category():
    return {'categories': Category.objects.all()}
