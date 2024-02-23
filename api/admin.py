import inspect

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from api import models

classes = [obj for _, obj in inspect.getmembers(models, inspect.isclass)]
admin.site.register(classes)
admin.site.unregister(models.User)


@admin.register(models.User)
class UserAdmin(BaseUserAdmin):
    list_display = (
        "username",
        "email",
        "is_active",
        "is_staff",
    )
    list_filter = ("is_active",)
    filter_horizontal = ()
    ordering = (
        "username",
        "email",
    )
    search_fields = (
        "username",
        "email",
    )

    fieldsets = (
        (None, {"fields": ("username", "email", "password")}),
        ("Permissions", {"fields": ("is_staff",)}),
    )

    add_fieldsets = ((None, {"classes": ("wide",), "fields": ("username", "email", "password1", "password2")}),)
