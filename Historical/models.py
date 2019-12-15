from django.db import models

# Create your models here.


class History(models.Model):
    matchId = models.IntegerField()  # 赛事ID
    match = models.CharField(max_length=10)  # 赛事
    round = models.CharField(max_length=10)   # 轮次
    time = models.DateField()                   # 比赛时间
    hostTeam = models.CharField(max_length=20)    # 主队
    guestTeam = models.CharField(max_length=20)   # 客队
    result = models.CharField(max_length=10)    # 比赛结果
    company = models.CharField(max_length=10)   # 公司
    upperStage = models.FloatField()            # 上盘水位
    lowerStage = models.FloatField()            # 下盘水位
    opening = models.CharField(max_length=20)   # 开盘
    win = models.FloatField()                   # 胜赔率
    peace = models.FloatField()                 # 平赔率
    lose = models.FloatField()                  # 负赔率


class BigOrSmall(models.Model):
    company = models.CharField(max_length=10)   # 公司
    immediateUpperStage = models.FloatField()      # 临场上盘水位
    immediateLowerStage = models.FloatField()      # 临场下盘水位
    immediateOpening = models.CharField(max_length=20)  # 临场大小球盘
    startUpperStage = models.FloatField()  # 初盘上盘水位
    startLowerStage = models.FloatField()  # 初盘下盘水位
    startOpening = models.CharField(max_length=20)  # 初盘大小球盘
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey('History', on_delete=models.CASCADE)  # 赛事ID
