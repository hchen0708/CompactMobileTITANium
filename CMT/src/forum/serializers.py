from rest_framework import routers, serializers, viewsets, permissions
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from .models import Discussion
from student_accounts.models import MyUser


class ChildDiscussionSerializer(serializers.HyperlinkedModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=MyUser.objects.all())

    class Meta:
        model = Discussion
        fields = [

            "id",
            "user",
            "title",
            "path",
            "content",

        ]


class DiscussionSerializer(serializers.HyperlinkedModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=MyUser.objects.all())
    user_name = serializers.CharField(source="user.username")
    # Serializer Method Field
    children = serializers.SerializerMethodField(read_only=True)

    def get_children(self, instance):
        queryset = instance.get_children()
        serializer = ChildDiscussionSerializer(queryset, context={"request": instance}, many=True)
        return serializer.data

    class Meta:
        model = Discussion
        fields = [
            "url",
            "id",
            "children",
            "user",
            "user_name",
            "title",
            "path",
            "content",


        ]


class DiscussionViewSet(viewsets.ModelViewSet):
    queryset = Discussion.objects.all()
    serializer_class = DiscussionSerializer
