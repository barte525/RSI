from urllib.request import urlopen
import json
import requests
from django.db import models
from crypto.settings import env
from django.db.models import Q
from django.db.utils import IntegrityError
NOT_EXIST_ERROR = "Crypto with that name and currency does not exist"


class Asset(models.Model):
    class Meta:
        app_label = 'crypto'
        constraints = [
            models.CheckConstraint(
                name="crypto_asset_type",
                check=models.Q(asset_type__in=('crypto', 'currency', 'metal'))
            )
        ]
    name = models.CharField(max_length=30, null=False, unique=True)
    converterPLN = models.FloatField(default=0)
    converterEUR = models.FloatField(default=0)
    converterUSD = models.FloatField(default=0)
    guidA = models.CharField(max_length=40, unique=True)
    asset_type = models.CharField(max_length=30)

    crypto_url = 'http://api.nomics.com/v1/currencies/ticker?key=' + env('API_KEY')
    server_url = 'https://localhost:44378/api/Asset/'

    @staticmethod
    def seed_dev_data():
        Asset.save_asset(guidA="3fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="crypto", name="BTC",
                         converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)
        Asset.save_asset(guidA="4fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="crypto", name="ETH",
                         converterEUR=10, converterPLN=50, converterUSD=11)
        Asset.save_asset(guidA="5fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="metal", name="GOLD",
                         converterEUR=120, converterPLN=600, converterUSD=130)
        Asset.save_asset(guidA="6fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="metal", name="SILVER",
                         converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)
        Asset.save_asset(guidA="7fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="PLN",
                         converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)
        Asset.save_asset(guidA="8fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="USD",
                         converterEUR=10, converterPLN=50, converterUSD=11)
        Asset.save_asset(guidA="9fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="EUR",
                         converterEUR=120, converterPLN=600, converterUSD=130)
        Asset.save_asset(guidA="2fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="GBP",
                         converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)

    @staticmethod
    def save_asset(guidA, asset_type, name, converterEUR, converterPLN, converterUSD):
        try:
            Asset(guidA=guidA, asset_type=asset_type, name=name, converterEUR=converterEUR,
                  converterPLN=converterPLN, converterUSD=converterUSD).save()
        except IntegrityError:
            return

    def set_daily_change(self, name, currency_code):
        response = urlopen(self.crypto_url + '&ids=' + name + '&convert=' + currency_code)
        data_table = json.loads(response.read())
        if not data_table:
            return NOT_EXIST_ERROR
        try:
            crypto = Asset.objects.get(Q(currency=currency_code) & Q(name=name))
        except Asset.DoesNotExist:
            crypto = Asset(name=name, currency=currency_code)
        data_json = data_table[0]
        crypto.daily_diff = data_json['1d']['price_change']
        crypto.save()

    @staticmethod
    def get_daily_change(name, currency_code):
        try:
            crypto = Asset.objects.get(Q(name=name) & Q(currency=currency_code))
        except Asset.DoesNotExist:
            return NOT_EXIST_ERROR
        return crypto.daily_diff

    def update_asset_in_server(self, name):
        try:
            asset = Asset.objects.get(name=name)
        except Asset.DoesNotExist:
            return NOT_EXIST_ERROR
        json_data = {
            "id": asset.guidA,
            "type": asset.asset_type,
            "name": name,
            "converterPLN": asset.converterPLN,
            "converterEUR": asset.converterEUR,
            "converterUSD": asset.converterUSD
        }
        response = requests.put(self.server_url+asset.guidA, json=json_data, verify=False)
        return response

