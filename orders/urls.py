from django.urls import path

from orders.views import OrdersHistoryView,RecentOrdersView

app_name = 'orders'

urlpatterns = [
    path('orders-history/', OrdersHistoryView.as_view(), name="orders-history"),
    path('recent-orders/', RecentOrdersView.as_view(), name="recent-orders"),

]
