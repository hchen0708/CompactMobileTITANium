# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-12 17:50
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0009_auto_20160412_1735'),
    ]

    operations = [
        migrations.DeleteModel(
            name='CourseManager',
        ),
        migrations.AlterField(
            model_name='course',
            name='enrolled',
            field=models.BooleanField(default=True),
        ),
    ]
