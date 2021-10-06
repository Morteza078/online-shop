from django.urls import path

from orders.cart_actions import cart_add, cart_detail, cart_remove
from orders.views import OrdersHistoryView, RecentOrdersView, order, checkout_order, payment, invoice

app_name = 'orders'

urlpatterns = [
    path('orders-history/', OrdersHistoryView.as_view(), name="orders-history"),
    path('recent-orders/', RecentOrdersView.as_view(), name="recent-orders"),
    path('add_to_cart/<int:product_id>/', cart_add, name="cart_add"),
    path('cart_detail/', cart_detail, name="cart_detail"),
    path('cart_remove/<int:product_id>/', cart_remove, name="cart_remove"),
    path('order/', order, name="order"),
    path('checkout_order/', checkout_order, name="checkout_order"),
    path('payment/<int:order_id>/', payment, name="payment"),
    path('invoice/<int:order_id>/', invoice, name="invoice"),

]
