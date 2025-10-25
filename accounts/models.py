from django.db import models

# Create your models here.
from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser
from django.core.validators import EmailValidator
from django.contrib.auth.validators import UnicodeUsernameValidator

class CustomUserManager(BaseUserManager):
    def create_user(self, username, email, first_name, last_name, tc,phone=None,gender=None, dob=None, password=None):
        if not username:
            raise ValueError('The username must be set')
        if not email:
            raise ValueError('The email must be set')
        if not first_name:
            raise ValueError('The first_name must be set')
        if not last_name:
            raise ValueError('The last_name must be set')
        if not tc:
            raise ValueError('The terms and conditions must be done')

        email = self.normalize_email(email)
        username = self.model.normalize_username(username)
        user = self.model(username=username, email=email, first_name=first_name, last_name=last_name, phone=phone, gender=gender, dob=dob, tc=tc)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, username, email, first_name, last_name, tc, password=None):
        user = self.create_user(
            username=username, 
            email=email,
            first_name=first_name,
            last_name=last_name, 
            tc=tc, 
            password=password
            )
        user.is_admin = True
        user.save(using=self._db)
        return user

class CustomUser(AbstractBaseUser):
    username_validator = UnicodeUsernameValidator()

    username = models.CharField(
        'username',
        max_length=150, 
        help_text = ("Required. 150 characters or fewer. Letters, and digits only."),
        validators = [username_validator],
        unique=True,
         error_messages = {
            'unique': ("A user with that username already exists."),
        },
        )
    email = models.EmailField(validators=[EmailValidator()],unique=True)
    first_name = models.CharField( max_length=150, blank=True)
    last_name = models.CharField(max_length=150, blank=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    gender = models.CharField(max_length=10,null=True, blank=True)
    dob = models.DateField(blank=True, null=True)
    tc = models.BooleanField(default=False)

    following = models.ManyToManyField(
        'self',
        symmetrical=False,  # User A follows User B, but not necessarily vice versa
        related_name='followers',
        blank=True
    )
    
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email', 'first_name', 'last_name','tc']

    objects = CustomUserManager()

    def __str__(self):
        return self.username
    
    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin


class UserFcms(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    fcm = models.TextField(null=True, blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def get_fcm_token(self):
        return self.fcm

def user_image_directory_path(instance, filename):
    return f'{instance.user.username}_profile/{filename}'