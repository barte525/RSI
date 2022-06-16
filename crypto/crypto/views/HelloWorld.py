from django.http import HttpResponse
from crypto.models.Asset import Asset
from django.db.models import Q


def hello(request):
    return HttpResponse('Hello world')


def get_asset_price(request):
    name = request.GET.get('name', '')
    currency = request.GET.get('currency', '')
    if not name or not currency:
        return HttpResponse("Request does not contain all required query", status=400)
    asset = Asset.objects.get(name=name)
    return HttpResponse(getattr(asset, "converter" + currency))
