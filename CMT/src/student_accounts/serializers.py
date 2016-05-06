from rest_framework import routers, serializers, viewsets, permissions
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from .models import MyUser


class MyUserSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = MyUser
		fields = [
			"url",
			"id",
			"username",
			"email",
			"first_name",
			"last_name",
			"is_active",
			"is_admin",
			'cwid',
		]


class MyUserViewSet(viewsets.ModelViewSet):
	queryset = MyUser.objects.all()
	serializer_class = MyUserSerializer

