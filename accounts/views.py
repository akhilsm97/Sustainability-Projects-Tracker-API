from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from accounts.serializers import *
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from accounts.renderers import UserRenderer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import AllowAny,IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.contrib.auth import authenticate,login,logout
from accounts.paginations import CustomPagination
from django.db.models import Q



class RegistrationView(APIView):
    renderer_classes = [UserRenderer]
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = UserCreateSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            refresh_token = str(refresh)
            return Response({'status': 'success','message': 'User created Successfully', 'access_token': access_token, 'refresh_token': refresh_token, 'data': serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class LoginView(APIView):
    renderer_classes = [UserRenderer]
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.data['username']
        password = request.data['password']
        fcm = request.data.get('fcm')
        try:
            user = authenticate(request, username=username, password=password)
            # print(user,'user**********')
            if user is not None:
                user_fcm, created = UserFcms.objects.get_or_create(user=user)
                user_fcm.fcm = fcm
                user_fcm.save()
                refresh = RefreshToken.for_user(user)
                access_token = str(refresh.access_token)
                refresh_token = str(refresh)
                return Response({'status': 'success','message': 'Login successfully', 'access_token': access_token, 'refresh_token': refresh_token}, status=status.HTTP_200_OK)
            else:
                return Response({'status': 'error','message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        except Exception as e:
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

class LogoutView(APIView):
    renderer_classes = [UserRenderer]
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def post(self, request):
        # print(request.data,'data*********')
        try:
            refresh_token = request.data['refresh_token']
            user_fcm = UserFcms.objects.filter(user=request.user).first()
            if user_fcm:
                user_fcm.delete()
            token = RefreshToken(refresh_token)
            token.blacklist()
            
            return Response({'status': 'success','message': 'Logout successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'status': 'error','message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
