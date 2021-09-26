from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect, get_object_or_404

# Create your views here.
from django.utils.translation import activate
from django.views import View
from django.views.generic import DetailView

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
