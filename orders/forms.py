from django import forms


class CartForm(forms.Form):
    product_count = forms.IntegerField()
    update = forms.BooleanField(required=False, initial=False, widget=forms.HiddenInput)
