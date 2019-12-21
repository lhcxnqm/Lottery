import requests
from lxml import etree

# 欧罗巴 -- 欧洲联赛
# 欧国联 -- 欧洲国家联赛

best_match = ['欧洲联赛', '荷兰甲级联赛', '葡萄牙超级联赛', '欧洲国家联赛', '日本职业J1联赛', '日本职业乙级联赛', '日本天皇杯',
              '澳大利亚超级联赛', '意大利甲级联赛', '英格兰超级联赛', '瑞典超级联赛', '欧洲杯', '阿根廷甲级联赛', '西班牙国王杯',
              '比利时甲级联赛', '挪威超级联赛', '亚洲杯足球锦标赛', '英格兰锦标赛', '德国乙级联赛', '法国乙级联赛', '英格兰甲级联赛']


class HistorySpider:
    def __init__(self):
        self.headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}

    def get_total_url(self):
        url = 'http://odds.500.com/index_history_2019-12-21.shtml'
        url_list = []
        for i in range(1):
            url_list.append(url)
        return url_list

    def run(self):
        # 获取所有的history_url链接
        url_list = self.get_total_url()
        for url in url_list:
            response = requests.get(url, headers=self.headers, timeout=500)
            response.encoding = 'gb2312'
            parser = etree.HTMLParser(encoding="gb2312")
            html = etree.HTML(response.text, parser=parser)
            # 获取当前日期下所有赛事的编号
            id_list = list(set(html.xpath('//tbody[@id="main-tbody"]/tr/@data-fid')))
            match_list = html.xpath('//tbody[@id="main-tbody"]/tr[@data-fid]/td[@style]/a[@target]/@title')
            # 最终所要存储的赛事的编号
            final_id = []

            for i in range(len(match_list)):
                if match_list[i] in best_match:
                    final_id.append(id_list[i])

            # for each in id_list:
            #     subUrl = 'http://odds.500.com/fenxi/yazhi-{0}.shtml'.format(each)


if __name__ == '__main__':
    getHistoryData = HistorySpider()
    getHistoryData.run()
