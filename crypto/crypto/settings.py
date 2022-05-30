"""
Django settings for crypto project.

Generated by 'django-admin startproject' using Django 4.0.2.

For more information on this file, see
https://docs.djangoproject.com/en/4.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.0/ref/settings/
"""

from pathlib import Path
from celery.schedules import crontab

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}

import django
import os


INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django_celery_results',
    'crypto.apps.myAppNameConfig',
    'django_celery_beat',
]

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

import environ

env = environ.Env()
environ.Env.read_env()
SECRET_KEY = env('SECRET_KEY')


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
# Application definition



MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'crypto.urls'



WSGI_APPLICATION = 'crypto.wsgi.application'


# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases


# Password validation
# https://docs.djangoproject.com/en/4.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

timezone = 'Europe/London'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.0/howto/static-files/

STATIC_URL = 'static/'

# Default primary key field type
# https://docs.djangoproject.com/en/4.0/ref/settings/#default-auto-field

CELERY_BROKER_URL = "redis://127.0.0.1:6379/0"
CELERY_RESULT_BACKEND = 'django-db'
CELERY_BEAT_SCHEDULE = {
    "btc_usd": {
        "task": "crypto.tasks.update_bitcoin_price_usd",
        "schedule": crontab(minute='1,10,20,30,40,50', hour='*'),
    },
    "btc_pln": {
        "task": "crypto.tasks.update_bitcoin_price_pln",
        "schedule": crontab(minute='2,11,21,31,41,51', hour='*'),
    },
    "btc_eur": {
        "task": "crypto.tasks.update_bitcoin_price_eur",
        "schedule": crontab(minute='3,12,22,32,42,52', hour='*'),
    },
    "btc": {
        "task": "crypto.tasks.update_bitcoin_price_on_server",
        "schedule": crontab(minute='4,13,23,33,43,53', hour='*'),
    },
    "eth_usd": {
        "task": "crypto.tasks.update_eth_price_usd",
        "schedule": crontab(minute='5,14,24,34,44,54', hour='*'),
    },
    "eth_pln": {
        "task": "crypto.tasks.update_eth_price_pln",
        "schedule": crontab(minute='6,15,25,35,45,55', hour='*'),
    },
    "eth_eur": {
        "task": "crypto.tasks.update_eth_price_eur",
        "schedule": crontab(minute='7,16,26,36,46,56', hour='*'),
    },
    "eth": {
        "task": "crypto.tasks.update_eth_price_on_server",
        "schedule": crontab(minute='8,17,27,37,47,57', hour='*'),
    },
}

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
django.setup()