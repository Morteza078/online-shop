from django.test import TestCase

# Create your tests here.
from customer.models import Customer


class TestLoginView(TestCase):
    def setUp(self):
        customer=Customer.objects.create(username='test_user', email='test@gmail.com',)
        customer.set_password('secret')
    def test_login(self):
        response = self.client.post('/en/customer/login/', {'username': 'morteza', 'password': 'secret'})
        self.assertEqual(response.status_code, 200)
