from django.shortcuts import render
from .models import History, BigOrSmall, European, Asia
import datetime
from Historical import historySpider, getData


def history(request):
    # today = datetime.date.today().strftime("%Y-%m-%d")
    # today = datetime.datetime.strptime(today, "%Y-%m-%d")

    today = "2019-12-21"
    get_history_data = historySpider.HistorySpider(today)
    today = datetime.datetime.strptime(today, "%Y-%d-%m")
    final_id = get_history_data.run()
    for match_id in final_id:
        team_message, asia_dict = getData.get_asia_detail(match_id)
        if "VS".__eq__(team_message[3]):
            continue
        # 存储赛事基本信息
        team_sql = History(int(match_id), match=team_message[5], round=team_message[6], time=today,
                           match_time=team_message[2], hostTeam=team_message[0], guestTeam=team_message[4],
                           result=team_message[3])
        team_sql.save()
        big_or_small_dict = getData.get_big_or_small_detail(match_id)
        europe_dict = getData.get_europe_detail(match_id)
        for each in ['3', '5', '280', '293']:
            if asia_dict[each] and '3'.__eq__(each):
                save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, 'Bet365')
            elif asia_dict[each] and '5'.__eq__(each):
                save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '澳门')
            elif asia_dict[each] and '280'.__eq__(each):
                save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '皇冠')
            else:
                save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '威廉希尔')

    return render(request, "history.html")


def save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, company):
    # 存储亚盘信息
    asia_sql = Asia(company=company, immediateUpperStage=asia_dict[each][1],
                    immediateLowerStage=asia_dict[each][3], immediateOpening=asia_dict[each][2],
                    startUpperStage=asia_dict[each][5], startLowerStage=asia_dict[each][7],
                    startOpening=asia_dict[each][6], changedTime=asia_dict[each][4],
                    startTime=asia_dict[each][8], subMatchId_id=int(match_id))
    asia_sql.save()
    # 存储大小球信息
    big_or_small_sql = BigOrSmall(company=company, immediateUpperStage=big_or_small_dict[each][1],
                                  immediateLowerStage=big_or_small_dict[each][3],
                                  immediateOpening=big_or_small_dict[each][2],
                                  startUpperStage=big_or_small_dict[each][5],
                                  startLowerStage=big_or_small_dict[each][7],
                                  startOpening=big_or_small_dict[each][6],
                                  changedTime=big_or_small_dict[each][4],
                                  startTime=big_or_small_dict[each][8], subMatchId_id=int(match_id))
    big_or_small_sql.save()
    # 存储欧盘信息
    europe_sql = European(company=company, immediateWin=europe_dict[each][1],
                          immediatePeace=europe_dict[each][2], immediateLose=europe_dict[each][3],
                          startWin=europe_dict[each][4], startPeace=europe_dict[each][5],
                          startLose=europe_dict[each][6], subMatchId_id=int(match_id))
    europe_sql.save()
