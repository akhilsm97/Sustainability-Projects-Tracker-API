# from django.shortcuts import render

# # Create your views here.
# from rest_framework import viewsets, filters
# from django_filters.rest_framework import DjangoFilterBackend
# from .models import Project, Task, Contributor
# from .serializers import ProjectSerializer, TaskSerializer, ContributorSerializer
# from rest_framework.decorators import action
# from rest_framework.response import Response
# from django.utils import timezone
# from django.views.decorators.cache import cache_page
# from django.utils.decorators import method_decorator
# from django.core.cache import cache
# from rest_framework.permissions import IsAuthenticated

# @method_decorator(cache_page(60*5), name='list')  # cache list view for 5 minutes
# class ProjectViewSet(viewsets.ModelViewSet):
#     queryset = Project.objects.all().order_by('-created_at')
#     serializer_class = ProjectSerializer
#     permission_classes = [IsAuthenticated]
#     filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
#     filterset_fields = ['status']
#     search_fields = ['name','description','location']
#     ordering_fields = ['created_at','updated_at']
    
#     def perform_create(self, serializer):
#         serializer.save()
#         cache.clear()  # Clear cache when data changes

#     def perform_update(self, serializer):
#         serializer.save()
#         cache.clear()

#     def perform_destroy(self, instance):
#         instance.delete()
#         cache.clear()

# class ContributorViewSet(viewsets.ModelViewSet):
#     queryset = Contributor.objects.all()
#     serializer_class = ContributorSerializer
#     permission_classes = [IsAuthenticated]
#     search_fields = ['name','email','skills']
    
    
# @method_decorator(cache_page(60 * 5), name='list')
# class TaskViewSet(viewsets.ModelViewSet):
#     queryset = Task.objects.all().select_related('project').prefetch_related('contributors')
#     serializer_class = TaskSerializer
#     permission_classes = [IsAuthenticated]
#     filter_backends = [DjangoFilterBackend, filters.SearchFilter]
#     filterset_fields = ['is_completed','project','contributors']
#     search_fields = ['title','description']
    
#     def perform_create(self, serializer):
#         serializer.save()
#         cache.clear()

#     def perform_update(self, serializer):
#         serializer.save()
#         cache.clear()

#     def perform_destroy(self, instance):
#         instance.delete()
#         cache.clear()

#     @action(detail=False, methods=['get'])
#     def overdue(self, request):
#         today = timezone.now().date()
#         cache_key = f"overdue_tasks_{today}"

#         cached_data = cache.get(cache_key)
#         if cached_data:
#             return Response(cached_data)
        
#         overdue_qs = self.get_queryset().filter(is_completed=False, due_date__lte=today)
#         page = self.paginate_queryset(overdue_qs)
#         if page is not None:
#             serializer = self.get_serializer(page, many=True)
#             return self.get_paginated_response(serializer.data)
#         serializer = self.get_serializer(overdue_qs, many=True)
#         data = serializer.data

#         cache.set(cache_key, data, timeout=60 * 10)  # Cache for 10 min
#         return Response(data)


from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.utils import timezone
from django.core.cache import cache

from rest_framework import viewsets, filters
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from django_filters.rest_framework import DjangoFilterBackend, FilterSet, BooleanFilter

from tracker.models import Project, Task, Contributor
from tracker.serializers import ProjectSerializer, TaskSerializer, ContributorSerializer


# ------------------------------
# Project ViewSet
# ------------------------------
@method_decorator(cache_page(60*5), name='list')  # Cache list view for 5 minutes
class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all().order_by('-created_at')
    serializer_class = ProjectSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    
    filterset_fields = ['status']  # Filter projects by status
    search_fields = ['name', 'description', 'location']  # Search projects
    ordering_fields = ['created_at', 'updated_at']  # Ordering fields

    def perform_create(self, serializer):
        serializer.save()
        cache.clear()

    def perform_update(self, serializer):
        serializer.save()
        cache.clear()

    def perform_destroy(self, instance):
        instance.delete()
        cache.clear()


# ------------------------------
# Contributor ViewSet
# ------------------------------
class ContributorViewSet(viewsets.ModelViewSet):
    queryset = Contributor.objects.all()
    serializer_class = ContributorSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [filters.SearchFilter, DjangoFilterBackend]
    search_fields = ['name', 'email', 'skills']
    # Optional filter by project if needed
    filterset_fields = ['projects']


# ------------------------------
# Task Filter with overdue support
# ------------------------------
class TaskFilter(FilterSet):
    overdue = BooleanFilter(method='filter_overdue', label='Overdue Tasks')

    class Meta:
        model = Task
        fields = ['is_completed', 'project', 'contributors', 'overdue']

    def filter_overdue(self, queryset, name, value):
        if value:
            today = timezone.now().date()
            queryset = queryset.filter(is_completed=False, due_date__lte=today)
        return queryset


# ------------------------------
# Task ViewSet
# ------------------------------
@method_decorator(cache_page(60*5), name='list')  # Cache task list for 5 minutes
class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all().select_related('project').prefetch_related('contributors')
    serializer_class = TaskSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_class = TaskFilter
    search_fields = ['title', 'description']
    ordering_fields = ['due_date', 'created_at', 'updated_at']

    def perform_create(self, serializer):
        serializer.save()
        cache.clear()

    def perform_update(self, serializer):
        serializer.save()
        cache.clear()

    def perform_destroy(self, instance):
        instance.delete()
        cache.clear()

    @action(detail=False, methods=['get'])
    def overdue(self, request):
        """Return all overdue tasks"""
        today = timezone.now().date()
        cache_key = f"overdue_tasks_{today}"

        cached_data = cache.get(cache_key)
        if cached_data:
            return Response(cached_data)

        overdue_qs = self.get_queryset().filter(is_completed=False, due_date__lte=today)
        page = self.paginate_queryset(overdue_qs)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(overdue_qs, many=True)
        data = serializer.data
        cache.set(cache_key, data, timeout=60*10)  # Cache for 10 min
        return Response(data)
