from django.db import models
from crypto.models import Asset


class Alert(models.Model):
    alert_value = models.FloatField(null=False)
    email = models.EmailField(null=False, max_length=254)
    currency = models.CharField(max_length=30)
    idA = models.ForeignKey(Asset, on_delete=models.CASCADE)

    class Meta:
        constraints = [
            models.CheckConstraint(
                name="crypto_alert_currency",
                check=models.Q(currency__in=('EUR', 'USD', 'PLN'))
            )
        ]



