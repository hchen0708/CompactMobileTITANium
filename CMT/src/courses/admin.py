from django.contrib import admin
from django.contrib.auth.models import Group

# Register your models here. 
from .models import Course, Semester


class CourseAdmin(admin.ModelAdmin):
    list_display = ["__unicode__", "slug"]
    prepopulated_fields = {'slug': ["title"]}

    class Meta:
        model = Course


admin.site.register(Course, CourseAdmin)
admin.site.register(Semester)

# Get rid of group section in admin.auth
admin.site.unregister(Group)
