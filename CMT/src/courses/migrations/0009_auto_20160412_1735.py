# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-12 17:35
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0008_auto_20160410_0040'),
    ]

    operations = [
        migrations.CreateModel(
            name='CourseManager',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
            ],
        ),
        migrations.AddField(
            model_name='course',
            name='enrolled',
            field=models.BooleanField(default=False),
        ),
    ]
