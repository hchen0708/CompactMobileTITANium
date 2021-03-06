# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-26 15:50
from __future__ import unicode_literals

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('course_assignment', '0005_auto_20160426_1417'),
    ]

    operations = [
        migrations.AlterField(
            model_name='grade',
            name='grade',
            field=models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0.0)]),
        ),
        migrations.AlterField(
            model_name='grade',
            name='percentage',
            field=models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0.0)]),
        ),
        migrations.AlterField(
            model_name='grade',
            name='range',
            field=models.FloatField(default=0, validators=[django.core.validators.MinValueValidator(0.0)]),
        ),
    ]
