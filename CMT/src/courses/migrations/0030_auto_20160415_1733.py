# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-15 17:33
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0029_auto_20160415_1731'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='semester',
            options={},
        ),
        migrations.AddField(
            model_name='semester',
            name='is_active',
            field=models.BooleanField(default=False),
        ),
    ]
