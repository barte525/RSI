from rest_framework.views import APIView
from django.http import HttpResponse
from crypto.models.Alert import Alert
from crypto.models.Asset import Asset
import json
from django.db.utils import IntegrityError


class AlertView(APIView):
    def post(self, request):
        json_data = json.loads(request.body)
        email = json_data.get('email', '')
        currency = json_data.get('currency', '')
        value = json_data.get('value', '')
        asset_name = json_data.get('asset_name')
        if not email or not currency or not value or not asset_name:
            return HttpResponse("Request does not contain all required query", status=400)
        asset = Asset.objects.filter(name=asset_name)
        if len(asset) == 0:
            return HttpResponse("Asset with this name does not exist", status=400)
        idA = asset[0]
        try:
            Alert(alert_value=value, email=email, idA=idA, currency=currency).save()
        except IntegrityError:
            return HttpResponse("Currency must be: EUR/PLN/USD", status=400)
        return HttpResponse("Alert created", status=200)
