from rest_framework import routers, serializers, viewsets, permissions
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from courses.models import Course
from course_activities.models import Activity
from .models import Assignment, Grade
from student_accounts.models import MyUser


class AssignmentSerializer(serializers.HyperlinkedModelSerializer):
    # user = serializers.CharField(source=MyUser.objects.all())
    user = serializers.PrimaryKeyRelatedField(queryset=MyUser.objects.all())
    user_name = serializers.CharField(source="user.username")
    course_title = serializers.CharField(source="course.title")

    class Meta:
        model = Assignment
        fields = [
            "url",
            "id",
            "user",
            "user_name",
            "course_title",
            "course_activity",
            "title",
            "content",
            "timestamp",
            "update",
        ]


class AssignmentViewSet(viewsets.ModelViewSet):
    queryset = Assignment.objects.all()
    serializer_class = AssignmentSerializer


class GradeSerializer(serializers.HyperlinkedModelSerializer):

    user = serializers.PrimaryKeyRelatedField(queryset=MyUser.objects.all())
    course = serializers.PrimaryKeyRelatedField(queryset=Course.objects.all())
    course_title = serializers.CharField(source="course.title")
    # course_activity = serializers.PrimaryKeyRelatedField(queryset=Activity.objects.all())
    grade_item = serializers.CharField(source="grade_item.title")

    class Meta:
        model = Grade
        fields = [
            "url",
            "id",
            "user",
            "grade",
            "range",
            "percentage",
            "course",
            "course_title",
            "grade_item",
            "feedback",
        ]


class GradeViewSet(viewsets.ModelViewSet):
    queryset = Grade.objects.all()
    serializer_class = GradeSerializer
