from django.shortcuts import render
from .models import History, BigOrSmall, European, Asia
import datetime
from Historical import getData
from pandas.tseries.offsets import Day
from django.db.models import Q
import re
import pandas as pd
import os

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


# 球队战绩详情页
def team_detail(request, match_id, team_type):
    if len(team_type) > 5:
        try:
            choose_number = int(re.compile(r'\d+').findall(team_type)[0])
            if choose_number == 10:
                ten, thirty, fifty, hundred = "selected", "", "", ""
            elif choose_number == 30:
                ten, thirty, fifty, hundred = "", "selected", "", ""
            elif choose_number == 50:
                ten, thirty, fifty, hundred = "", "", "selected", ""
            else:
                ten, thirty, fifty, hundred = "", "", "", "selected"
        except IndexError as e:
            print(e)
    else:
        choose_number = 30
        ten, thirty, fifty, hundred = "", "selected", "", ""

    # 根据赛事编号获取相应的队伍名称
    team = History.objects.get(matchId=match_id)
    # 控制前端是否高亮
    all_on, main_on, guest_on = '', '', ''
    # host 表传进来主队, main 表主场记录, second 表客场记录
    if 'host' in team_type:
        team_name = team.hostTeam
        team_message = History.objects.filter(Q(hostTeam=team_name, match_time__lt=team.match_time) |
                                              Q(guestTeam=team_name, match_time__lt=team.match_time))[:choose_number]
        if 'main' in team_type:
            team_message = History.objects.filter(hostTeam=team_name, match_time__lt=team.match_time)[:choose_number]
            main_on = 'on'
        if 'second' in team_type:
            team_message = History.objects.filter(guestTeam=team_name, match_time__lt=team.match_time)[:choose_number]
            guest_on = 'on'
        team_type = 'host'
    else:
        team_name = team.guestTeam
        team_message = History.objects.filter(Q(guestTeam=team_name, match_time__lt=team.match_time) |
                                              Q(hostTeam=team_name, match_time__lt=team.match_time))[:choose_number]
        if 'main' in team_type:
            team_message = History.objects.filter(hostTeam=team_name, match_time__lt=team.match_time)[:choose_number]
            main_on = 'on'
        if 'second' in team_type:
            team_message = History.objects.filter(guestTeam=team_name, match_time__lt=team.match_time)[:choose_number]
            guest_on = 'on'
        team_type = 'guest'
    all_on = '' if 'on'.__eq__(main_on) or 'on'.__eq__(guest_on) else 'on'

    team_list = []
    team_list, all_result = return_victory_or_defeat(team_name, team_message, team_list)

    return render(request, "teamDetail.html",
                  {'team': team, 'team_name': team_name, 'team_type': team_type,
                   'ten': ten, 'thirty': thirty, 'fifty': fifty, 'hundred': hundred, 'choose_number': choose_number,
                   'all_on': all_on, 'main_on': main_on, 'guest_on': guest_on,
                   'team_list': team_list, 'all_result': all_result})


# 返回一组team_message中，指定队伍的基本信息, 胜平负, 盘口输赢, 大小球
def return_victory_or_defeat(team_name, team_message, team_list):
    win, peace, lose = 0, 0, 0
    win_handicap, peace_handicap, lose_handicap = 0, 0, 0
    big_handicap, small_handicap = 0, 0
    goal, fumble = 0, 0  # 进球,失球

    for each in team_message:
        team_item = dict()
        return_team_result(team_item, each)
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
            team_item['origin_handicap'] = handicap_calculate
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

    big_rate = 0 if big_handicap == 0 and small_handicap == 0 else \
        "%.2f" % float(big_handicap/(big_handicap+small_handicap)*100)
    small_rate = 0 if big_handicap == 0 and small_handicap == 0 else \
        "%.2f" % float(small_handicap/(big_handicap+small_handicap)*100)

    all_result = {'total_win': win, 'total_peace': peace, 'total_lose': lose, 'total_count': team_message.count(),
                  'win_rate': "%.2f" % float(win/team_message.count()*100),
                  'peace_rate': "%.2f" % float(peace/team_message.count()*100),
                  'lose_rate': "%.2f" % float(lose/team_message.count()*100),
                  'win_handicap': win_handicap, 'peace_handicap': peace_handicap, 'lose_handicap': lose_handicap,
                  'win_handicap_rate': "%.2f" % float(win_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'peace_handicap_rate': "%.2f" % float(peace_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'lose_handicap_rate': "%.2f" % float(lose_handicap/(win_handicap+peace_handicap+lose_handicap)*100),
                  'total_big': big_handicap, 'total_small': small_handicap,
                  'big_rate': big_rate, 'small_rate': small_rate,
                  'goal': goal, 'fumble': fumble, 'clear_wins': goal-fumble}

    return team_list, all_result


# 欧盘相同指数导出Excel处理
def export_same_european(same_opening_list):
    export_list = []
    for each in same_opening_list:
        each_main = History.objects.get(matchId=each.subMatchId_id)
        temp = dict()
        temp['company'] = each.company
        temp['startWin'] = each.startWin
        temp['startPeace'] = each.startPeace
        temp['startLose'] = each.startLose
        temp['match'] = each_main.match
        temp['matchTime'] = each_main.match_time
        temp['hostTeam'] = each_main.hostTeam
        temp['guestTeam'] = each_main.guestTeam
        temp['result'] = each_main.result

        # 计算每一场胜平负情况
        result_host, result_guest = float(temp['result'][0]), float(temp['result'][-1])
        if result_host == result_guest:
            temp['handicap'] = 'X'
        elif result_host > result_guest:
            temp['handicap'] = '3'
        else:
            temp['handicap'] = '1'

        export_list.append(temp)

    return export_list


# 亚盘、大小球盘相同盘口导出Excel处理
def export_same_opening(same_opening_list, request):
    export_list = []
    for each in same_opening_list:
        each_main = History.objects.get(matchId=each.subMatchId_id)
        temp = dict()
        temp['company'] = each.company
        temp['startUpperStage'] = each.startUpperStage
        temp['startLowerStage'] = each.startLowerStage
        temp['startOpening'] = each.startOpening
        temp['match'] = each_main.match
        temp['matchTime'] = each_main.match_time
        temp['hostTeam'] = each_main.hostTeam
        temp['guestTeam'] = each_main.guestTeam
        temp['result'] = each_main.result

        # 计算每一场上下盘口情况
        result_host, result_guest = float(temp['result'][0]), float(temp['result'][-1])
        if 'big_or_small' not in request.POST:
            handicap_calculate = float(handicap_let[temp['startOpening']])
            if handicap_calculate < 0:
                if result_host + handicap_calculate > result_guest:
                    temp['handicap'] = '上盘'
                elif result_host + handicap_calculate == result_guest:
                    temp['handicap'] = '走盘'
                else:
                    temp['handicap'] = '下盘'
            else:
                if result_host + handicap_calculate > result_guest:
                    temp['handicap'] = '下盘'
                elif result_host + handicap_calculate == result_guest:
                    temp['handicap'] = '走盘'
                else:
                    temp['handicap'] = '上盘'
        else:
            handicap_calculate = float(handicap_size[temp['startOpening']])
            if result_host + result_guest > handicap_calculate:
                temp['handicap'] = '大球'
            elif result_host + result_guest == handicap_calculate:
                temp['handicap'] = '走盘'
            else:
                temp['handicap'] = '小球'

        export_list.append(temp)

    return export_list


# 历史亚盘信息详情页
def history_asia(request, match_id):
    history = History.objects.get(matchId=match_id)
    team_message = dict()
    return_team_result(team_message, history)

    # 按照公司、上下盘开盘，导出同种盘口的Excel并统计输赢盘情况
    if "company" in request.POST:
        company = request.POST["company"]
        start_upper_stage = request.POST["startUpperStage"]
        start_lower_stage = request.POST["startLowerStage"]
        start_opening = request.POST["startOpening"]
        same_opening_list = Asia.objects.filter(company=company, startUpperStage=start_upper_stage,
                                                startLowerStage=start_lower_stage, startOpening=start_opening)
        export_list = export_same_opening(same_opening_list, request)
        # 导出数据清理
        pf = pd.DataFrame(list(export_list))
        order = ['company', 'startUpperStage', 'startOpening', 'startLowerStage',
                 'match', 'matchTime', 'hostTeam', 'result', 'guestTeam', 'handicap']
        pf = pf[order]
        columns_map = {
            'company': '公司',
            'startUpperStage': '上盘水位',
            'startOpening': '初盘',
            'startLowerStage': '下盘水位',
            'match': '赛事',
            'matchTime': '比赛时间',
            'hostTeam': '主队',
            'result': '赛果',
            'guestTeam': '客队',
            'handicap': '盘路'
        }
        pf.rename(columns_map, inplace=True)
        if '/' in start_opening:
            start_opening = start_opening.replace('/', '')
        file_name = company + '_' + start_upper_stage + '_' + start_lower_stage + '_' + start_opening + '.xlsx'
        file_path = os.path.join(os.path.expanduser('~') + '/Desktop', file_name)
        pf.to_excel(file_path, encoding='utf-8', index=False)

    result_list = []
    for each in Asia.objects.filter(subMatchId_id=match_id):
        result_item = dict()
        return_asia_result(result_item, history, each.company)
        result_list.append(result_item)

    return render(request, "history_asia.html", {'team_message': team_message, 'result_list': result_list})


# 历史欧赔信息详情页
def history_european(request, match_id):
    history = History.objects.get(matchId=match_id)
    team_message = dict()
    return_team_result(team_message, history)

    # 按照公司、欧赔指数，导出同种欧指的Excel并统计胜平负情况
    if "company" in request.POST:
        company = request.POST["company"]
        start_win = request.POST["startWin"]
        start_peace = request.POST["startPeace"]
        start_lose = request.POST["startLose"]
        same_opening_list = European.objects.filter(company=company, startWin=start_win,
                                                    startPeace=start_peace, startLose=start_lose)
        export_list = export_same_european(same_opening_list)
        # 导出数据清理
        pf = pd.DataFrame(list(export_list))
        order = ['company', 'startWin', 'startPeace', 'startLose',
                 'match', 'matchTime', 'hostTeam', 'result', 'guestTeam', 'handicap']
        pf = pf[order]
        columns_map = {
            'company': '公司',
            'startWin': '胜',
            'startPeace': '平',
            'startLose': '负',
            'match': '赛事',
            'matchTime': '比赛时间',
            'hostTeam': '主队',
            'result': '赛果',
            'guestTeam': '客队',
            'handicap': '结果'
        }
        pf.rename(columns_map, inplace=True)
        file_name = company + '_' + start_win + '_' + start_peace + '_' + start_lose + '.xlsx'
        file_path = os.path.join(os.path.expanduser('~') + '/Desktop', file_name)
        pf.to_excel(file_path, encoding='utf-8', index=False)

    result_list = []
    average_win_probability, average_peace_probability, average_lose_probability = 0, 0, 0
    average_start_win_probability, average_start_peace_probability, average_start_lose_probability = 0, 0, 0
    for each in European.objects.filter(subMatchId_id=match_id):
        result_item = dict()
        return_europe_result(result_item, history, each.company)
        # 即时概率计算
        result_item['immediateWinProbability'] = "%.2f" % float(1/result_item['immediateWin']/(1/result_item['immediateWin'] + 1/result_item['immediatePeace'] + 1/result_item['immediateLose'])*100)
        result_item['immediatePeaceProbability'] = "%.2f" % float(1 / result_item['immediatePeace']/(1/result_item['immediateWin'] + 1/result_item['immediatePeace'] + 1/result_item['immediateLose']) * 100)
        result_item['immediateLoseProbability'] = "%.2f" % float(1 / result_item['immediateLose']/(1/result_item['immediateWin'] + 1/result_item['immediatePeace'] + 1/result_item['immediateLose']) * 100)
        result_item['startWinProbability'] = "%.2f" % float(1 / result_item['startWin']/(1/result_item['startWin'] + 1/result_item['startPeace'] + 1/result_item['startLose']) * 100)
        result_item['startPeaceProbability'] = "%.2f" % float(1 / result_item['startPeace']/(1/result_item['startWin'] + 1/result_item['startPeace'] + 1/result_item['startLose']) * 100)
        result_item['startLoseProbability'] = "%.2f" % float(1 / result_item['startLose']/(1/result_item['startWin'] + 1/result_item['startPeace'] + 1/result_item['startLose']) * 100)
        # 即时凯利计算前提
        average_win_probability += float(result_item['immediateWinProbability'])
        average_peace_probability += float(result_item['immediatePeaceProbability'])
        average_lose_probability += float(result_item['immediateLoseProbability'])
        average_start_win_probability += float(result_item['startWinProbability'])
        average_start_peace_probability += float(result_item['startPeaceProbability'])
        average_start_lose_probability += float(result_item['startLoseProbability'])
        # 返还率计算
        result_item['immediateReturnRate'] = "%.2f" % float(result_item['immediateWin']*result_item['immediatePeace']*result_item['immediateLose'] / (result_item['immediateWin']*result_item['immediatePeace']+result_item['immediateWin']*result_item['immediateLose']+result_item['immediatePeace']*result_item['immediateLose'])*100)
        result_item['startReturnRate'] = "%.2f" % float(result_item['startWin']*result_item['startPeace']*result_item['startLose'] / (result_item['startWin']*result_item['startPeace']+result_item['startWin']*result_item['startLose']+result_item['startPeace']*result_item['startLose'])*100)

        result_list.append(result_item)

    # 即时凯利计算
    for each in result_list:
        each['immediateWinKelley'] = "%.2f" % float(each['immediateWin']*average_win_probability/4/100)
        each['immediatePeaceKelley'] = "%.2f" % float(each['immediatePeace']*average_peace_probability/4/100)
        each['immediateLoseKelley'] = "%.2f" % float(each['immediateLose']*average_lose_probability/4/100)
        each['startWinKelley'] = "%.2f" % float(each['startWin'] * average_start_win_probability / 4 / 100)
        each['startPeaceKelley'] = "%.2f" % float(each['startPeace'] * average_start_peace_probability / 4 / 100)
        each['startLoseKelley'] = "%.2f" % float(each['startLose'] * average_start_lose_probability / 4 / 100)

    return render(request, "history_european.html", {'team_message': team_message, 'result_list': result_list})


# 历史大小球盘详情页
def history_big_or_small(request, match_id):
    history = History.objects.get(matchId=match_id)
    team_message = dict()
    return_team_result(team_message, history)

    # 按照公司、上下盘开盘，导出同种盘口的Excel并统计输赢盘情况
    if "company" in request.POST:
        company = request.POST["company"]
        start_upper_stage = request.POST["startUpperStage"]
        start_lower_stage = request.POST["startLowerStage"]
        start_opening = request.POST["startOpening"]
        same_opening_list = BigOrSmall.objects.filter(company=company, startUpperStage=start_upper_stage,
                                                      startLowerStage=start_lower_stage, startOpening=start_opening)
        export_list = export_same_opening(same_opening_list, request)
        # 导出数据清理
        pf = pd.DataFrame(list(export_list))
        order = ['company', 'startUpperStage', 'startOpening', 'startLowerStage',
                 'match', 'matchTime', 'hostTeam', 'result', 'guestTeam', 'handicap']
        pf = pf[order]
        columns_map = {
            'company': '公司',
            'startUpperStage': '上盘水位',
            'startOpening': '初盘',
            'startLowerStage': '下盘水位',
            'match': '赛事',
            'matchTime': '比赛时间',
            'hostTeam': '主队',
            'result': '赛果',
            'guestTeam': '客队',
            'handicap': '盘路'
        }
        pf.rename(columns_map, inplace=True)
        if '/' in start_opening:
            start_opening = start_opening.replace('/', '')
        file_name = company + '_' + start_upper_stage + '_' + start_lower_stage + '_' + start_opening + '.xlsx'
        file_path = os.path.join(os.path.expanduser('~') + '/Desktop', file_name)
        pf.to_excel(file_path, encoding='utf-8', index=False)

    result_list = []
    for each in BigOrSmall.objects.filter(subMatchId_id=match_id):
        result_item = dict()
        return_big_or_small_result(result_item, history, each.company)
        result_list.append(result_item)

    return render(request, "history_bigorsmall.html", {'team_message': team_message, 'result_list': result_list})


# 历史数据分析详情页
def history_analysis(request, match_id):
    history = History.objects.get(matchId=match_id)
    team_message = dict()
    return_team_result(team_message, history)

    # 获取主客交战历史
    both_team_message = History.objects.filter(Q(hostTeam=history.hostTeam, guestTeam=history.guestTeam) |
                                               Q(guestTeam=history.hostTeam, hostTeam=history.guestTeam))[:6]
    both_team_list = []
    both_team_list, both_all_result = return_victory_or_defeat(history.hostTeam, both_team_message, both_team_list)

    # 获取主队近期战绩
    host_team_message = History.objects.filter(Q(hostTeam=history.hostTeam, match_time__lt=history.match_time) |
                                               Q(guestTeam=history.hostTeam, match_time__lt=history.match_time))[:10]
    host_team_list = []
    host_team_list, host_all_result = return_victory_or_defeat(history.hostTeam, host_team_message, host_team_list)

    # 获取客队近期战绩
    guest_team_message = History.objects.filter(Q(hostTeam=history.guestTeam, match_time__lt=history.match_time) |
                                                Q(guestTeam=history.guestTeam, match_time__lt=history.match_time))[:10]
    guest_team_list = []
    guest_team_list, guest_all_result = return_victory_or_defeat(history.guestTeam, guest_team_message, guest_team_list)

    return render(request, "history_analysis.html",
                  {'team_message': team_message, 'both_team_list': both_team_list,
                   'host_team_list': host_team_list, 'host_all_result': host_all_result,
                   'guest_team_list': guest_team_list, 'guest_all_result': guest_all_result})


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


# 返回大小球盘信息
def return_big_or_small_result(result_item, each, company):
    try:
        each_big_or_small = BigOrSmall.objects.get(company=company, subMatchId_id=each.matchId)
        result_item['company'] = each_big_or_small.company
        result_item['immediateUpperStage'] = each_big_or_small.immediateUpperStage
        result_item['immediateLowerStage'] = each_big_or_small.immediateLowerStage
        result_item['immediateOpening'] = each_big_or_small.immediateOpening
        result_item['changedTime'] = each_big_or_small.changedTime
        result_item['startUpperStage'] = each_big_or_small.startUpperStage
        result_item['startLowerStage'] = each_big_or_small.startLowerStage
        result_item['startOpening'] = each_big_or_small.startOpening
        result_item['startTime'] = each_big_or_small.startTime
    except BigOrSmall.DoesNotExist:
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

