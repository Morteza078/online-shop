from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect

# Create your views here.
from django.urls import reverse
from django.views import View

from orders.models import OrderHistory, Order


class OrdersHistoryView(LoginRequiredMixin, View):
    """
    View for Customer See orders history
    """

    def get(self, request, *args, **kwargs):
        try:
            orders_history = OrderHistory.objects.filter(order__customer__id=request.user.id)
        except OrderHistory.DoesNotExist:
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
        except OrderHistory.DoesNotExist:
            return redirect(reverse("customer:login"))
        return render(request, "orders/recent_orders.html", {
            'recent_orders': recent_orders,
        })
