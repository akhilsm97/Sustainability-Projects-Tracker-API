from celery import shared_task
from django.utils import timezone
from .models import Task

@shared_task
def mark_overdue_tasks():
    today = timezone.now().date()
    overdue = Task.objects.filter(is_completed=False, due_date__lte=today)
    overdue.update(is_overdue=True)
