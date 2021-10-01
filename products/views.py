from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect, get_object_or_404

# Create your views here.
from django.urls import reverse
from django.utils.translation import activate
from django.views import View
from django.views.generic import DetailView

from orders.forms import CartForm
from products.models import Product, Advertising, Category


def change_lang(request):
    if request.method == "GET":
        activate(request.GET.get('lang'))
        return redirect(request.GET.get('next'))


class IndexView(View):
    def get(self, request, *args, **kwargs):
        products = Product.objects.all()
        advertisings = Advertising.objects.all()
        context = {'advertisings': advertisings, 'products': products}
        return render(request, "products/index.html", context)


def product_by_category(request, pk):
    category = get_object_or_404(Category, pk=pk)
    return render(request, 'products/category_products.html', context={'category': category})


# class ProductDetailView(DetailView):
#     """
#         View for Customers See Product Detials and buy it
#         """
#     model = Product

class ProductDetailView(View):
    """
     View for Customers See Product Detials and buy it
    """

    def get(self, request, pk, *args, **kwargs):
        try:
            product = Product.objects.get(id=pk)
            form = CartForm()
        except Product.DoesNotExist:
            return redirect(reverse("products:index"))
        return render(request, "products/product_detail.html", {
            'product': product, 'form': form
        })
