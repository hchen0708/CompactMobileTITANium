from __future__ import unicode_literals
from django.db import models

from django.core.urlresolvers import reverse
from student_accounts.models import MyUser
from courses.models import Course


# Create your models here.


class DiscussionManager(models.Manager):
    def all(self):
        return super(DiscussionManager, self).filter(parent=None)

    def add_discussion(self, user, path=None, content=None, course=None, parent=None):
        if not user:
            raise ValueError("Has to be a user")
        if not path:
            raise ValueError("Path is missing")

        discussion = self.model(
            user=user,
            path=path,
            content=content,
        )

        if course is not None:
            discussion.course = course
        if parent is not None:
            discussion.parent = parent

        discussion.save(using=self._db)
        return discussion


class Discussion(models.Model):
    user = models.ForeignKey(MyUser)
    parent = models.ForeignKey("self", null=True, blank=True)
    title = models.CharField(max_length=350, blank=True)
    path = models.CharField(max_length=350)
    course = models.ForeignKey(Course, null=True, blank=True)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now=False, auto_now_add=True)
    update = models.DateTimeField(auto_now=True, auto_now_add=False)
    # active = models.BooleanField(default=True)

    objects = DiscussionManager()

    class Meta:
        ordering = ['timestamp']

    def __unicode__(self):
        return self.user.username

    @property
    def get_origin(self):
        return self.path

    @property
    def get_discussion(self):
        return self.content

    @property
    def is_child(self):
        if self.parent is not None:
            return True
        else:
            return False

    def get_children(self):
        if self.is_child:
            return None
        else:
            return Discussion.objects.filter(parent=self)


    def get_absolute_url(self):
        return reverse('discussion_thread', kwargs={"id": self.id, "semester_slug": self.course.semester.slug,
                                                    "course_slug": self.course.slug})

    def get_forum_url(self):
        return reverse('discussion_list',
                       kwargs={"id": self.id, "semester_slug": self.course.semester.slug, "course_slug": self.course.slug})
