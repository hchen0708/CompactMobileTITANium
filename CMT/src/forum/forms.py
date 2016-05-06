from django import forms

from .models import Discussion


class DiscussionForm(forms.Form):
    discussion = forms.CharField(widget=forms.Textarea)
