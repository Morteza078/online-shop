from datetime import datetime

import pytz
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.views.decorators.http import require_POST

from customer.models import Customer
from orders.cart import Cart
from orders.forms import CartForm
from products.models import Product


@require_POST
def cart_add(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    form = CartForm(request.POST)
    if form.is_valid():
        form_data = form.cleaned_data
        cart.add(product=product,
                 product_count=form_data['product_count'],
                 update_count=form_data['update'])
    return redirect(reverse('orders:cart_detail'))


def cart_detail(request):
    cart = Cart(request)
    for item in cart:
        item['update_count_form'] = CartForm(initial={'product_count': item['product_count'],
                                                      'update': True})
    if request.user.id:
        customer = Customer.objects.get(id=request.user.id)
        return render(request, 'orders/cart_detail.html', {'cart': cart, 'customer': customer})
    return render(request, 'orders/cart_detail.html', {'cart': cart})


def cart_remove(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    cart.remove(product)
    return redirect(reverse('orders:cart_detail'))
