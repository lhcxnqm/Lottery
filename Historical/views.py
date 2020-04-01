from django.shortcuts import render
from .models import History, BigOrSmall, European, Asia
import datetime
from Historical import historySpider, getData
from pandas.tseries.offsets import Day
from django.db.models import Q


# 点击历史导航栏进入
def index_history(request):
    prior_day = datetime.date.today() - Day()
    if 'year' in request.POST:
        year = request.POST['year']
        month = request.POST['month']
        date = request.POST['date']
        prior_day = datetime.datetime.strptime(year+'-'+month+'-'+date, '%Y-%m-%d')

    history = History.objects.filter(time=prior_day).order_by('match_time')
    if history.count():
        result_list = []
        for each in history:
            if "VS".__eq__(each.result):
                start_delete(each.matchId)
                start_save(each.matchId, prior_day)

            result_item = dict()
            return_team_result(result_item, each)
            return_asia_result(result_item, each, '澳门')
            return_europe_result(result_item, each, '澳门')
            result_list.append(result_item)

        return render(request, "history.html", {'result_list': result_list, 'result': None})

    else:
        # prior_day = datetime.datetime.strftime(prior_day, "%Y-%m-%d")
        # get_history_data = historySpider.HistorySpider(str(prior_day))
        # final_id = get_history_data.run()
        # for match_id in final_id:
        #     start_save(match_id, prior_day)
        #
        return render(request, "history.html", {'result': '暂无比赛记录，请查询其他日期'})


# 队伍战绩详情
def team_detail(request, match_id, team_type):
    # 根据赛事编号获取相应的队伍名称
    team = History.objects.get(matchId=match_id)
    if 'host'.__eq__(team_type):
        team_name = team.hostTeam
        team_message = History.objects.filter(Q(hostTeam=team_name) | Q(guestTeam=team_name))[:30]
    else:
        team_name = team.guestTeam
        team_message = History.objects.filter(Q(guestTeam=team_name) | Q(hostTeam=team_name))[:30]

    team_list = []
    team_list, all_result = return_victory_or_defeat(team_name, team_message, team_list)

    return render(request, "teamDetail.html",
                  {'team': team, 'team_name': team_name, 'team_list': team_list, 'all_result': all_result})


# 返回一组team_message中，指定队伍的基本信息, 胜平负, 盘口输赢, 大小球
def return_victory_or_defeat(team_name, team_message, team_list):
    win, peace, lose = 0, 0, 0
    win_handicap, peace_handicap, lose_handicap = 0, 0, 0
    big_handicap, small_handicap = 0, 0
    goal, fumble = 0,0 # 进球,失球
    handicap_let = {'平手': 0, '平手/半球': -0.25, '半球': -0.5, '半球/一球': -0.75,
                    '一球': -1, '一球/球半': -1.25, '球半': -1.5, '球半/两球': -1.75,
                    '两球': -2, '两球/两球半': -2.25, '两球半': -2.5, '两球半/三球': -2.75,
                    '三球': -3, '三球/三球半': -3.25, '三球半': -3.5, '三球半/四球': -3.75,
                    '受平手/半球': 0.25, '受半球': 0.5, '受半球/一球': 0.75,
                    '受一球': 1, '受一球/球半': 1.25, '受球半': 1.5, '受球半/两球': 1.75,
                    '受两球': 2, '受两球/两球半': 2.25, '受两球半': 2.5, '受两球半/三球': 2.75,
                    '受三球': 3, '受三球/三球半': 3.25, '受三球半': 3.5, '受三球半/四球': 3.75}
    handicap_size = {'1': 1, '1/1.5': 1.25, '1.5': 1.5, '1.5/2': 1.75, '2': 2, '2/2.5': 2.25, '2.5': 2.5, '2.5/3': 2.75,
                     '3': 3, '3/3.5': 3.25, '3.5': 3.5, '3.5/4': 3.75, '4': 4, '4/4.5': 4.25, '4.5': 4.5, '4.5/5': 4.75,
                     '5': 5, '5/5.5': 5.25, '5.5': 5.5, '5.5/6': 5.75, '6': 6, '6/6.5': 6.25, '6.5': 6.5, '6.5/7': 6.75,
                     '7': 7, '7/7.5': 7.25}

    for each in team_message:
        team_item = dict()
        team_item['matchId'] = each.matchId
        team_item['match'] = each.match
        team_item['match_time'] = each.match_time
        team_item['hostTeam'] = each.hostTeam
        team_item['guestTeam'] = each.guestTeam
        team_item['result_host'] = each.result_host
        team_item['result_guest'] = each.result_guest

        # 指定队伍每一场的进失球情况
        if each.hostTeam == team_name:
            goal += int(each.result[0])
            fumble += int(each.result[-1])
        else:
            goal += int(each.result[-1])
            fumble += int(each.result[0])

        try:
            team_item['immediateOpening'] = Asia.objects.get(company='澳门', subMatchId_id=each.matchId).immediateOpening
            # 指定队伍每一场的盘口输赢情况
            handicap_calculate = float(handicap_let[team_item['immediateOpening']])
            result_host, result_guest = float(each.result[0]), float(each.result[-1])
            if team_name == each.hostTeam:
                if result_host + handicap_calculate > result_guest:
                    team_item['handicap'] = '赢'
                    win_handicap += 1
                elif result_host + handicap_calculate == result_guest:
                    team_item['handicap'] = '走盘'
                    peace_handicap += 1
                else:
                    team_item['handicap'] = '输'
                    lose_handicap += 1
            else:
                if result_guest > result_host + handicap_calculate:
                    team_item['handicap'] = '赢'
                    win_handicap += 1
                elif result_host + handicap_calculate == result_guest:
                    team_item['handicap'] = '走盘'
                    peace_handicap += 1
                else:
                    team_item['handicap'] = '输'
                    lose_handicap += 1
        except Asia.DoesNotExist as e:
            print(e)

        try:
            # 指定队伍每一场赛事的大小球结果
            team_item['sizeOpening'] = BigOrSmall.objects.get(company='澳门', subMatchId_id=each.matchId).immediateOpening
            handicap_calculate = handicap_size[team_item['sizeOpening']]
            result_host, result_guest = float(each.result[0]), float(each.result[-1])
            if result_host + result_guest > handicap_calculate:
                team_item['handicap_size'] = '大'
                big_handicap += 1
            elif result_host + result_guest == handicap_calculate:
                team_item['handicap_size'] = '走盘'
            else:
                team_item['handicap_size'] = '小'
                small_handicap += 1
        except BigOrSmall.DoesNotExist as e:
            print(e)

        try:
            # 指定队伍每一场赛事的主流欧赔
            europe = European.objects.get(company='澳门', subMatchId_id=each.matchId)
            team_item['immediateWin'] = europe.immediateWin
            team_item['immediatePeace'] = europe.immediatePeace
            team_item['immediateLose'] = europe.immediateLose
        except European.DoesNotExist as e:
            print(e)

        # 指定队伍每一场赛事的胜平负
        if team_name == each.hostTeam and each.result[0] > each.result[-1]:
            win += 1
            team_item['victory_or_defeat'] = '胜'
        elif each.result[0] == each.result[-1]:
            peace += 1
            team_item['victory_or_defeat'] = '平'
        elif team_name == each.guestTeam and each.result[-1] > each.result[0]:
            win += 1
            team_item['victory_or_defeat'] = '胜'
        else:
            lose += 1
            team_item['victory_or_defeat'] = '负'

        team_list.append(team_item)

    all_result = {'total_win': win, 'total_peace': peace, 'total_lose': lose, 'total_count': team_message.count(),
                  'win_rate': "%.2f" % float(win/team_message.count()*100),
                  'peace_rate': "%.2f" % float(peace/team_message.count()*100),
                  'lose_rate': "%.2f" % float(lose/team_message.count()*100),
                  'win_handicap': win_handicap, 'peace_handicap': peace_handicap, 'lose_handicap': lose_handicap,
                  'win_handicap_rate': "%.2f" % float(win_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'peace_handicap_rate': "%.2f" % float(peace_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'lose_handicap_rate': "%.2f" % float(lose_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'total_big': big_handicap, 'total_small': small_handicap,
                  'big_rate': "%.2f" % float(big_handicap/(big_handicap+small_handicap)*100),
                  'small_rate': "%.2f" % float(small_handicap/(big_handicap+small_handicap)*100),
                  'goal': goal, 'fumble': fumble, 'clear_wins': goal-fumble}

    return team_list, all_result


# 历史亚盘信息详情
def history_asia(request, match_id):
    history = History.objects.get(matchId=match_id)
    team_message = dict()
    return_team_result(team_message, history)

    result_list = []
    for each in Asia.objects.filter(subMatchId_id=match_id):
        result_item = dict()
        return_asia_result(result_item, history, each.company)
        result_list.append(result_item)

    return render(request, "history_asia.html", {'team_message': team_message, 'result_list': result_list})


# 返回赛事基本信息
def return_team_result(team_message, each):
    team_message['matchId'] = each.matchId
    team_message['match'] = each.match
    team_message['round'] = each.round
    team_message['short_time'] = each.short_time
    team_message['hostTeam'] = each.hostTeam
    team_message['result'] = each.result
    team_message['guestTeam'] = each.guestTeam
    team_message['match_time'] = each.match_time

    match_color = {'英超': '#FF1717', '意甲': '#0066FF', '德乙': '#DB31EE', '荷甲': '#ff6699', '澳超': '#336699',
                   '日职': '#017001', '葡超': '#008888', '阿甲': '#00CCFF', '英甲': '#750000', '挪超': '#666666',
                   '欧罗巴': '#6F00DD', '比甲': '#FC9B0A', '法乙': '#ACA96C', '日职乙': '#5A9400', '瑞典超': '#004488',
                   '欧洲杯': '#6F006F', '欧国联': '#6066FF', '英锦赛': '#E07C64'}
    team_message['match_color'] = match_color[each.match]


# 返回亚盘信息
def return_asia_result(result_item, each, company):
    try:
        each_asia = Asia.objects.get(company=company, subMatchId_id=each.matchId)
        result_item['company'] = each_asia.company
        result_item['immediateUpperStage'] = each_asia.immediateUpperStage
        result_item['immediateLowerStage'] = each_asia.immediateLowerStage
        result_item['immediateOpening'] = each_asia.immediateOpening
        result_item['changedTime'] = each_asia.changedTime
        result_item['startUpperStage'] = each_asia.startUpperStage
        result_item['startLowerStage'] = each_asia.startLowerStage
        result_item['startOpening'] = each_asia.startOpening
        result_item['startTime'] = each_asia.startTime
    except Asia.DoesNotExist:
        pass


# 返回欧盘信息
def return_europe_result(result_item, each, company):
    try:
        each_europe = European.objects.get(company=company, subMatchId_id=each.matchId)
        result_item['company'] = each_europe.company
        result_item['immediateWin'] = each_europe.immediateWin
        result_item['immediatePeace'] = each_europe.immediatePeace
        result_item['immediateLose'] = each_europe.immediateLose
        result_item['startWin'] = each_europe.startWin
        result_item['startPeace'] = each_europe.startPeace
        result_item['startLose'] = each_europe.startLose
    except European.DoesNotExist:
        pass


# 存储数据公共方法
def save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, company):
    try:
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
    except IndexError:
        pass


# 开始存储
def start_save(match_id, prior_day):
    team_message, asia_dict = getData.get_asia_detail(match_id)

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


# 开始删除
def start_delete(match_id):
    # 删除亚盘信息
    obj = Asia.objects.filter(subMatchId_id=match_id)
    obj.delete()
    # 删除欧盘信息
    obj = European.objects.filter(subMatchId_id=match_id)
    obj.delete()
    # 删除大小球盘信息
    obj = BigOrSmall.objects.filter(subMatchId_id=match_id)
    obj.delete()
    # 删除主信息
    obj = History.objects.get(matchId=match_id)
    obj.delete()

