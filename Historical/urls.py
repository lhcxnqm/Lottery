from django.urls import path
from . import views

urlpatterns = [
    path('', views.index_history),
    path('asia_<int:match_id>/', views.history_asia),
    path('european_<int:match_id>/', views.history_european),
    path('team_<int:match_id>_<str:team_type>/', views.team_detail),
]
