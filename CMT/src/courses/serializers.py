from rest_framework import routers, serializers, viewsets, permissions
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from .models import Course, Semester
from forum.serializers import DiscussionSerializer


# Try to nested structure of Course in semester, discussion_set,

class SemesterSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Semester
        fields = [
            "url",
            "id",
            "section",
            "year",
            "slug",
            "active",

        ]


class SemesterViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, JSONWebTokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, ]
    queryset = Semester.objects.all()
    serializer_class = SemesterSerializer


class CourseSerializer(serializers.HyperlinkedModelSerializer):
    # semester = serializers.PrimaryKeyRelatedField(queryset=Semester.objects.all())
    semester = SemesterSerializer()
    discussion_set = DiscussionSerializer(many=True, read_only=True)
    semester_slug = serializers.CharField(source="semester.slug")

    class Meta:
        model = Course
        fields = [
            "url",
            "id",
            "title",
            "slug",
            "course_description",
            "lecturer",
            "course_code",
            "unit",
            "semester",
            "semester_slug",
            "discussion_set",
        ]


class CourseViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, JSONWebTokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, ]
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
