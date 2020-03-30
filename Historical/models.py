from django.db import models

# Create your models here.


class History(models.Model):
    matchId = models.IntegerField(primary_key=True)  # 赛事ID
    match = models.CharField(max_length=10)  # 赛事
    round = models.CharField(max_length=10)   # 轮次
    time = models.DateField()                   # 当日日期
    match_time = models.CharField(max_length=16)             # 比赛时间
    hostTeam = models.CharField(max_length=16)    # 主队
    guestTeam = models.CharField(max_length=16)   # 客队
    result = models.CharField(max_length=5)    # 比赛结果

    def short_time(self):
        return self.match_time[5:]

    def result_host(self):
        return self.result[0]

    def result_guest(self):
        return self.result[-1]

    class Meta:
        ordering = ['-match_time']


class BigOrSmall(models.Model):
    company = models.CharField(max_length=8)   # 公司
    immediateUpperStage = models.FloatField()      # 临场上盘水位
    immediateLowerStage = models.FloatField()      # 临场下盘水位
    immediateOpening = models.CharField(max_length=20)  # 临场大小球盘
    startUpperStage = models.FloatField()  # 初盘上盘水位
    startLowerStage = models.FloatField()  # 初盘下盘水位
    startOpening = models.CharField(max_length=20)  # 初盘大小球盘
    changedTime = models.CharField(max_length=12)    # 临场时间
    startTime = models.CharField(max_length=12)  # 初盘时间
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey(History, to_field='matchId', on_delete=models.CASCADE)  # 赛事ID


class European(models.Model):
    company = models.CharField(max_length=8)  # 公司
    immediateWin = models.FloatField()  # 临场胜赔率
    immediatePeace = models.FloatField()  # 临场平赔率
    immediateLose = models.FloatField()  # 临场负赔率
    startWin = models.FloatField()  # 初盘胜赔率
    startPeace = models.FloatField()  # 初盘平赔率
    startLose = models.FloatField()  # 初盘负赔率
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey(History, to_field='matchId', on_delete=models.CASCADE)  # 赛事ID


class Asia(models.Model):
    company = models.CharField(max_length=8)  # 公司
    immediateUpperStage = models.FloatField()  # 临场上盘水位
    immediateLowerStage = models.FloatField()  # 临场下盘水位
    immediateOpening = models.CharField(max_length=20)  # 临场大小球盘
    startUpperStage = models.FloatField()  # 初盘上盘水位
    startLowerStage = models.FloatField()  # 初盘下盘水位
    startOpening = models.CharField(max_length=20)  # 初盘大小球盘
    changedTime = models.CharField(max_length=12)  # 临场时间
    startTime = models.CharField(max_length=12)  # 初盘时间
    # 表示外键关联到History表,当History表删除了该条数据,此表中也被删除
    subMatchId = models.ForeignKey(History, to_field='matchId', on_delete=models.CASCADE)  # 赛事ID
