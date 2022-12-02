from curses.ascii import isdigit
from distutils.log import error
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options 
from selenium.webdriver.support.select import Select
from datetime import datetime as dt
import chromedriver_binary
import os
import bs4
import requests
import pandas as pd
import numpy as np
import re
import io
import time
import json

from soupsieve import select

# jsonからidとpassを読み込む
open_json = open('./documents/JSON/sessoin.json','r')
session = json.load(open_json)
login_id=session['login_id']
pswd=session['pswd']

# 平均の連想配列を作成
time_open = open('./documents/JSON/arrange_time.json','r')
arrange_time = json.load(time_open)

# race情報のjsonを読み込む
race_json = open('./documents/JSON/race_Data.json','r')
race_data = json.load(race_json)

csv_folder = "2022_11_13/"
os.makedirs("./documents/csv/"+csv_folder, exist_ok = True)

def set_up_chrome_driver():
    # ここでいろいろやる
    options = Options() 
    options.binary_location = '/usr/bin/google-chrome' 
    #chrome binary location specified here 
    options.add_argument('--start-maximized') 
    #open Browser in maximized mode 
    options.add_argument('--no-sandbox') 
    #bypass OS security model 
    options.add_argument('--disable-dev-shm-usage') 
    #overcome limited resource problems 
    options.add_experimental_option('excludeSwitches', ['enable-automation']) 
    options.add_experimental_option('useAutomationExtension', False) 
    chrome_driver = webdriver.Chrome(options=options, executable_path=r'/usr/bin/chromedriver')
    return chrome_driver

def login_netkeiba(chrome_driver):
    chrome_driver.get('https://regist.sp.netkeiba.com/')
    time.sleep(0.1)
    chrome_driver.find_element_by_name('login_id').send_keys(login_id)
    time.sleep(0.1)
    chrome_driver.find_element_by_name('pswd').send_keys(pswd)
    time.sleep(0.1)
    chrome_driver.find_elements_by_class_name('FormItem_Submit_Btn')[0].click()
    # driver
    return chrome_driver


def get_horse_url_and_date(url):
    date = 'error'
    res_race = requests.get(url)
    # エラーチェック
    res_race.raise_for_status()
    # htmlファイルのデータ抽出
    soup_race = bs4.BeautifulSoup(res_race.content, 'lxml')
    elems = soup_race.select('a')
    smalltxt = soup_race.select('.smalltxt')[0]
    smalltxt = str(smalltxt)
    if "ハンデ" in smalltxt:
        return False, date, False
    # print(type(smalltxt))
    pos1 = smalltxt.find('>')
    # print(pos1)
    pos2 = smalltxt.find('日')
    # print(pos2)
    # date = '2222/2/22'
    date = smalltxt[pos1+1:pos2+1]
    date = date.replace('年','/')
    date = date.replace('月','/')
    date = date.replace('日','')
    if date[6] == '/':
        date = date[:5] + '0' + date[5:]
    if len(date) == 9:
        date = date[:8] + '0' + date[8:]
    print("date:",date)
    # print(elems)
    horse_list = []
    for elem in elems:
        tmp = elem.get('href')
        if '/horse/' in tmp:
            horse_list.append('https://db.netkeiba.com' + tmp)

        # elif '/race/list/' in tmp:
        #     date = tmp
        #     # 不要の物を削除
        #     date = date.replace('/race/list/', '')
        #     date = date.replace('/','')
        #     # yyyy/mm/dd表記に変換
        #     date = date[:4]+'/'+date[4:6]+'/'+date[6:]

    table_horse = soup_race.select('[class="race_table_01 nk_tb_common"]')
    # print(table_horse[4])
    with io.StringIO(str(table_horse)) as f:
        # print(f)
        df = pd.read_html(f)[0]
    house_age = [i for i in df['性齢']]
    wight_list = [i for i in df['斤量']]
    print(house_age)
    # time.sleep(10)
    return horse_list,date, house_age,wight_list

def get_race_url(chroeme_driver,word):
    chroeme_driver.get("https://db.netkeiba.com/?pid=race_top")
    chroeme_driver.find_element_by_xpath('/html/body/div[1]/div[3]/div[1]/div[1]/div[2]/form/input[2]').send_keys(word)
    # time.sleep(0.2)
    chrome_driver.find_elements_by_class_name('form_side_btn')[0].click()
    # time.sleep(0.2)
    # /html/body/div[1]/div[3]/div[1]/div[1]/div[2]/form/input[3]
    # htmlファイルのデータ抽出
    # utf変換
    html = chrome_driver.page_source.encode("utf-8")
    soup_race = BeautifulSoup(html, 'html.parser')
    elems = soup_race.select('a')
    race_list = []
    i = 0
    for elem in elems:
        tmp = elem.get('href')
        # この気持ち悪い書き方じゃないと、上手くいかない
        if type(tmp) is str:
            if '/race/2' in tmp  or '/race/199' in tmp:
                race_list.append('https://db.netkeiba.com'+tmp)
                # print(tmp)
                
    return race_list

def checkBox_search_race_url(chrome_driver, url, race_name, check_track, check_Jyo, check_kyori, check_grade):
    chrome_driver.get(url)
    # chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/table/tbody/tr[1]/td/input').send_keys(race_name)
    chrome_driver.find_element_by_id(check_track).click()
    chrome_driver.find_element_by_id(check_Jyo).click()
    chrome_driver.find_element_by_id(check_grade).click()
    chrome_driver.find_element_by_id(check_kyori).click()
    time.sleep(1)
    dropdown = chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/table/tbody/tr[11]/td/select')
    select = Select(dropdown)
    select.select_by_index(0)
    chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/div/input[1]').click()
    time.sleep(0.1)
    # utf変換
    html = chrome_driver.page_source.encode("utf-8")
    soup_race = BeautifulSoup(html, 'html.parser')
    elems = soup_race.select('a')
    # print("<a>:",elems)
    race_list = []
    for elem in elems:
        tmp = elem.get('href')
        # この気持ち悪い書き方じゃないと、上手くいかない
        if type(tmp) is str:
            if '/race/2' in tmp or '/race/199' in tmp:
                race_list.append('https://db.netkeiba.com'+tmp)
                # print(tmp)
                
    return race_list

def horse_data(chrome_driver,url):
    error_flag = False
    try:
        chrome_driver.get(url)
    except:
        error_flag = True

    if error_flag == False:
        # utf変換
        html = chrome_driver.page_source.encode("utf-8")
        soup_horse = BeautifulSoup(html, 'html.parser')
        table_horse = soup_horse.select('[class="db_h_race_results nk_tb_common"]')
        # print(table_horse[4])
        with io.StringIO(str(table_horse)) as f:
            # print(f)
            df = pd.read_html(f)[0]
        # print("\n確認\n",df)
        # print(type(df))
        return df
    return -1

def corner(x, n):
    if type(x) is int:
        return x
    elif n==4:
        return int(re.findall(r'\d+', x)[-1])
    elif n==1:
        return int(re.findall(r'\d+', x)[0])

def corner_ave(x):
    tmp = [int(i) for i in re.findall(r'\d+', x)]
    return sum(tmp) / len(tmp)

def pace(x, n):
    if type(x) is not str:
        return x
    pos = x.find("-")
    if n == 1:
        return float(x[:pos])
    return float(x[pos+1:])


def make_horse_DataFrame(chrome_driver,horse_list,date,house_age, wight_list, race_type_list, time_type_list, kyori):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均','平均タイム差','平均タイム差合計','平均タイム差平均','上り平均','勝率', '速度', '速度平均'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url,age,wight in zip(horse_list,house_age, wight_list):
        df_data_total = horse_data(chrome_driver,horse_url)
        if type(df_data_total) is not int:
            print("Success!!")
            index_date = df_data_total[df_data_total['日付'] == date].index[0]
            if len(df_data_total.columns) < 28:
                print("Nothing")
            # 現在のレースのインデックスを取得
            elif pd.notnull(df_data_total.at[index_date,'ﾀｲﾑ指数']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
                print("Get Information")
                wight_max = max(wight_list)
                df_data = df_data_total[index_date:].copy()
                df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['着差']) | pd.isnull(df_data['通過']) | pd.isnull(df_data['距離']) | pd.isnull(df_data['タイム'])].index, inplace=True)
                df_data_condision = df_data[df_data['距離'].isin(race_type_list)]
                df_data_time = df_data[df_data['距離'].isin(time_type_list)]
                df_data = df_data.reset_index(drop=True).copy()
                df_data_condision = df_data_condision.reset_index(drop=True).copy()
                df_data_time = df_data_time.reset_index(drop=True).copy()
                if len(df_data) >= 2 and len(df_data_time) >= 2 and len(df_data_condision) >= 2:
                    print(df_data)
                    # 本番着順
                    # if type(df_data['着順']) == str:
                        # ややこしいものを削除
                    df_data['平均タイム差'] = 0
                    if type(df_data.at[0,'着順']) is str:
                            df_data.at[0,'着順'] = df_data.at[0,'着順'].replace('(降)','')
                            print("着順:",df_data.at[0,'着順'])
                    # if type(df_data_condision.at[0,'着順']) is str:
                    #     df_data_condision.at[0,'着順'] = df_data_condision.at[0,'着順'].replace('(降)','')
                    #     print("着順:",df_data.at[0,'着順'])
                    time_count = 0
                    for i in range(1,len(df_data)):
                        # print("型を確認:",type(df_data.at[i,'着順']))
                        if type(df_data.at[i,'着順']) is str:
                            df_data.at[i,'着順'] = df_data.at[i,'着順'].replace('(降)','')
                            # print("着順:",df_data.at[i,'着順'])
                        # df_data.at[i,'着順'] = df_data.at[i,'着順'].astype('str').replace('(降)','')
                        # タイム差を選出
                        place = ''.join([i for i in df_data.at[i,'開催'] if not i.isdigit()])
                        # print('place:',place)
                        # print('place_and_kyori:',place_and_kyori)
                        place_and_kyori = place + df_data.at[i,'距離'] + 'm'
                        # if place_and_kyori in arrange_time:
                        # print('arrange_time:',arrange_time[place_and_kyori])
                        time_place = df_data.at[i,'タイム']
                        # time_arrange = arrange_time[place_and_kyori]
                        time_place_dt = dt.strptime(time_place, '%M:%S.%f')
                        # time_arrange_dt = dt.strptime(time_arrange, '%M:%S.%f')
                        # td = time_place_dt- time_arrange_dt
                        df_data.at[i,'秒タイム'] = time_place_dt.minute * 60 + time_place_dt.second + time_place_dt.microsecond / 1000000
                        # df_data.at[i,'平均タイム差'] = td.total_seconds()
                        # 速度
                        df_data.at[i,'速度'] = (float)(re.sub("芝|ダ","",df_data.at[i,"距離"])) / df_data.at[i,"秒タイム"]
                        # print("速度：",df_data.at[i,'速度'])
                        time_count += 1
                    df_data_condision['着順'] = df_data_condision['着順'].map(lambda x: x.replace('(降)','') if type(x) is str else x)

                    for i in range(1,len(df_data_time)):
                        df_data_time.at[i,"距離"] = (float)(re.sub("芝|ダ","",df_data_time.at[i,"距離"]))
                        time_place = df_data_time.at[i,'タイム']
                        time_place_dt = dt.strptime(time_place, '%M:%S.%f')
                        df_data_time.at[i,'秒タイム'] = (time_place_dt.minute * 60 + time_place_dt.second + time_place_dt.microsecond / 1000000) + (0.2 * (wight - df_data_time.at[i, '斤量']))

                    print(df_data_time.loc[1:,"距離"])
                    print(df_data_time.loc[1:,"秒タイム"])
                    res = np.polyfit(df_data_time.loc[1:,"距離"].astype(float), df_data_time.loc[1:,"秒タイム"], 1)
                    df_data["予想タイム"] = np.poly1d(res)(int(kyori.replace("check_kyori_",""))) + (0.2 * (wight - wight_max))

                    # 通過の抜き取り
                    df_data['最初コーナー'] = df_data['通過'].map(lambda x: corner(x, 1))
                    df_data['最終コーナー'] = df_data['通過'].map(lambda x: corner(x, 4))
                    df_data['コーナー平均'] = df_data['通過'].map(lambda x: corner_ave(x))
                    # 位置取り
                    df_data['位置取り'] = df_data['最初コーナー'] / df_data['頭数']
                    # ペースの切り取り
                    df_data['前ペース'] = df_data['ペース'].map(lambda x: pace(x, 1))
                    df_data['後ペース'] = df_data['ペース'].map(lambda x: pace(x, 4))
                    df_data_condision['前ペース'] = df_data_condision['ペース'].map(lambda x: pace(x, 1))
                    df_data_condision['後ペース'] = df_data_condision['ペース'].map(lambda x: pace(x, 4))
                    # print("前ペース")
                    # print(df_data['前ペース'])
                    # print("後ペース")
                    # print(df_data['後ペース'])
                    df_data['上り-前ペース'] = df_data['上り'] - df_data['前ペース']
                    df_data['上り-後ペース'] = df_data['上り'] - df_data['後ペース']
                    df_data['前ペース-後ペース'] = df_data['前ペース'] - df_data['後ペース']

                    try:
                        df_data['前ペース平均'] = sum(df_data_condision.loc[1:,'前ペース']) / len(df_data_condision.loc[1:,'前ペース'])
                    except ZeroDivisionError:
                        df_data['前ペース平均'] = 0
                    try:
                        df_data['後ペース平均'] = sum(df_data_condision.loc[1:,'後ペース']) / len(df_data_condision.loc[1:,'後ペース'])
                    except ZeroDivisionError:
                        df_data['後ペース平均'] = 0
                    try:
                        df_data['コーナー平均平均'] = sum(df_data.loc[1:,'コーナー平均']) / len(df_data.loc[1:,'コーナー平均'])
                    except ZeroDivisionError:
                        df_data['コーナー平均平均'] = 0

                    try:
                        df_data['上り-前ペース平均'] = sum(df_data.loc[1:,'上り-前ペース']) / len(df_data.loc[1:,'上り-前ペース'])
                    except ZeroDivisionError:
                        df_data['上り-前ペース平均'] = 0
                    try:
                        df_data['上り-後ペース平均'] = sum(df_data.loc[1:,'上り-後ペース']) / len(df_data.loc[1:,'上り-後ペース'])
                    except ZeroDivisionError:
                        df_data['上り-後ペース平均'] = 0
                    try:
                        df_data['前ペース-後ペース平均'] =  sum(df_data.loc[1:,'前ペース-後ペース']) / len(df_data.loc[1:,'前ペース-後ペース'])                  
                    except ZeroDivisionError:
                        df_data['前ペース-後ペース平均'] = 0

                    df_data['最終コーナーから着順'] = df_data['最終コーナー'] - df_data['着順'].astype('int')
                    df_data['最初コーナーから着順'] = df_data['最初コーナー'] - df_data['着順'].astype('int')
                    df_data['最初コーナーから最終コーナー'] = df_data['最初コーナー'] - df_data['最終コーナー']

                    try:
                        df_data['位置取り平均'] = sum(df_data.loc[1:,'位置取り'] / df_data.loc[1:,'頭数']) / len(df_data.loc[1:,'位置取り'])
                    except ZeroDivisionError:
                        df_data['位置取り平均'] = 0
                    try:
                        df_data['最終コーナー平均'] = sum(df_data.loc[1:,'最終コーナー']) / len(df_data.loc[1:,'最終コーナー'])
                    except ZeroDivisionError:
                        df_data['最終コーナー平均'] = 0
                    try:
                        df_data['最初コーナー平均'] = sum(df_data.loc[1:,'最初コーナー']) / len(df_data.loc[1:,'最初コーナー'])
                    except ZeroDivisionError:
                        df_data['最初コーナー平均'] = 0

                    try:
                        df_data['最終コーナーから着順平均'] = sum(df_data.loc[1:,'最終コーナーから着順']) / len(df_data.loc[1:,'最終コーナーから着順'])
                    except ZeroDivisionError:
                        df_data['最終コーナーから着順平均'] = 0

                    try:
                        df_data['最初コーナーから着順平均'] = sum(df_data.loc[1:,'最初コーナーから着順']) / len(df_data.loc[1:,'最初コーナーから着順'])
                    except ZeroDivisionError:
                        df_data['最初コーナーから着順平均'] = 0

                    try:
                        df_data['最初コーナーから最終コーナー平均'] = sum(df_data.loc[1:,'最初コーナーから最終コーナー']) / len(df_data.loc[1:,'最初コーナーから最終コーナー'])
                    except ZeroDivisionError:
                        df_data['最初コーナーから最終コーナー平均'] = 0

                    try:
                        df_data['ﾀｲﾑ指数偏差'] = np.std( df_data['ﾀｲﾑ指数'])
                    except:
                        df_data['ﾀｲﾑ指数偏差'] = 0

                    try:
                        df_data['上り偏差'] = np.std( df_data['上り'])
                    except:
                        df_data['上り偏差'] = 0


                    # df_data.drop(df_data.loc[pd.isnull(df_data['平均タイム差'])].index, inplace=True)
                    # df_data['平均タイム差合計'] = sum(df_data.loc[1:,'平均タイム差'])
                    # try:
                    #     df_data['平均タイム差平均'] = df_data['平均タイム差合計'] / time_count
                    # except ZeroDivisionError:
                    #     df_data['平均タイム差平均'] = 0

                    # 年齢
                    try:
                        df_data['本番年齢'] = re.sub(r"\D", "", age)
                    except:
                        df_data['本番年齢'] = 0

                    # print('-----着順---------:',df_data.at[index_date,'着順'])
                    df_data['本番着順'] = df_data.at[0,'着順']
                    df_data['本番オッズ'] = df_data.at[0,'オッズ']
                    # 合計賞金
                    df_data_condision["賞金"] = df_data_condision["賞金"].fillna(0)
                    df_data_condision['合計賞金'] = sum(df_data_condision.loc[1:,'賞金'])
                    # 賞金平均
                    try:
                        df_data['賞金平均'] = df_data_condision.loc[1:,'合計賞金'] / len(df_data_condision.loc[1:,'合計賞金'])
                    except ZeroDivisionError:
                        df_data['賞金平均'] = 0
                    # 着差平均
                    df_data_condision['着差_調整'] = df_data_condision['着差'].map(lambda x: x / 2 if x < 0 else x)
                    df_data['着差_調整'] = df_data['着差'].map(lambda x: x / 2 if x < 0 else x)
                    try:
                        df_data['着差平均_condision'] = sum(df_data_condision.loc[1:,'着差_調整']) / len(df_data_condision.loc[1:,'着差_調整'])
                    except ZeroDivisionError:
                        df_data['着差平均_condision'] = 0.6
                    try:
                        df_data['着差平均'] = sum(df_data.loc[1:,'着差_調整']) / len(df_data.loc[1:,'着差_調整'])
                    except ZeroDivisionError:
                        df_data['着差平均'] = 0.6
                    try:
                        df_data['上り平均'] = sum(df_data_condision.loc[1:,'上り']) / len(df_data_condision.loc[1:,'上り'])
                    except ZeroDivisionError:
                        df_data['上り平均'] = 40
                    try:
                        df_data_condision['ペース平均'] = (df_data_condision['上り'] +  df_data_condision['後ペース'] + df_data_condision['前ペース'])/ 3
                    except ZeroDivisionError:
                        df_data_condision['ペース平均'] = 40
                    try:
                        df_data['上がりハロン平均'] = sum(df_data_condision.loc[1:,'ペース平均']) / len(df_data_condision.loc[1:,'ペース平均'])
                    except ZeroDivisionError:
                        df_data['上がりハロン平均'] = 40

                    df_data['ﾀｲﾑ指数_調整'] = df_data['ﾀｲﾑ指数'].map(lambda x: x - 80)
                    df_data['ﾀｲﾑ指数_調整_合計'] = sum(df_data.loc[1:,'ﾀｲﾑ指数_調整'])
                    # タイム指数平均
                    index_tyakusa = df_data[pd.isnull(df_data['ﾀｲﾑ指数'])].index
                    df_data['ﾀｲﾑ指数'].replace(np.nan,0)
                    try:
                        df_data['ﾀｲﾑ指数平均'] = sum(df_data_condision.loc[1:,'ﾀｲﾑ指数']) / len(df_data_condision.loc[1:,'ﾀｲﾑ指数'])
                        # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
                    except ZeroDivisionError:
                        df_data['ﾀｲﾑ指数平均'] = 80
                    try:
                        df_data['ﾀｲﾑ指数3平均'] = sum(df_data.loc[1:4,'ﾀｲﾑ指数']) / len(df_data.loc[1:4,'ﾀｲﾑ指数'])
                        # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
                    except ZeroDivisionError:
                        df_data['ﾀｲﾑ指数3平均'] = 0
                    # BTmodel風のことをする
                    total = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - len(df_data_condision[1:])
                    win = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - sum(df_data_condision.loc[1:,'着順'].astype('int'))
                    try:
                        df_data['勝率'] = win / total
                    except ZeroDivisionError:
                        df_data['勝率'] = 0
                    try:
                        df_data['速度平均'] = sum(df_data.loc[1:,'速度']) / time_count
                    except ZeroDivisionError:
                        df_data['速度平均'] = 0
                    print(df_data[1:2])
                    df_horse = pd.concat([df_horse,df_data[1:2]], ignore_index=True)
                    print("df_horse:",df_horse)
                else:
                    print("Less Information")
            else:
                print("Not Get")
    return df_horse


def write_csv(df,csv_file):
    # Nanを削除
    # df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | (df['本番着順'] == '中') | (df['本番着順'] == '取') | (df['本番着順'] == '除') | (df['本番着順'] == '降')].index, inplace=True)
    df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数平均']) | pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | pd.isnull(df['着差平均']) | (df['本番着順'].str.match('[^0-9]+'))].index, inplace=True)
    df = df.reset_index()
    # df.to_csv('./test.csv')
    # csv_file = './documents/csv/'+race+'.csv'
    df.to_csv(csv_file)

def set_column_race_type(check_track,check_kyori):
    race_type_list = []
    time_type_list = []
    if check_track == "check_track_1":
        track_type = "芝"
    elif check_track == "check_track_2":
        track_type = "ダ"
    kyori = int(check_kyori.replace("check_kyori_",""))
    for add_kyori in [-200, -100, 0, 100, 200]:
        race_type_list.append(track_type+str(kyori+add_kyori))
    for add_kyori in [-400,-300,-200, -100, 0, 100, 200, 300, 400]:
        time_type_list.append(track_type+str(kyori+add_kyori))
    return race_type_list, time_type_list

if __name__=='__main__':
    chrome_driver = set_up_chrome_driver()
    login_netkeiba(chrome_driver)
    for race_name in race_data:
    # for race_name in ["宝塚記念"]:
        race_list = checkBox_search_race_url(chrome_driver,"https://db.netkeiba.com/?pid=race_search_detail",race_name , race_data[race_name]['check_track'], race_data[race_name]['check_Jyo'], race_data[race_name]['check_kyori'], race_data[race_name]['check_grade'])
        # print(race_list)
        df_total = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均','平均タイム差','平均タイム差合計','平均タイム差平均','上り平均','勝率', '速度', '速度平均'])
        for race in race_list:
            # chrome_driver.get(race)
            print(race)
            try:
                house_list,date,house_age,wight_list = get_horse_url_and_date(race)
                if date != 'error':
                    race_type_list, time_type_list = set_column_race_type(race_data[race_name]['check_track'], race_data[race_name]['check_kyori'])
                    print(race_type_list)
                    df_horse = make_horse_DataFrame(chrome_driver, house_list, date,house_age,wight_list, race_type_list, time_type_list, race_data[race_name]['check_kyori'])
                    df_total = pd.concat([df_total,df_horse], ignore_index=True)
                    # print("error")紐
            except:
                print("get_info_error")
        print("-------------")
        csv_file = "./documents/csv/"+csv_folder+race_name+".csv"
        write_csv(df_total, csv_file)
        print(df_total)
    chrome_driver.quit()