from Historical import historySpider, getData
import MySQLdb
import datetime
from datetime import timedelta
from multiprocessing.dummy import Pool as ThreadPool
import time


def save_message(matchID, asia_dict, big_or_small_dict, europe_dict, each, company):
    db = MySQLdb.connect("localhost", "root", "admin", "football", charset='utf8')
    cursor = db.cursor()

    # 存储亚盘信息
    try:
        asia_sql = "insert into historical_asia(company, immediateUpperStage, immediateLowerStage, immediateOpening, " \
                   "startUpperStage, startLowerStage, startOpening, changedTime, startTime, subMatchId_id) " \
                   "values('%s','%s','%s','%s','%s','%s','%s','%s','%s',%d)" % \
                   (company, asia_dict[each][1], asia_dict[each][3], asia_dict[each][2], asia_dict[each][5],
                    asia_dict[each][7], asia_dict[each][6], asia_dict[each][4], asia_dict[each][8], int(matchID))
        cursor.execute(asia_sql)
        db.commit()
    except IndexError:
        pass

    # 存储大小球信息
    try:
        size_sql = "insert into historical_bigorsmall(company, immediateUpperStage, immediateLowerStage, " \
                   "immediateOpening,startUpperStage,startLowerStage,startOpening,changedTime,startTime,subMatchId_id) " \
                   "values('%s','%s','%s','%s','%s','%s','%s','%s','%s',%d)" % \
                   (company, big_or_small_dict[each][1], big_or_small_dict[each][3], big_or_small_dict[each][2],
                    big_or_small_dict[each][5], big_or_small_dict[each][7], big_or_small_dict[each][6],
                    big_or_small_dict[each][4], big_or_small_dict[each][8], int(matchID))
        cursor.execute(size_sql)
        db.commit()
    except IndexError:
        pass

    # 存储欧盘信息
    try:
        europe_sql = "insert into historical_european(company, immediateWin, immediatePeace, immediateLose, startWin, " \
                     "startPeace, startLose, subMatchId_id) " \
                     "values('%s', '%s', '%s', '%s', '%s', '%s', '%s', %d)" % \
                     (company, europe_dict[each][1], europe_dict[each][2], europe_dict[each][3], europe_dict[each][4],
                      europe_dict[each][5], europe_dict[each][6], int(matchID))
        cursor.execute(europe_sql)
        db.commit()
    except IndexError:
        pass
    db.close()


def start_save(matchID, priorDay):
    db = MySQLdb.connect("localhost", "root", "admin", "football", charset='utf8')
    cursor = db.cursor()

    team_message, asia_dict = getData.get_asia_detail(matchID)
    # 存储赛事基本信息
    try:
        team_sql = "insert into historical_history values(%d,'%s','%s','%s','%s','%s','%s','%s')" % \
                   (int(matchID), team_message[5], team_message[6], priorDay, team_message[2],
                    team_message[0], team_message[4], team_message[3])
        cursor.execute(team_sql)
        db.commit()

        big_or_small_dict = getData.get_big_or_small_detail(matchID)
        europe_dict = getData.get_europe_detail(matchID)
        for each in ['3', '5', '280', '293']:
            if asia_dict[each] and '3'.__eq__(each):
                save_message(matchID, asia_dict, big_or_small_dict, europe_dict, each, 'Bet365')
            elif asia_dict[each] and '5'.__eq__(each):
                save_message(matchID, asia_dict, big_or_small_dict, europe_dict, each, '澳门')
            elif asia_dict[each] and '280'.__eq__(each):
                save_message(matchID, asia_dict, big_or_small_dict, europe_dict, each, '皇冠')
            else:
                save_message(matchID, asia_dict, big_or_small_dict, europe_dict, each, '威廉希尔')
        print('inserted' + matchID)
    except IndexError:
        print('编号' + matchID + ' 官方信息缺失，不做存储')
    except MySQLdb.IntegrityError as e:
        print(e)

    db.close()


def temp_save(x):
    return start_save(x[0], x[1])


def gen_dates(b_date, days):
    day = timedelta(days=1)
    # print(day)
    for i in range(days):
        # print(b_date + day*i)
        yield b_date + day*i


def get_date_list(start_date, end_date):   # 两个日期之间的所有日期，包括开始日期， 包括结束日期
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


if __name__ == '__main__':      # 已完成 2016-2019
    start_date = '2015-12-01'
    end_date = '2015-12-31'
    date_list = get_date_list(start_date, end_date)
    time1 = time.time()

    for prior_day in date_list:
        sql = "select * from historical_history where time = '{0}'".format(prior_day)
        db = MySQLdb.connect("localhost", "root", "admin", "football", charset='utf8')
        cursor = db.cursor()
        cursor.execute(sql)
        if not cursor.rowcount:     # 先判断XX日是否有记录，如果没有，则爬取数据
            pool = ThreadPool(4)  # 四核处理
            total_match = []

            print('no data in %s, start to scrap and save to MySQL' % prior_day)
            getHistoryData = historySpider.HistorySpider(prior_day)
            final_id = getHistoryData.run()     # 获取XX日所有比赛的编号
            for match_id in final_id:
                temp = (match_id, prior_day)
                total_match.append(temp)
                # start_save(match_id, prior_day)
            pool.map(temp_save, total_match)
            pool.close()
            pool.join()
            print('finished ' + prior_day)
        else:
            print(prior_day + ' already have data')

        db.close()

    time2 = time.time()
    print('总共耗时：' + str(time2 - time1) + 's')