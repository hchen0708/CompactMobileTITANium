from __future__ import unicode_literals

from django.db import models

from student_accounts.models import MyUser
from courses.models import Course


# Create your models here.

class ActivityManager(models.Manager):
    def add_activity(self, user, path=None, content=None, course=None):
        if not path:
            raise ValueError("Path is missing")
        if not user:
            raise ValueError("Has to be a user")

        activity = self.model(
            user=user,
            path=path,
            content=content,
        )
        if course is not None:
            activity.course = course
        activity.save(using=self._db)
        return activity


class Activity(models.Model):
    user = models.ForeignKey(MyUser)
    path = models.CharField(max_length=350)
    course = models.ForeignKey(Course, null=True, blank=True)
    title = models.CharField(max_length=350, blank=True)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now=False, auto_now_add=True)
    update = models.DateTimeField(auto_now=True, auto_now_add=False)

    objects = ActivityManager()

    def __unicode__(self):
        return self.title

    @property
    def get_activity(self):
        return self.content
