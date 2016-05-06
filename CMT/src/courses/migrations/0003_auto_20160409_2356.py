# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-09 23:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0002_course_unit'),
    ]

    operations = [
        migrations.CreateModel(
            name='Semester',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('section', models.CharField(max_length=20)),
            ],
        ),
        migrations.AddField(
            model_name='course',
            name='lecturer',
            field=models.CharField(blank=True, max_length=40),
        ),
    ]