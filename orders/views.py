from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.urls import reverse
from django.views import View

from customer.models import Customer, Address
from orders.cart import Cart
from orders.forms import CartForm
from orders.models import Order, OrderItem
from products.models import Product


class OrdersHistoryView(LoginRequiredMixin, View):
    """
    View for Customer See orders history
    """

    def get(self, request, *args, **kwargs):
        try:
            orders_history = Order.objects.filter(customer__id=request.user.id)
        except Order.DoesNotExist:
            return redirect(reverse("customer:login"))
        return render(request, "orders/orders_history.html", {
            'orders_history': orders_history,
        })


class RecentOrdersView(LoginRequiredMixin, View):
    """
    View for Customer See orders history
    """

    def get(self, request, *args, **kwargs):
        try:
            recent_orders = Order.objects.filter(customer__id=request.user.id)[0:10]
        except Order.DoesNotExist:
            return redirect(reverse("customer:login"))
        return render(request, "orders/recent_orders.html", {
            'recent_orders': recent_orders,
        })


@login_required
def order(request):
    cart = Cart(request)
    for item in cart:
        item['update_count_form'] = CartForm(initial={'product_count': item['product_count'],
                                                      'update': True})
    customer = Customer.objects.get(id=request.user.id)
    return render(request, 'orders/cart_detail.html', {'cart': cart, 'customer': customer})


@login_required
def checkout_order(request):
    cart = Cart(request)
    if len(cart.cart) != 0:
        if 'discount' in request.session.keys():
            discount = request.session['discount']
            final_price = cart.get_cart_total_price(discount)
            del request.session['discount']

        else:
            discount = 0
            final_price = cart.get_cart_total_price()

        if request.method == 'POST':
            customer = Customer.objects.get(id=request.user.id)
            address = Address.objects.get(id=request.POST['order_address'])
            order = Order.objects.create(customer=customer, discount=discount, final_price=final_price,
                                         address=address)
            for item in cart:
                order.items.add(OrderItem.objects.create(product=item['product'],
                                                         quantity=item['product_count']
                                                         ))
        del request.session['cart']
        return render(request, 'orders/invoice.html', {'order': order})
    return render(request, 'orders/empty_cart.html')
