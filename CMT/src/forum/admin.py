from django.contrib import admin

# Register your models here.
from .models import Discussion


class CommentAdmin(admin.ModelAdmin):
    list_display = ['__unicode__', 'course']

    class Meta:
        model = Discussion


admin.site.register(Discussion, CommentAdmin)
