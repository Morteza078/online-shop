from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect

# Create your views here.
from django.utils.translation import activate

def index(request):
    return render(request, 'products/index.html')


def change_lang(request):
    if request.method == "GET":
        print('in change_lang')
        activate(request.GET.get('lang'))
        return redirect(request.GET.get('next'))
