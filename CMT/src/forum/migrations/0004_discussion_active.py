# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-14 02:32
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('forum', '0003_discussion_parent'),
    ]

    operations = [
        migrations.AddField(
            model_name='discussion',
            name='active',
            field=models.BooleanField(default=True),
        ),
    ]