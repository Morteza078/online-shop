from django.test import  TestCase
from django.urls import reverse


class HomeTests(TestCase):
    def test_cart_detail_view_status_code(self):
        url = reverse('orders:cart_detail')
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)
