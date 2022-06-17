from urllib.request import urlopen
import json
import requests
from django.db import models
from crypto.settings import env
from django.db.utils import IntegrityError
NOT_EXIST_ERROR = "Crypto with that name and currency does not exist in database"
EXTERNAL_API_ERROR = "External api did not send correct response"
NOT_EXIST_API_ERROR = "Crypto with that name and currency does not exist in external API"


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
    currency_url = 'https://api.exchangerate.host/convert?from={}&to={}'
    metal_url = 'https://api.metals.live/v1/spot'
    server_url = 'https://3798-188-26-199-50.eu.ngrok.io/api/Asset/'

    @staticmethod
    def seed_dev_data():
        Asset.create_asset(guidA="3fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="crypto", name="BTC",
                           converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)
        Asset.create_asset(guidA="4fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="crypto", name="ETH",
                           converterEUR=10, converterPLN=50, converterUSD=11)
        Asset.create_asset(guidA="5fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="metal", name="GOLD",
                           converterEUR=120, converterPLN=600, converterUSD=130)
        Asset.create_asset(guidA="6fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="metal", name="SILVER",
                           converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)
        Asset.create_asset(guidA="7fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="PLN",
                           converterEUR=100000.25, converterPLN=1, converterUSD=110000.25)
        Asset.create_asset(guidA="8fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="USD",
                           converterEUR=10, converterPLN=50, converterUSD=1)
        Asset.create_asset(guidA="9fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="EUR",
                           converterEUR=1, converterPLN=600, converterUSD=130)
        Asset.create_asset(guidA="2fa85f64-5717-4562-b3fc-2c963f66afa9", asset_type="currency", name="GBP",
                           converterEUR=100000.25, converterPLN=500000.25, converterUSD=110000.25)

    @staticmethod
    def create_asset(guidA, asset_type, name, converterEUR, converterPLN, converterUSD):
        try:
            Asset(guidA=guidA, asset_type=asset_type, name=name, converterEUR=converterEUR,
                  converterPLN=converterPLN, converterUSD=converterUSD).save()
        except IntegrityError:
            return

    def update_asset_price(self, name, currency_code):
        try:
            asset = Asset.objects.get(name=name)
        except Asset.DoesNotExist:
            return NOT_EXIST_ERROR
        if asset.asset_type == 'crypto':
            price = self.get_new_crypto_price(name, currency_code=currency_code)
        elif asset.asset_type == 'metal':
            price = self.get_new_metal_price(name, currency_code)
        elif asset.asset_type == 'currency':
            price = self.get_new_currency_price(name, currency_code)
        else:
            price = NOT_EXIST_ERROR
        if price != EXTERNAL_API_ERROR and price != NOT_EXIST_ERROR:
            self.set_asset_price(asset, currency_code, price)

    @staticmethod
    def set_asset_price(asset, currency_code, price):
        from crypto.models.Alert import Alert
        if currency_code == 'EUR':
            asset.converterEUR = price
        if currency_code == 'PLN':
            asset.converterPLN = price
        if currency_code == 'USD':
            asset.converterUSD = price
        asset.save()
        Alert().check_alert(asset, currency_code)

    def get_new_crypto_price(self, name, currency_code):
        response = urlopen(self.crypto_url + '&ids=' + name + '&convert=' + currency_code)
        if response.status != 200:
            return EXTERNAL_API_ERROR #add logging later
        data_table = json.loads(response.read())
        if not data_table:
            return NOT_EXIST_API_ERROR #add logging later
        return float(data_table[0]['price'])

    def get_new_metal_price(self, name, currency_code):
        name = name.lower()
        resp = requests.get(self.metal_url, verify=False)
        if resp.status_code != 200:
            return EXTERNAL_API_ERROR
        data_table = json.loads(resp.text)
        usd_price = 0
        for data in data_table:
            if data.get(name, '') != '':
                usd_price = data[name]
        currency_usd_ratio = getattr(Asset.objects.get(name='USD'), 'converter' + currency_code)
        return float(usd_price) * float(currency_usd_ratio)

    def get_new_currency_price(self, name, currency_code):
        response = urlopen(self.currency_url.format(name, currency_code))
        if response.status != 200:
            return EXTERNAL_API_ERROR
        data_table = json.loads(response.read())
        if not data_table:
            return NOT_EXIST_API_ERROR
        return float(data_table['info']['rate'])

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
        response = requests.put(self.server_url + asset.guidA, json=json_data, verify=False)
        return response

