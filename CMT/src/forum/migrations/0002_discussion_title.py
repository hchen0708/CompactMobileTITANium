# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-13 17:57
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('forum', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='discussion',
            name='title',
            field=models.CharField(blank=True, max_length=350),
        ),
    ]
