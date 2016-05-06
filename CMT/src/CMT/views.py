from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, HttpResponseRedirect
from django.contrib.auth.decorators import login_required

##
from courses.models import Course, Semester


# @login_required()
def home(request):
    courses = Course.objects.get_currently_enrolled()
    semesters = Semester.objects.all()
    context = {
        "courses": courses,
        "semesters": semesters
    }
    return render(request, "home.html", context)


def semester(request):
    semesters = Semester.objects.all()
    context = {
        "semesters": semesters
    }
    return render(request, "semester.html", context)


@login_required(login_url="/faculty/login/")
def faculty_home(request):
    context = {

    }

    return render(request, "home.html", context)
