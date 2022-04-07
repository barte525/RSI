from celery import shared_task
from crypto.models.Asset import Asset


@shared_task
def update_bitcoin_price_usd():
    asset = Asset()
    asset.set_daily_change('BTC', 'USD')


@shared_task
def update_bitcoin_price_pln():
    asset = Asset()
    asset.set_daily_change('BTC', 'PLN')


@shared_task
def update_bitcoin_price_eur():
    asset = Asset()
    asset.set_daily_change('BTC', 'EUR')
