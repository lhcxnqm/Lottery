from django.shortcuts import render
from .models import History


def index_history(request):

    return render(request, "index_history.html")
