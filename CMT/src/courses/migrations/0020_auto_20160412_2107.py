# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-12 21:07
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0019_semester_slug'),
    ]

    operations = [
        migrations.AlterField(
            model_name='semester',
            name='slug',
            field=models.SlugField(default='abc', unique=True),
        ),
    ]