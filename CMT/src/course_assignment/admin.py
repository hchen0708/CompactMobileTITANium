from django.contrib import admin

# Register your models here.
from .models import Assignment, Grade


class AssignmentAdmin(admin.ModelAdmin):
    list_display = ["title", "course"]
    list_filter = ["course"]

    class Meta:
        model = Assignment


class GradeAdmin(admin.ModelAdmin):
    list_display = ["grade_item", "course"]

    class Meta:
        model = Grade

admin.site.register(Assignment, AssignmentAdmin)
admin.site.register(Grade, GradeAdmin)