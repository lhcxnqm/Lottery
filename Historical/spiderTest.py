
import requests
from lxml import etree


def get_asia_detail(match_id):
    url = "http://odds.500.com/fenxi/yazhi-{0}.shtml".format(match_id)
    headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}
    response = requests.get(url, timeout=100, headers=headers)
    response.encoding = 'gb2312'
    parser = etree.HTMLParser(encoding='gb2312')
    html = etree.HTML(response.text, parser=parser)

    host_team_guest_team = html.xpath('//ul[@class="odds_hd_list"]/li/a/text()|'
                                      '//p[@class="game_time"]/text()|'
                                      '//div[@class="odds_hd_ls"]/a[@class="hd_name"]/text()|'
                                      '//p[@class="odds_hd_bf"]/strong/text()')
    del host_team_guest_team[2]
    host_team_guest_team[1] = host_team_guest_team[1].replace(" ", "")  # 示例： 19/20德乙第18轮
    print(host_team_guest_team)

    match_dict = {}
    # companyID ：3 -->Bet365; 5 -->澳门; 280 -->皇冠; 293 -->威廉希尔
    for i in ['3', '5', '280', '293']:
        match_dict[match_id+'_'+i] = html.xpath('//tr[@id=' + i + ']/td[@class="tb_plgs"]/p/a/@title|'
                                                '//tr[@id=' + i + ']/td[3]/table/tbody/tr/node()/text()|'
                                                '//tr[@id=' + i + ']/td[4]/time/text()|'
                                                '//tr[@id=' + i + ']/td[5]/table/tbody/tr/node()/text()|'
                                                '//tr[@id=' + i + ']/td[6]/time/text()')
    print(match_dict)


if __name__ == '__main__':
    # get_asia_detail("825903")
    print(len('825903'.encode('gb2312')))
