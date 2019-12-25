import requests
from lxml import etree
import re
import datetime
from Historical import historySpider
from pandas.tseries.offsets import Day

special_match = ['欧国联', '欧罗巴', '欧洲杯', '英锦赛']


def get_asia_detail(match_id):
    url = "http://odds.500.com/fenxi/yazhi-{0}.shtml".format(match_id)
    headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}
    response = requests.get(url, timeout=20, headers=headers)
    response.encoding = 'gb2312'
    parser = etree.HTMLParser(encoding='gb2312')
    html = etree.HTML(response.text, parser=parser)

    team_message = html.xpath('//ul[@class="odds_hd_list"]/li/a/text()|'
                              '//p[@class="game_time"]/text()|'
                              '//div[@class="odds_hd_ls"]/a[@class="hd_name"]/text()|'
                              '//p[@class="odds_hd_bf"]/strong/text()')
    try:
        del team_message[2]
        team_message[1] = team_message[1].replace(" ", "")
        team_message[2] = team_message[2][4:]
        team_message.append("".join(re.findall('[\u4e00-\u9fa5]+\d+|[\u4e00-\u9fa5]+', team_message[1])))
        team_message.append(team_message[-1][3:] if team_message[-1][:3] in special_match else team_message[-1][2:])
        team_message[-2] = team_message[-2][:3] if team_message[-2][:3] in special_match else team_message[-2][:2]
    except IndexError as e:
        print(e)

    # 示例：team_message --> ['奥厄', '19/20德乙第18轮', '2019-12-21 20:00', '3:1', '菲尔特', '德乙', '第18轮']

    match_dict = {}
    # companyID ：3 -->Bet365; 5 -->澳门; 280 -->皇冠; 293 -->威廉希尔
    for i in ['3', '5', '280', '293']:
        match_dict[i] = html.xpath('//tr[@id=' + i + ']/td[@class="tb_plgs"]/p/a/@title|'
                                   '//tr[@id=' + i + ']/td[3]/table/tbody/tr/node()/text()|'
                                   '//tr[@id=' + i + ']/td[4]/time/text()|'
                                   '//tr[@id=' + i + ']/td[5]/table/tbody/tr/node()/text()|'
                                   '//tr[@id=' + i + ']/td[6]/time/text()')
        for j in [1, 3]:
            if len(match_dict[i]) > 3 and match_dict[i][j].isspace() is False:
                match_dict[i][j] = "".join(re.findall(r'[0|\d]\.\d+', match_dict[i][j]))

    # 示例：'3': ['Bet365', '0.875', '平手', '0.975', '12-21 19:49', '0.825', '平手/半球', '1.023', '12-11 23:43']
    return team_message, match_dict


def get_europe_detail(match_id):
    url = "http://odds.500.com/fenxi/ouzhi-{0}.shtml".format(match_id)
    headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}
    response = requests.get(url, timeout=20, headers=headers)
    response.encoding = 'gb2312'
    parser = etree.HTMLParser(encoding='gb2312')
    html = etree.HTML(response.text, parser=parser)

    match_dict = {}
    # companyID ：3 -->Bet365; 5 -->澳门; 280 -->皇冠; 293 -->威廉希尔
    for i in ['3', '5', '280', '293']:
        match_dict[i] = html.xpath('//tr[@id=' + i + ']/td[@class="tb_plgs"]/@title|'
                                   '//tr[@id=' + i + ']/td[3]/table/tbody/tr[1]/node()/text()|'
                                   '//tr[@id=' + i + ']/td[3]/table/tbody/tr[2]/node()/text()')

    # 示例：'3': ['Bet365', ' 2.25', '3.25', ' 3.20', '2.55', '3.25', '2.75']
    return match_dict


def get_big_or_small_detail(match_id):
    url = "http://odds.500.com/fenxi/daxiao-{0}.shtml".format(match_id)
    headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}
    response = requests.get(url, timeout=20, headers=headers)
    response.encoding = 'gb2312'
    parser = etree.HTMLParser(encoding='gb2312')
    html = etree.HTML(response.text, parser=parser)

    match_dict = {}
    # companyID ：3 -->Bet365; 5 -->澳门; 280 -->皇冠; 293 -->威廉希尔
    for i in ['3', '5', '280', '293']:
        match_dict[i] = html.xpath('//tr[@id=' + i + ']/td[@class="tb_plgs"]/p/a/@title|'
                                   '//tr[@id=' + i + ']/td[3]/table/tbody/tr/td[position()<4]/text()|'
                                   '//tr[@id=' + i + ']/td[4]/time/text()|'
                                   '//tr[@id=' + i + ']/td[5]/table/tbody/tr/node()/text()|'
                                   '//tr[@id=' + i + ']/td[6]/time/text()')
        for j in [1, 2, 3]:
            if len(match_dict[i]) > 3 and match_dict[i][j].isspace() is False:
                match_dict[i][j] = "".join(re.findall(r'[\d|\.|\/]+', match_dict[i][j]))

    # 示例： '3': ['Bet365', '0.88', '2.5', '0.98', '12-21 19:40', '0.90', '2.5', '0.95', '12-12 02:01']
    return match_dict


if __name__ == '__main__':
    # today = "2019-12-21"
    # get_history_data = historySpider.HistorySpider(today)
    # today = datetime.datetime.strptime(today, "%Y-%m-%d")
    # today = datetime.datetime.strftime(today, "%Y-%m-%d")

    # 日期转字符串
    today = datetime.date.today() - Day()
    print(today)
    pass
