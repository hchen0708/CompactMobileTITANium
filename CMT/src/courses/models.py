from __future__ import unicode_literals

import uuid

from django.db import models
from django.core.urlresolvers import reverse


# Create your models here.

class CourseQueryset(models.query.QuerySet):
    def currently_enrolled(self):
        return self.filter(currently_enrolled=True)


class CourseManager(models.Manager):
    def get_queryset(self):
        return CourseQueryset(self.model, using=self._db)

    def get_currently_enrolled(self):
        return self.get_queryset().currently_enrolled()


class Course(models.Model):
    title = models.CharField(max_length=120)
    course_code = models.CharField(max_length=20)
    unit = models.IntegerField(default=0)
    lecturer = models.CharField(max_length=40, blank=True)
    semester = models.ForeignKey("Semester", default=1)
    course_description = models.TextField(blank=True)
    currently_enrolled = models.BooleanField(default=True)
    slug = models.SlugField(unique=True, null=True, blank=True, max_length=120)

    objects = CourseManager()

    class Meta:
        unique_together = ('slug', 'semester')

    def __unicode__(self):
        return "%s - %s" % (self.course_code, self.title)

    def get_forum_url(self):
        return reverse('discussion_list', kwargs={"course_slug": self.slug, "semester_slug": self.semester.slug})

    def get_absolute_url(self):
        try:
            return reverse('course_detail', kwargs={"course_slug": self.slug, "semester_slug": self.semester.slug})
        except:
            return "/"


class Semester(models.Model):

    section = models.CharField(max_length=20)
    year = models.IntegerField(default=19)
    slug = models.SlugField(default='abc', unique=True)

    active = models.BooleanField(default=False, blank=True)

    def __unicode__(self):
        return "%s - %s" % (self.section, self.year)

    def is_active(self):
        if self.active:
            return self

    def get_absolute_url(self):
        return reverse('semester_detail', kwargs={"semester_slug": self.slug})
