# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-12 20:59
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0018_remove_semester_slug'),
    ]

    operations = [
        migrations.AddField(
            model_name='semester',
            name='slug',
            field=models.SlugField(blank=True),
        ),
    ]
