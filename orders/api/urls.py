from django.urls import path

from orders.api.views import DiscountCodeView

urlpatterns = [
    path('discount-code', DiscountCodeView.as_view(), name='discount-code'),
]
