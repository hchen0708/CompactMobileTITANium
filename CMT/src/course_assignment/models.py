from __future__ import unicode_literals
from django.core.validators import MinValueValidator
from django.db import models
from student_accounts.models import MyUser
from courses.models import Course
from course_activities.models import Activity


# Create your models here.

class AssignmentManager(models.Manager):
    def add_assignment(self, user, path=None, content=None, course=None):
        if not path:
            raise ValueError("Path is missing")
        if not user:
            raise ValueError("Has to be a user")

        assignment = self.model(
            user=user,
            path=path,
            content=content,
        )
        if course is not None:
            activity.course = course
        assignment.save(using=self._db)
        return assignment


class Assignment(models.Model):
    user = models.ForeignKey(MyUser)
    path = models.CharField(max_length=350)
    course = models.ForeignKey(Course, null=True, blank=True)
    course_activity = models.ForeignKey(Activity, null=True, blank=True)
    title = models.CharField(max_length=350, blank=True)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now=False, auto_now_add=True)
    update = models.DateTimeField(auto_now=True, auto_now_add=False)

    objects = AssignmentManager()

    def __unicode__(self):
        return self.title


class GradeManager(models.Manager):
    def add_assignment(self, user, path=None, content=None, course=None):
        if not path:
            raise ValueError("Path is missing")
        if not user:
            raise ValueError("Has to be a user")

        grade = self.model(
            user=user,
            path=path,
            content=content,
        )
        if course is not None:
            activity.course = course
        grade.save(using=self._db)
        return grade


class Grade(models.Model):
    user = models.ForeignKey(MyUser)
    grade = models.FloatField(
        validators=[MinValueValidator(0.0)],
        default=0
    )
    range = models.FloatField(
        validators=[MinValueValidator(0.0)],
        default=0
    )
    percentage = models.FloatField(
        validators=[MinValueValidator(0.0)],
        default=0
    )
    course = models.ForeignKey(Course, null=True, blank=True)
    grade_item = models.ForeignKey(Assignment, null=True, blank=True)
    feedback = models.TextField()

    objects = AssignmentManager()

    def __unicode__(self):
        return self.user.username
        # Create your models here.

        # def assignment_filter(self):
        #     if assignment.course_activity == self.course_activity

        # @property
        # def get_assignment(self):
        #     return self.content
