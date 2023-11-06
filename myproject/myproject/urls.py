from django.contrib import admin
from django.urls import path
from myapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.hello_django, name='hello_django'),  # Add this line
    path('myapp/hello/', views.hello_django, name='hello_django'),
]

