from django.shortcuts import render, Http404
from django.contrib.auth.decorators import login_required
# Create your views here.
from .models import Course, Semester
from course_activities.models import Activity
from course_assignment.models import Assignment


@login_required
def course_detail(request, semester_slug, course_slug):
    try:
        semester = Semester.objects.get(slug=semester_slug)
    except:
        raise Http404
    try:
        course = Course.objects.get(slug=course_slug)
        activities = Activity.objects.filter(course=course)
        assignments = Assignment.objects.filter(course=course)

        return render(request, 'courses/course_detail.html',
                      {"course": course, "activities": activities, "assignments": assignments})
    except:
        raise Http404


def semester_list(request):
    queryset = Semester.objects.all()

    context = {
        'queryset': queryset,
    }

    return render(request, 'courses/semester_list.html', context)


@login_required
def semester_detail(request, semester_slug):
    path = request.get_full_path()
    activities = Activity.objects.filter(path=path)

    try:
        semester = Semester.objects.get(slug=semester_slug)
        queryset = semester.course_set.all()
        return render(request,
                      'courses/semester_detail.html', {"semester": semester,
                                                       "queryset": queryset
                                                       })
    except:
        raise Http404
