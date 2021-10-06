from datetime import datetime

import pytz
from rest_framework import generics, status
from rest_framework.response import Response
from django.utils.translation import gettext_lazy as _
from customer.models import Customer
from orders.api.serializers import DiscountCodeSerializer
from orders.cart import Cart
from products.models import Product


class DiscountCodeView(generics.GenericAPIView):
    serializer_class = DiscountCodeSerializer

    def post(self, request):
        code = request.data['code']
        cart = Cart(request)
        user_id = request.data['user_id']
        if not Customer.objects.get(id=user_id):
            return Response({'error': _('user_id does not exist')}, status=status.HTTP_400_BAD_REQUEST)
        customer = Customer.objects.get(id=user_id)
        for code_user in customer.codes.all():
            now = pytz.utc.localize(datetime.now())
            if code == str(code_user) and now < code_user.valid_to:
                final_price = cart.get_cart_total_price(code_user.discount)
                request.session['discount_code'] = code_user.id
                data = {
                    'final_price': final_price,
                    'discount': code_user.discount
                }
                return Response(data, status=status.HTTP_200_OK)
        return Response({'error': _('Discount code is not valid')}, status=status.HTTP_400_BAD_REQUEST)
