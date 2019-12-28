from django.shortcuts import render
from .models import History, BigOrSmall, European, Asia
import datetime
from Historical import historySpider, getData
from pandas.tseries.offsets import Day


def index_history(request):
    prior_day = datetime.date.today() - Day()
    try:
        history = History.objects.filter(time=prior_day).order_by('match_time')
        result_list = []
        for each in history:
            result_item = dict()
            return_result(result_item, each)
            result_list.append(result_item)

        return render(request, "history.html", {'result_list': result_list})
    except History.DoesNotExist:
        get_history_data = historySpider.HistorySpider(str(prior_day))
        final_id = get_history_data.run()
        for match_id in final_id:
            team_message, asia_dict = getData.get_asia_detail(match_id)
            if "VS".__eq__(team_message[3]):
                continue
            # 存储赛事基本信息
            team_sql = History(int(match_id), match=team_message[5], round=team_message[6], time=prior_day,
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

        return render(request, "history.html", {'result': '历史记录已更新，请刷新页面'})


def history_asia(request):
    return render(request, "history_asia.html")


def return_result(result_item, each):
    result_item['matchId'] = each.matchId
    result_item['match'] = each.match
    result_item['round'] = each.round
    result_item['short_time'] = each.short_time
    result_item['hostTeam'] = each.hostTeam
    result_item['result'] = each.result
    result_item['guestTeam'] = each.guestTeam

    match_color = {'英超': '#FF1717', '意甲': '#0066FF', '德乙': '#DB31EE', '荷甲': '#ff6699', '澳超': '#336699',
                   '日职': '#017001', '葡超': '#008888', '阿甲': '#00CCFF', '英甲': '#750000', '挪超': '#666666',
                   '欧罗巴': '#6F00DD', '比甲': '#FC9B0A', '法乙': '#ACA96C', '日职乙': '#5A9400', '瑞典超': '#004488',
                   '欧洲杯': '#6F006F', '欧国联': '#6066FF', '英锦赛': '#E07C64'}
    result_item['match_color'] = match_color[each.match]

    each_asia = Asia.objects.get(company='澳门', subMatchId_id=each.matchId)
    result_item['company'] = each_asia.company
    result_item['immediateUpperStage'] = each_asia.immediateUpperStage
    result_item['immediateLowerStage'] = each_asia.immediateLowerStage
    result_item['immediateOpening'] = each_asia.immediateOpening
    result_item['startUpperStage'] = each_asia.startUpperStage
    result_item['startLowerStage'] = each_asia.startLowerStage
    result_item['startOpening'] = each_asia.startOpening

    each_europe = European.objects.get(company='澳门', subMatchId_id=each.matchId)
    result_item['immediateWin'] = each_europe.immediateWin
    result_item['immediatePeace'] = each_europe.immediatePeace
    result_item['immediateLose'] = each_europe.immediateLose
    result_item['startWin'] = each_europe.startWin
    result_item['startPeace'] = each_europe.startPeace
    result_item['startLose'] = each_europe.startLose


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
