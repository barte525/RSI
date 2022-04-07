from urllib.request import urlopen
import json
from django.db import models
from crypto.settings import env
from django.db.models import Q

NOT_EXIST_ERROR = "Crypto with that name and currency does not exist"


class Asset(models.Model):
    class Meta:
        app_label = 'crypto'
        unique_together = (('name', 'currency'),)
    CRYPTO = 'crypto'
    CURRENCY = 'currency'
    METAL = 'metal'
    TYPES = [
        (CRYPTO, 'crypto'),
        (CURRENCY, 'currency'),
        (METAL, 'metal')
    ]
    name = models.CharField(max_length=30, null=False)
    currency = models.CharField(max_length=30)
    daily_diff = models.FloatField(default=0)
    type = models.CharField(choices=TYPES, max_length=30)
    basic_url = 'http://api.nomics.com/v1/currencies/ticker?key=' + env('API_KEY')

    def set_daily_change(self, name, currency_code):
        response = urlopen(self.basic_url + '&ids=' + name + '&convert=' + currency_code)
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