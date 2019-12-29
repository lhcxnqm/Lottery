from django.urls import path
from . import views

urlpatterns = [
    path('', views.index_history),
    path('asia_<int:match_id>/', views.history_asia),
]