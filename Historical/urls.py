from django.urls import path
from . import views

urlpatterns = [
    path('', views.index_history),
    path('asia/', views.history_asia),
]