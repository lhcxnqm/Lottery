from django.shortcuts import render


def index(request):

    return render(request, "index.html")


def europe(request):

    return render(request, "europe.html")


def asia(request):

    return render(request, "asia.html")


def big_or_small(request):

    return render(request, "bigOrSmall.html")


def score(request):

    return render(request, "score.html")
