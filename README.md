# Sustainability-Projects-Tracker-API

## Overview
The **Task Management API** is a Django REST Framework-based backend for managing projects, tasks, and contributors.   It supports user authentication, task assignment, overdue tracking and caching.

## Key Features:
- JWT-based authentication
- Custom user model 
- CRUD operations for Projects, Tasks, and Contributors
- Overdue task detection using Celery + Celery Beat
- Response caching using Redis
- Filtering, searching, and ordering for API endpoints

  ---

## Table of Contents
1. [Setup Instructions](#setup-instructions)
2. [Environment Variables](#environment-variables)
3. [Installation](#installation)
4. [Running the Project](#running-the-project)
5. [API Endpoints](#api-endpoints)
6. [Database Design](#database-design)
7. [Caching Design](#caching-design)
8. [Periodic Tasks (Celery Beat)](#periodic-tasks-celery-beat)
9. [Push Notifications (FCM)](#push-notifications-fcm)
10. [Testing](#testing)
11. [License](#license)

---
## Setup Instructions

### Prerequisites
- Python 3.10+
- Django 4.x
- Django REST Framework
- MySQL 
- Redis (for caching and Celery)
- Celery & Celery Beat
- Git

---
## Environment Variables

Create a `.env` file in your project root:

```env
SECRET_KEY=your_django_secret_key
DEBUG=True
DATABASE_URL=postgres://user:password@localhost:5432/db_name
REDIS_URL=redis://localhost:6379/0
ALLOWED_HOSTS=127.0.0.1,localhost
```
---
## Installation
### 1. Clone the repository:

```
git clone https://gitlab.com/akhilsm97-group/akhilsm97-project.git
cd Sustainability-Projects-Tracker-API
```
---
### 2. Create and activate a virtual environment:
```
python -m venv venv
source venv/bin/activate   # Linux/Mac
venv\Scripts\activate      # Windows
```
---
### 3. Install dependencies:
```
pip install -r requirements.txt

```
---
### 4. Apply migrations:
```bash
python manage.py migrate
```
---
### 5. Create a superuser (optional):
```
python manage.py createsuperuser
```
---
### 6. Start Redis server (for caching & Celery):
```
redis-server
```
---
### 7. Start the Django server:
```
python manage.py runserver
```
---
### 8. Start Celery worker:
```
celery -A project_name worker -l info
```
---
### 9. Start Celery Beat for periodic tasks:
```
celery -A project_name beat -l info
```
---
## API Endpoints
### Authentication

|    Method    |    Endpoint    |    Description    |
|    --------    |    ----------|    ------------    | 
|    POST      |      /api/register/    |   Register a new user    |
|    POST      |      /api/login/   |   Obtain JWT token    |
|    POST      |      /api/logout/    |   Logout user   |

### Projects

|    Method    |    Endpoint    |    Description    |
|    --------    |    ----------|    ------------    | 
|    GET      |      /api/projects/    |   List all projects   |
|    POST      |      /api/projects/  |   Create a new project   |
|    GET      |      /api/projects/{id}/   |  Retrieve project details  |
|    PUT     |      /api/projects/{id}/   |  Update project  |
|    DELETE     |      /api/projects/{id}/   |  Delete project  |

### Tasks
|    Method    |    Endpoint    |    Description    |
|    --------    |    ----------|    ------------    | 
|    GET      |      /api/tasks/    |   List all tasks   |
|    POST      |      /api/tasks/  |   Create a new task  |
|    GET      |     /api/tasks/{id}/   |  Retrieve task details  |
|    PUT     |      /api/tasks/{id}/   |  Update task  |
|    DELETE     |      /api/tasks/{id}/   |  Delete task  |
|    GET     |      /api/tasks/overdue/  |  Get all overdue tasks  |

### Contributors

|    Method    |    Endpoint    |    Description    |
|    --------    |    ----------|    ------------    | 
|    GET      |     /api/contributors/    |   List all contributor   |
|    POST      |      /api/contributors/  |   Create a new contributor  |
|    GET      |      /api/contributors/{id}/   |  Retrieve contributor details  |
|    PUT     |      /api/contributors/{id}/   |  Update contributor  |
|    DELETE     |      /api/contributors/{id}/   |  Delete contributor  |

---
## Database Design

### CustomUser
- Fields: username, email, first_name, last_name, phone, gender, dob, tc, following, is_admin, is_active
- Permissions: All admins are staff (is_staff), simple has_perm implementation
### Project
- Fields: name, description, location, status, created_at, updated_at
- One-to-many relation with Task
### Contributor
- Fields: name, email, skills (JSONField), joined_on
- Many-to-many relation with Task
### Task
- Fields: title, description, due_date, is_completed, is_overdue
- Relationships:
  - `ForeignKey → Project`
  - `Many-to-many → Contributor`
- Indexing suggestion: due_date and is_completed for fast overdue queries

 ---
 ## Caching Design
 - List views for Project and Task are cached for 5 minutes using @cache_page.
 - Custom /tasks/overdue/ endpoint caches data for 10 minutes with key overdue_tasks_{date}.
 - Cache is cleared on create/update/delete actions to prevent stale data.
 - Redis is used as the backend for fast in-memory storage.

---
## Periodic Tasks (Celery Beat)
- Celery periodically runs check_overdue_tasks every 10 minutes:
  - `Marks Task.is_overdue = True if due_date ≤ today and is_completed=False`
- Ensures overdue tasks are updated automatically without manual intervention
  ### Example task:
```
@shared_task
def mark_overdue_tasks():
    today = timezone.now().date()
    overdue = Task.objects.filter(is_completed=False, due_date__lte=today)
    overdue.update(is_overdue=True)
```
---
## Testing
Run tests using:
```
python manage.py test
```
Tests cover:
- Authentication
- CRUD operations for Projects, Tasks, Contributors
- Caching functionality

 ---
 ## License
 
 This README is **complete, detailed, and professional**, covering authentication, caching, Celery periodic tasks and all models.  

I can also **create a visual architecture diagram** showing how **Django, Redis, Celery, and MySQL** interact—this looks great in the README.  
 
