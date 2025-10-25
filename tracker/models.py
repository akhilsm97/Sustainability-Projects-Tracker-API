from django.db import models

# Create your models here.
from django.db import models

class Project(models.Model):
    STATUS_CHOICES = [
        ('active','Active'), ('completed','Completed'), ('on_hold','On Hold')
    ]
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    location = models.CharField(max_length=200, blank=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='active')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self): return self.name

class Contributor(models.Model):
    name = models.CharField(max_length=150)
    email = models.EmailField(unique=True)
    skills = models.JSONField(blank=True, null=True)  # or TextField
    joined_on = models.DateField(auto_now_add=True)

    def __str__(self): return self.name

class Task(models.Model):
    project = models.ForeignKey(Project, related_name='tasks', on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    due_date = models.DateField(null=True, blank=True)
    is_completed = models.BooleanField(default=False)
    is_overdue = models.BooleanField(default=False)
    contributors = models.ManyToManyField(Contributor, related_name='tasks', blank=True)
    

    def __str__(self): return self.title
