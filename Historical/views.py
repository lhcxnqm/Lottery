from django.shortcuts import render
from .models import History


def index(request):

    return render(request, "history.html")
