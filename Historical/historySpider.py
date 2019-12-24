import requests
from lxml import etree
from Historical import getData

best_match = ['欧罗巴', '荷甲', '葡超', '日职', '日乙', '澳超',
              '意甲', '英超', '瑞超', '欧洲杯', '阿甲', '比甲',
              '挪超', '英锦赛', '德乙', '法乙', '英甲']


class HistorySpider:
    def __init__(self, date):
        self.headers = {"User-Agent": 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}
        self.date = date

    # def get_total_url(self):
    #     url = ""
    #     url_list = []
    #     for i in range(1):
    #         url_list.append(url)
    #     return url_list

    def run(self):
        # 获取url链接
        url = 'http://odds.500.com/index_history_{0}.shtml'.format(self.date)

        response = requests.get(url, headers=self.headers, timeout=50)
        response.encoding = 'gb2312'
        parser = etree.HTMLParser(encoding="gb2312")
        html = etree.HTML(response.text, parser=parser)
        # 获取当前日期下所有赛事的编号
        id_list = html.xpath('//tbody[@id="main-tbody"]/tr[@data-cid="3"]/@data-fid|'
                             '//tbody[@id="main-tbody"]/tr[@data-fid]/td[2]/a/text()')

        final_id = []
        for i in range(len(id_list) - 1):
            if id_list[i+1] in best_match:
                final_id.append(id_list[i])
            i += 2

        return final_id


if __name__ == '__main__':
    getHistoryData = HistorySpider("2019-12-26")
    getHistoryData.run()
