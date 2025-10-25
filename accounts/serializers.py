import os
import re
from rest_framework import serializers
from .models import *


class UserCreateSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input_type': 'password'}, write_only=True)
    fcm = serializers.CharField(max_length=255, required=False, write_only=True)

    class Meta:
        model = CustomUser
        fields = [
            'id', 'username', 'email', 'first_name', 'last_name',
            'phone', 'gender', 'dob', 'tc', 'password', 'password2', 'fcm'
        ]

    def validate(self, data):
        if CustomUser.objects.filter(username=data['username']).exists():
            raise serializers.ValidationError("Username already exists")
        if CustomUser.objects.filter(email=data['email']).exists():
            raise serializers.ValidationError("Email already exists")
        if len(data['username']) < 8:
            raise serializers.ValidationError("Username must be at least 8 characters")
        if not re.match('^[a-zA-Z0-9_]+$', data['username']):
            raise serializers.ValidationError("Username should only contain alphabets, numbers, and _")
        if data['password'] != data['password2']:
            raise serializers.ValidationError("Passwords didn't match")
        return data

    def create(self, validated_data):
        fcm = validated_data.pop('fcm', None)  # remove fcm so CustomUser doesn't see it
        validated_data.pop('password2')
        user = CustomUser.objects.create_user(**validated_data)

        # If FCM provided, save it to UserFcms
        if fcm:
            UserFcms.objects.create(user=user, fcm=fcm)

        return user

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        representation.pop('password', None)
        representation.pop('fcm', None)  # prevent trying to read `instance.fcm`
        return representation

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id','username', 'email', 'first_name', 'last_name', 'phone', 'gender', 'dob', 'tc']
        
class ResetPasswordSerializer(serializers.ModelSerializer):
    current_password = serializers.CharField(style={'input_type': 'password'}, write_only=True)
    confirm_password = serializers.CharField(style={'input_type': 'password'}, write_only=True)
    new_password = serializers.CharField(style={'input_type': 'password'}, write_only=True)
    class Meta:
        model = CustomUser
        fields = ['id','current_password','new_password','confirm_password']

    def validate(self,data):
        current_password = data.get('current_password')
        confirm_password = data.get('confirm_password')
        new_password = data.get('new_password')
        if not self.instance.check_password(current_password):
            raise serializers.ValidationError("Current password is incorrect")
        if current_password == confirm_password:
            raise serializers.ValidationError("New password cannot be the same as current password")
        if confirm_password != new_password:
            raise serializers.ValidationError("New password and confirm password do not match")
        return data

    def update(self, instance, validated_data):
        instance.set_password(validated_data['new_password'])
        instance.save()
        return instance        