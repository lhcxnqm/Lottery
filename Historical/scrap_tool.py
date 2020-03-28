from Historical import historySpider, getData
import MySQLdb
import datetime
from datetime import timedelta


def save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, company):
    try:
        # 存储亚盘信息
        pass
        # 存储大小球信息

        # 存储欧盘信息

    except IndexError:
        pass


def start_save(match_id, prior_day):
    team_message, asia_dict = getData.get_asia_detail(match_id)

    # 存储赛事基本信息
    db = MySQLdb.connect("localhost", "root", "admin", "football", charset='utf8')
    cursor = db.cursor()
    sql = "insert into historical_history values(%d,'%s','%s','%s','%s','%s','%s','%s')" % \
          (int(match_id), team_message[5], team_message[6], prior_day, team_message[2],
           team_message[0], team_message[4], team_message[3])
    try:
        cursor.execute(sql)
        db.commit()
        print('inserted' + match_id)
    except IndexError:
        pass
    db.close()

    # big_or_small_dict = getData.get_big_or_small_detail(match_id)
    # europe_dict = getData.get_europe_detail(match_id)
    # for each in ['3', '5', '280', '293']:
    #     if asia_dict[each] and '3'.__eq__(each):
    #         save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, 'Bet365')
    #     elif asia_dict[each] and '5'.__eq__(each):
    #         save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '澳门')
    #     elif asia_dict[each] and '280'.__eq__(each):
    #         save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '皇冠')
    #     else:
    #         save_message(match_id, asia_dict, big_or_small_dict, europe_dict, each, '威廉希尔')


def gen_dates(b_date, days):
    day = timedelta(days=1)
    # print(day)
    for i in range(days):
        # print(b_date + day*i)
        yield b_date + day*i


def get_date_list(start_date, end_date):   # 两个日期之间的所有日期，包括开始日期， 包括 结束日期
    """
    获取日期列表
    :param start: 开始日期
    :param end: 结束日期
    :return:
    """
    if start_date is not None:
        start = datetime.datetime.strptime(start_date, "%Y-%m-%d")
    if end_date is None:
        end = datetime.datetime.now()
    else:
        end = datetime.datetime.strptime(end_date, "%Y-%m-%d")
    data = []
    for d in gen_dates(start, ((end-start).days + 1)):    # 29 + 1
        # print(d)   # datetime.datetime  类型
        data.append(d.strftime("%Y-%m-%d"))
    return data


if __name__ == '__main__':
    start_date = '2019-12-01'
    end_date = '2019-12-31'
    date_list = get_date_list(start_date, end_date)
    for prior_day in date_list:
        sql = "select * from historical_history where time = '{0}'".format(prior_day)
        # db = MySQLdb.connect("localhost", "root", "admin", "football", charset='utf8')
        # cursor = db.cursor()
        # cursor.execute(sql)
        # if not cursor.rowcount:     # 先判断XX日是否有记录，如果没有，则爬取数据
        #     db.close()
        #     print('no data in %s, start to scrap and save to MySQL' % prior_day)
        #     getHistoryData = historySpider.HistorySpider(prior_day)
        #     final_id = getHistoryData.run()     # 获取XX日所有比赛的编号
        #     for match_id in final_id:
        #         start_save(match_id, prior_day)
        #     print('finished ' + prior_day)
        # else:
        #     db.close()
        #     print(prior_day + 'have data')
