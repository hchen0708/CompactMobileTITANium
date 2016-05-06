from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser


class MyUserManager(BaseUserManager):
    def create_user(self, username=None, email=None, password=None):
        if not username:
            raise ValueError('Please enter a preferred username')
        if not email:
            raise ValueError('Users must have an email address')

        user = self.model(
            username=username,
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, password):
        user = self.create_user(
            username=username,
            email=email,
            password=password,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class MyUser(AbstractBaseUser):
    username = models.CharField(
    max_length=255,
    unique=True,
    )
    email = models.EmailField(
    verbose_name='email address',
    max_length=255,
    unique=True,
    )
    first_name= models.CharField(
    max_length=120,
    null=True,
    blank=True,
    )
    last_name= models.CharField(
    max_length=120,
    null=True,
    blank=True,
    )

    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    cwid = models.IntegerField(blank=True, null=True)

    objects = MyUserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']

    def get_full_name(self):
        return '%s %s' %(self.first_name, last_name)

    def get_short_name(self):
        return self.first_name

    def __unicode__(self):              # __unicode__ on Python 2
        return self.email

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True

    @property
    def is_staff(self):
        return self.is_admin