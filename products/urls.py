from django.urls import path

from products.views import index

app_name = 'products'

urlpatterns = [
    path('', index, name='index'),
    # path('create/', create_or_update, name='create'),
    # path('update/<int:event_id>/', create_or_update, name='update'),
    # path('user-events/', user_event, name='user-events'),
]