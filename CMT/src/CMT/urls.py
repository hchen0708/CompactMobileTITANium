"""CMT URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""


from django.conf.urls import url, patterns, include
from django.contrib import admin
from rest_framework import routers

from rest_framework_jwt.views import obtain_jwt_token

# importing views from different app
from . import views
from courses import views as courses_views
from forum import views as forum_views
from student_accounts import views as student_accounts_views

from courses.serializers import CourseViewSet, SemesterViewSet
from forum.serializers import DiscussionViewSet
from course_activities.serializers import ActivityViewSet
from student_accounts.serializers import MyUserViewSet
from course_assignment.serializers import AssignmentViewSet, GradeViewSet

router = routers.DefaultRouter()
router.register(r"courses", CourseViewSet)
router.register(r"semesters", SemesterViewSet)
router.register(r"discussions", DiscussionViewSet)
router.register(r"course_activities", ActivityViewSet)

router.register(r"student_accounts", MyUserViewSet)
router.register(r"course_assignments", AssignmentViewSet)
router.register(r"course_grade", GradeViewSet)

urlpatterns = patterns("",
    url(r'^admin/', admin.site.urls),
    url(r'^$', views.home, name='home'),
    url(r'^faculty/$', views.faculty_home, name='faculty'),
    url(r'^semester/$', courses_views.semester_list, name='semester_list'),
    url(r'^semester/(?P<semester_slug>[\w-]+)/$', courses_views.semester_detail, name='semester_detail'),
    url(r'^semester/(?P<semester_slug>[\w-]+)/(?P<course_slug>[\w-]+)$', courses_views.course_detail, name='course_detail'),

    )

# auth login/logout
urlpatterns += (
    url(r'^login/$', student_accounts_views.auth_login, name='login'),
    url(r'^logout/$', student_accounts_views.auth_logout, name='logout'),

    )
# forum thread
urlpatterns += [
    # url(r'^forum/$', forum_views.discussion_list, name='discussion_list'),
    # url(r'^forum/(?P<id>\d+)$', forum_views.discussion_thread, name='discussion_thread'),
    # url(r'^forum/create/$', forum_views.discussion_create_view, name='discussion_create'),

    url(r'^semester/(?P<semester_slug>[\w-]+)/(?P<course_slug>[\w-]+)/forum/$', forum_views.discussion_list,
        name='discussion_list'),

    url(r'^semester/(?P<semester_slug>[\w-]+)/(?P<course_slug>[\w-]+)/forum/(?P<id>\d+)$',
        forum_views.discussion_thread, name='discussion_thread'),
    # url(r'^semester/(?P<semester_slug>[\w-]+)/(?P<course_slug>[\w-]+)/forum/(?P<id>\d+)/create/$',
    # forum_views.discussion_create_view, name='discussion_create'),

]

# api_related
urlpatterns += (
    url(r'^api-token-auth/', obtain_jwt_token),
    url(r'^api/auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^api/', include(router.urls)),

    )




