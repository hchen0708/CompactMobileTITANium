# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-12 21:26
from __future__ import unicode_literals

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0022_semester_slug'),
    ]

    operations = [
        migrations.AlterField(
            model_name='semester',
            name='slug',
            field=models.SlugField(default=uuid.uuid1, unique=True),
        ),
    ]
