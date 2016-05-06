from django.contrib import admin

# Register your models here.
from .models import Activity


class ActivityAdmin(admin.ModelAdmin):
    list_display = ["title", "course"]
    list_filter = ["course"]

    class Meta:
        model = Activity


admin.site.register(Activity, ActivityAdmin)