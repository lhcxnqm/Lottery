from django.db import models

# Create your models here.


class History(models.Model):
    matchId = models.CharField(max_length=8)  # 赛事ID
    match = models.CharField(max_length=10)  # 赛事
    round = models.CharField(max_length=10)   # 轮次
    time = models.DateField()                   # 比赛时间
    hostTeam = models.CharField(max_length=20)    # 主队
    guestTeam = models.CharField(max_length=20)   # 客队
    result = models.CharField(max_length=5)    # 比赛结果
    companyId = models.CharField(max_length=3)   # 公司ID


class Company(models.Model):
    companyId = models.CharField(max_length=3)  # 公司ID


class BigOrSmall(models.Model):
    companyId = models.CharField(max_length=3)   # 公司ID
    immediateUpperStage = models.FloatField()      # 临场上盘水位
    immediateLowerStage = models.FloatField()      # 临场下盘水位
    immediateOpening = models.CharField(max_length=20)  # 临场大小球盘
    startUpperStage = models.FloatField()  # 初盘上盘水位
    startLowerStage = models.FloatField()  # 初盘下盘水位
    startOpening = models.CharField(max_length=20)  # 初盘大小球盘
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey(History, to_field='matchId', on_delete=models.CASCADE)  # 赛事ID


class European(models.Model):
    companyId = models.CharField(max_length=3)  # 公司
    immediateUpperStage = models.FloatField()  # 临场上盘水位
    immediateLowerStage = models.FloatField()  # 临场下盘水位
    immediateOpening = models.CharField(max_length=20)  # 临场盘口
    startWin = models.FloatField()  # 初盘胜赔率
    startPeace = models.FloatField()  # 初盘平赔率
    startLose = models.FloatField()  # 初盘负赔率
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey(History, to_field='matchId', on_delete=models.CASCADE)  # 赛事ID
