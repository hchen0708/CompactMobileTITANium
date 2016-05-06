from rest_framework import routers, serializers, viewsets, permissions
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from .models import Activity
from student_accounts.models import MyUser


class ActivitySerializer(serializers.HyperlinkedModelSerializer):
    # user = serializers.CharField(source=MyUser.objects.all())
    user = serializers.PrimaryKeyRelatedField(queryset=MyUser.objects.all())
    user_name = serializers.CharField(source="user.username")
    course_title = serializers.CharField(source="course.title")

    class Meta:
        model = Activity
        fields = [
            "url",
            "id",
            "user",
            "user_name",
            "course_title",
            "title",
            "content",
        ]


class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer
