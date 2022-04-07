from django.db import models


class User(models.Model):
    email = models.CharField(max_length=30, primary_key=True)


class Alert(models.Model):
    user = models.ForeignKey(User, db_index=True, on_delete=models.CASCADE)
    asset_name = models.CharField(max_length=30, null=False, db_index=True)
    percent = models.FloatField(null=False, db_index=True)



