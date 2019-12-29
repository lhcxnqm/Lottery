from django.shortcuts import render
from . import indexSpider
from Historical import getData


def index(request):
    get_index_data = indexSpider.IndexSpider()
    final_id = get_index_data.run()
    result_list = []
    for match_id in final_id:
        result_item = dict()
        team_message, asia_dict = getData.get_asia_detail(match_id)
        europe_dict = getData.get_europe_detail(match_id)
        get_team_message(result_item, team_message)
        for companyId in ['3', '5']:
            get_asia_result(result_item, asia_dict, companyId)
            get_europe_result(result_item, europe_dict, companyId)

        result_list.append(result_item)

    return render(request, "index.html", {'result_list': result_list})


def europe(request):

    return render(request, "europe.html")


def asia(request):

    return render(request, "asia.html")


def big_or_small(request):

    return render(request, "bigOrSmall.html")


def get_team_message(result_item, team_message):
    result_item['match'] = team_message[-2]
    result_item['round'] = team_message[-1]
    result_item['match_time'] = team_message[2][5:]
    result_item['hostTeam'] = team_message[0]
    result_item['result'] = team_message[3]
    result_item['guestTeam'] = team_message[4]

    match_color = {'英超': '#FF1717', '意甲': '#0066FF', '德乙': '#DB31EE', '荷甲': '#ff6699', '澳超': '#336699',
                   '日职': '#017001', '葡超': '#008888', '阿甲': '#00CCFF', '英甲': '#750000', '挪超': '#666666',
                   '欧罗巴': '#6F00DD', '比甲': '#FC9B0A', '法乙': '#ACA96C', '日职乙': '#5A9400', '瑞典超': '#004488',
                   '欧洲杯': '#6F006F', '欧国联': '#6066FF', '英锦赛': '#E07C64'}
    result_item['match_color'] = match_color[team_message[-2]]


def get_asia_result(result_item, asia_dict, company_id):
    result_item['company' + company_id] = asia_dict[company_id][0]
    result_item['immediateUpperStage' + company_id] = asia_dict[company_id][1]
    result_item['immediateOpening' + company_id] = asia_dict[company_id][2]
    result_item['immediateLowerStage' + company_id] = asia_dict[company_id][3]


def get_europe_result(result_item, europe_dict, company_id):
    result_item['company' + company_id] = europe_dict[company_id][0]
    result_item['immediateWin' + company_id] = europe_dict[company_id][1]
    result_item['immediatePeace' + company_id] = europe_dict[company_id][2]
    result_item['immediateLose' + company_id] = europe_dict[company_id][3]
    result_item['startWin' + company_id] = europe_dict[company_id][4]
    result_item['startPeace' + company_id] = europe_dict[company_id][5]
    result_item['startLose' + company_id] = europe_dict[company_id][6]


def get_big_or_small_result(result_item, big_or_small_dict, company_id):
    result_item['company' + company_id] = big_or_small_dict[company_id][0]
    result_item['immediateUpperStage' + company_id] = big_or_small_dict[company_id][1]
    result_item['immediateOpening' + company_id] = big_or_small_dict[company_id][2]
    result_item['immediateLowerStage' + company_id] = big_or_small_dict[company_id][3]
