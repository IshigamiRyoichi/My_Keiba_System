from flask import Flask, request, session, g, redirect, url_for, abort, render_template
import io
import numpy as np
import pandas as pd
from keras.models import  load_model
from selenium.webdriver.chrome.options import Options 
from bs4 import BeautifulSoup
import bs4
from selenium import webdriver
import requests
import json
import re
from datetime import datetime as dt
import time

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

# ranknetの読み込み
# ranknet = load_model("./documents/keiba_ranknet_model")
ranknet = load_model("./documents/model/2023_4_02/阪神2R_model")

def set_up_chrome_driver():
    # ここでいろいろやる
    options = Options() 
    options.binary_location = '/usr/bin/google-chrome' 
    #chrome binary location specified here 
    options.add_argument('--start-maximized') 
    options.add_argument('--headless')
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
    chrome_driver.find_element_by_name('login_id').send_keys(login_id)
    # time.sleep(0.5)
    chrome_driver.find_element_by_name('pswd').send_keys(pswd)
    # time.sleep(0.5)
    chrome_driver.find_elements_by_class_name('FormItem_Submit_Btn')[0].click()

# 正規化関数
def regularization(df):
    return (df - df.min()) / (df.max() - df.min())

# 標準化関数
def standardization(df):
    return (df - df.mean()) / df.std()

# 馬のデータのurlをリスト化
# 日付も取得
def get_horse_url(url):
    # date = 'error'
    res_race = requests.get(url)
    # エラーチェック
    res_race.raise_for_status()
    # htmlファイルのデータ抽出
    soup_race = bs4.BeautifulSoup(res_race.content, 'lxml')
    elems = soup_race.select('a')
    # smalltxt = soup_race.select('.smalltxt')[0]
    # smalltxt = str(smalltxt)
    # # print(type(smalltxt))
    # pos1 = smalltxt.find('>')
    # # print(pos1)
    # pos2 = smalltxt.find('日')
    # # print(pos2)
    # # date = '2222/2/22'
    # date = smalltxt[pos1+1:pos2+1]
    # date = date.replace('年','/')
    # date = date.replace('月','/')
    # date = date.replace('日','')
    # if date[6] == '/':
    #     date = date[:5] + '0' + date[5:]
    # if len(date) == 9:
    #     date = date[:8] + '0' + date[8:]
    # print("date:",date)
    # print(elems)
    horse_list = []
    for elem in elems:
        tmp = elem.get('href')
        if '/horse/' in tmp:
            horse_list.append(tmp)

        # elif '/race/list/' in tmp:
        #     date = tmp
        #     # 不要の物を削除
        #     date = date.replace('/race/list/', '')
        #     date = date.replace('/','')
        #     # yyyy/mm/dd表記に変換
        #     date = date[:4]+'/'+date[4:6]+'/'+date[6:]
    # print('date:',date)
    table_horse = soup_race.select('table')
    print(len(table_horse))
    # print("===========")
    # print(table_horse[0])
    # print("===========")
    # print(table_horse[2])
    # print("===========")
    # print(table_horse[3])
    # print("===========")
    # print(table_horse[4])
    # # print("===========")
    # with io.StringIO(str(table_horse[0])) as f:
    #     print("================table===========")
    #     print(f)
    #     print("================table===========")
    df = pd.read_html(str(table_horse[0]))[0]
    df.columns = df.columns.droplevel(1)
    print(df)
    house_age = [i for i in df['性齢']]
    wight_list = [i for i in df['斤量']]
    print("=====hourse_age=====")
    print(house_age)
    print("=====================")
    race_info = soup_race.select('.RaceData01')
    pos1 = str(race_info).find('<span>')+7
    pos2 = str(race_info).find('</span>')
    race_type = str(race_info)[pos1:pos2]
    race_type_list = []
    time_type_list = []
    if "芝" in race_type:
        track_type = "芝"
    elif "ダ" in race_type:
        track_type = "ダ"
    kyori = int(re.findall(r'\d+', race_type)[0])
    # print(kyori)
    for add_kyori in [-200, -100, 0, 100, 200]:
        race_type_list.append(track_type+str(kyori+add_kyori))
    for add_kyori in [-400,-300,-200, -100, 0, 100, 200, 300, 400]:
        time_type_list.append(track_type+str(kyori+add_kyori))
    return horse_list,house_age,race_type_list,time_type_list,wight_list,str(kyori)

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
    # if "ハンデ" in smalltxt:
    #     return False, date, False
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
    print("this_date:",date)
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
    # time.sleep(1)
    return horse_list,date, house_age,wight_list

# 馬データを取得
def horse_data(chrome_driver,url):
    error_flag = False
    try:
        chrome_driver.get(url)
    except:
        print("True")
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
        print("\n確認\n",df)
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


def cheack_make_horse_DataFrame(chrome_driver,horse_list,date, house_age):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均','平均タイム差','平均タイム差合計','平均タイム差平均','上り平均','勝率'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url,age in zip(horse_list,house_age):
        df_data_total = horse_data(chrome_driver,horse_url)
        if type(df_data_total) is not int:
            print("Success!!")
            index_date = df_data_total[df_data_total['日付'] == date].index[0]
            if len(df_data_total.columns) < 28:
                print("Nothing")
            # 現在のレースのインデックスを取得
            elif pd.notnull(df_data_total.at[index_date,'ﾀｲﾑ指数']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
                df_data = df_data_total[index_date:].copy()
                df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['着差']) | pd.isnull(df_data['通過'])].index, inplace=True)
                df_data = df_data.reset_index(drop=True).copy()
                print(df_data)
                df_data['本番馬番'] = df_data.at[0,'馬番']
                # 本番着順
                # if type(df_data['着順']) == str:
                    # ややこしいものを削除
                df_data['平均タイム差'] = 0
                if type(df_data.at[0,'着順']) is str:
                        df_data.at[0,'着順'] = df_data.at[0,'着順'].replace('(降)','')
                        print("着順:",df_data.at[0,'着順'])
                time_count = 0
                for i in range(1,len(df_data)):
                    print("型を確認:",type(df_data.at[i,'着順']))
                    if type(df_data.at[i,'着順']) is str:
                        df_data.at[i,'着順'] = df_data.at[i,'着順'].replace('(降)','')
                        print("着順:",df_data.at[i,'着順'])
                    # df_data.at[i,'着順'] = df_data.at[i,'着順'].astype('str').replace('(降)','')
                    # タイム差を選出
                    place = ''.join([i for i in df_data.at[i,'開催'] if not i.isdigit()])
                    # print('place:',place)
                    place_and_kyori = place + df_data.at[i,'距離'] + 'm'
                    # print('place_and_kyori:',place_and_kyori)
                    if place_and_kyori in arrange_time:
                        print('arrange_time:',arrange_time[place_and_kyori])
                        time_place = df_data.at[i,'タイム']
                        time_arrange = arrange_time[place_and_kyori]
                        time_place = dt.strptime(time_place, '%M:%S.%f')
                        time_arrange = dt.strptime(time_arrange, '%M:%S.%f')
                        td = time_place- time_arrange
                        df_data.at[i,'平均タイム差'] = td.total_seconds()
                        time_count += 1

                # 通過の抜き取り
                df_data['最初コーナー'] = df_data['通過'].map(lambda x: corner(x, 1))
                df_data['最終コーナー'] = df_data['通過'].map(lambda x: corner(x, 4))

                df_data['最終コーナーから着順'] = df_data['最終コーナー'] - df_data['着順'].astype('int')
                df_data['最初コーナーから着順'] = df_data['最初コーナー'] - df_data['着順'].astype('int')
                df_data['最初コーナーから最終コーナー'] = df_data['最初コーナー'] - df_data['最終コーナー']

                try:
                    df_data['最終コーナー平均'] = sum(df_data.loc[1:,'最終コーナー']) / len(df_data.loc[1:,'最終コーナー'])
                except ZeroDivisionError:
                    df_data['最終コーナー平均'] = 0

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


                # df_data.drop(df_data.loc[pd.isnull(df_data['平均タイム差'])].index, inplace=True)
                df_data['平均タイム差合計'] = sum(df_data.loc[1:,'平均タイム差'])
                try:
                    df_data['平均タイム差平均'] = df_data['平均タイム差合計'] / time_count
                except ZeroDivisionError:
                    df_data['平均タイム差平均'] = 0

                # 年齢
                try:
                    df_data['本番年齢'] = re.sub(r"\D", "", age)
                except:
                    df_data['本番年齢'] = 0

                # print('-----着順---------:',df_data.at[index_date,'着順'])
                df_data['本番着順'] = df_data.at[0,'着順']
                # 合計賞金
                df_data["賞金"] = df_data["賞金"].fillna(0)
                df_data['合計賞金'] = sum(df_data.loc[1:,'賞金'])
                # 賞金平均
                try:
                    df_data['賞金平均'] = df_data.loc[1:,'合計賞金'] / len(df_data.loc[1:,'合計賞金'])
                except ZeroDivisionError:
                    df_data['賞金平均'] = 0
                # 着差平均
                df_data['着差'] = df_data['着差'].map(lambda x: 0 if x < 0 else x)
                try:
                    df_data['着差平均'] = sum(df_data.loc[1:,'着差']) / len(df_data.loc[1:,'着差'])
                except ZeroDivisionError:
                    df_data['着差平均'] = 0
                try:
                    df_data['上り平均'] = sum(df_data.loc[1:,'上り']) / len(df_data.loc[1:,'上り'])
                except ZeroDivisionError:
                    df_data['上り平均'] = 0
                # タイム指数平均
                index_tyakusa = df_data[pd.isnull(df_data['ﾀｲﾑ指数'])].index
                df_data['ﾀｲﾑ指数'].replace(np.nan,0)
                try:
                    df_data['ﾀｲﾑ指数平均'] = sum(df_data.loc[1:,'ﾀｲﾑ指数']) / len(df_data.loc[1:,'ﾀｲﾑ指数'])
                    # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
                except ZeroDivisionError:
                    df_data['ﾀｲﾑ指数平均'] = 0
                # BTmodel風のことをする
                total = sum(df_data.loc[1:,'頭数'].astype('int')) - len(df_data[1:])
                win = sum(df_data.loc[1:,'頭数'].astype('int')) - sum(df_data.loc[1:,'着順'].astype('int'))
                try:
                    df_data['勝率'] = win / total
                except ZeroDivisionError:
                    df_data['勝率'] = 0
                print(df_data[0:1])
                df_horse = pd.concat([df_horse,df_data[0:1]], ignore_index=True)
                print("============df_horse==============")
                print("df_horse:",df_horse)
    return df_horse

# 馬データを取得
def house_data(chrome_driver,url):
    error_flag = False
    print(url)
    try:
        chrome_driver.get(url)
    except:
        print("True")
        error_flag = True

    if error_flag == False:
        try:
            # utf変換
            html = chrome_driver.page_source.encode("utf-8")
            soup_horse = BeautifulSoup(html, 'html.parser')
            # print(soup_horse)
            table_horse = soup_horse.select('[class="db_h_race_results nk_tb_common"]')
            # print(table_horse)
            with io.StringIO(str(table_horse)) as f:
                # print(f)
                df = pd.read_html(f)[0]
            # print("\n確認\n",df)
            elems = soup_horse.select('a')
            partner_race_list = []
            race_count = 0
            for elem in elems:
                tmp = elem.get('href')
                if '/race/2' in tmp or '/race/199' in tmp:
                    # print("========")
                    # print(tmp)
                    # print("========")
                    if race_count >= 0 and race_count < 2:
                        partner_race_list.append('https://db.netkeiba.com'+tmp)
                        print("=======check======")
                        print(partner_race_list)
                        # time.sleep(1.0)
                    else:
                        break
                    race_count = race_count + 1
            # print(type(df))
            return df,partner_race_list
        except:
            print("=======partner_error==========")
            return -1,-1
    return -1,-1

def make_horse_DataFrame(chrome_driver,house_list, house_age, race_type_list,time_type_list,wight_list,kyori):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    house_index = 0
    for horse_url,age,wight in zip(house_list,house_age, wight_list):
        print("=========url============")
        print(horse_url)
        df_data, partner_race_list = house_data(chrome_driver,horse_url)
        print("======partner===========")
        print(partner_race_list)
        house_index = house_index + 1
        print(df_data)
        if type(df_data) is not int:
            print("Success!!")
            if len(df_data.columns) < 20:
                print("Nothing")
            # 現在のレースのインデックスを取得
            else:
                print("Get Information")
                wight_max = max(wight_list)
                df_data.drop(df_data.loc[pd.isnull(df_data['着差']) | pd.isnull(df_data['上り']) | pd.isnull(df_data['距離']) | pd.isnull(df_data['タイム'])].index, inplace=True)
                df_data = df_data.reset_index(drop=True).copy()
                for i in range(1,len(df_data)):
                    # print("型を確認:",type(df_data.at[i,'着順']))
                    if type(df_data.at[i,'着順']) is str:
                        df_data.at[i,'着順'] = df_data.at[i,'着順'].replace('(降)','')
                df_data_condision = df_data[df_data['距離'].isin(race_type_list)]
                df_data_time = df_data[df_data['距離'].isin(time_type_list)]
                # df_data_speed = df_data[(df_data['上り'] >= min_speed) & (df_data['上り'] <= max_speed)]
                df_data_condision = df_data_condision.reset_index(drop=True).copy()
                df_data_time = df_data_time.reset_index(drop=True).copy()
                if len(df_data) >= 2 and len(df_data_time) >= 2 and len(df_data_condision) >= 2:
                    # 斤量とタイム
                    # print(df_data_time)
                    drop_list = []
                    for i in range(1,len(df_data_time)):
                        # 斤量とタイム、上り    
                        # print(df_data_time)
                        drop_list = []
                        for i in range(1,len(df_data_time)):
                            try:
                                # 斤量とタイム
                                place = ''.join([i for i in df_data_time.at[i, '開催'] if not i.isdigit()])
                                place_and_kyori = place + df_data_time.at[i,'距離']
                                time_arrange = arrange_time[place_and_kyori]
                                time_place_dt = dt.strptime(df_data_time.at[i,'タイム'], '%M:%S.%f')
                                time_arrange_dt = dt.strptime(time_arrange, '%M:%S.%f')
                                td = time_place_dt- time_arrange_dt
                                df_data_time.at[i,'タイム差'] = td.total_seconds() + (0.2 * (wight - df_data_time.at[i, '斤量']))
                                df_data_time.at[i,"距離のみ"] = (float)(re.sub("芝|ダ","",df_data_time.at[i,"距離"]))
                                # print(df_data_time["距離のみ"])
                                # 上り
                                speed_df = pd.read_csv('./documents/csv/speed_means.csv')
                                arrange_speed = speed_df.loc[speed_df["開催所"] == place_and_kyori, "平均上り"]
                                this_speed = df_data_time.at[i, "上り"]
                                df_data_time.at[i, "上り差"] = float(arrange_speed - this_speed)  

                            except:
                                drop_list.append(i)
                        # try:
                        df_data_time.drop(df_data_time.index[drop_list], inplace=True)
                        df_data_time = df_data_time.reset_index(drop=True).copy()
                        res = np.polyfit(df_data_time.loc[1:,"距離のみ"].astype(float), df_data_time.loc[1:,"タイム差"], 1)
                        df_data["予想タイム差"] = np.poly1d(res)(int(kyori.replace("check_kyori_",""))) + (0.2 * (wight - wight_max))
                        # except:
                        #     df_data["予想タイム差"] = "Not Found"
                        #     print("error m")
                    # 距離基準による着差平均
                    df_data_condision['着差_調整'] = df_data_condision['着差'].map(lambda x: x / 2 if x < 0 else x)
                    try:
                        df_data['着差平均_condision'] = sum(df_data_condision.loc[1:,'着差_調整']) / len(df_data_condision.loc[1:,'着差_調整'])
                    except ZeroDivisionError:
                        df_data['着差平均_condision'] = 1.0
                    try:
                        df_data['上り差平均'] = sum(df_data_time.loc[1:,'上り差']) / len(df_data_time.loc[1:,'上り差'])
                    except ZeroDivisionError:
                        df_data['上り差'] = 1.0
                    # 距離基準による勝率
                    total = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - len(df_data_condision[1:])
                    win = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - sum(df_data_condision.loc[1:,'着順'].astype('int'))
                    try:
                        df_data['勝率_condision'] = win / total
                    except ZeroDivisionError:
                        df_data['勝率_condision'] = 0
                    # 上り基準による着差平均
                    # df_data_speed['着差_調整'] = df_data_speed['着差'].map(lambda x: x / 2 if x < 0 else x)
                    # try:
                    #     df_data['着差平均_speed'] = sum(df_data_speed.loc[1:,'着差_調整']) / len(df_data_speed.loc[1:,'着差_調整'])
                    # except ZeroDivisionError:
                    #     df_data['着差平均_speed'] = 1.0
                    # # 上り基準による勝率
                    # total = sum(df_data_speed.loc[1:,'頭数'].astype('int')) - len(df_data_speed[1:])
                    # win = sum(df_data_speed.loc[1:,'頭数'].astype('int')) - sum(df_data_speed.loc[1:,'着順'].astype('int'))
                    # try:
                    #     df_data['勝率_speed'] = win / total
                    # except ZeroDivisionError:
                    #     df_data['勝率_speed'] = 0
                    # df_data['本番着順'] = df_data.at[0,'着順']

                    ###########################
                    #         相手関係        #
                    ###########################
                    # total = 0
                    # win = 0
                    # tyakusa_total = 0
                    # tyakusa_index = 0
                    # for race in partner_race_list:
                    #     partner_house_list,this_date, house_age_s,wight_list_s = get_horse_url_and_date(race)
                    #     print("====house_partner_list====")
                    #     print(partner_house_list[:4])
                    #     for partner_house in partner_house_list:
                    #         # print(partner_house)
                    #         try:
                    #             df_pt = horse_data(chrome_driver, partner_house)
                    #             index_pt = df_pt[df_pt['日付'] == this_date].index[0]
                    #             df_pt = df_pt[:index_pt].copy()
                    #             for i in range(1,len(df_pt)):
                    #                 # print("型を確認:",type(df_data.at[i,'着順']))
                    #                 if type(df_pt.at[i,'着順']) is str:
                    #                     df_pt.at[i,'着順'] = df_pt.at[i,'着順'].replace('(降)','')
                    #             # print("=====df_pt===========")
                    #             # print(df_pt[-1:])
                    #             # print("=====df_pt===========")
                    #             if len(df_pt) != 0:
                    #                 # print("ここはイケてる")
                    #                 total += df_pt.loc[-1:,'頭数'].astype('int') - 1
                    #                 win += df_pt.loc[-1:,'頭数'].astype('int') - df_pt.loc[-1:,'着順'].astype('int')
                    #                 tyakusa_total += df_pt.loc[-1:,'着差'].map(lambda x: x / 2 if x < 0 else x)
                    #                 tyakusa_index += 1
                    #         except:
                    #             print("patner error")
                    # print("win:"+str(win))
                    # print("total:"+str(total))
                    # try:
                    #     df_data['相手勝率'] = win / total
                    # except ZeroDivisionError:
                    #     df_data['相手勝率'] = 0
                    # try:
                    #     df_data['相手着差'] = tyakusa_total / tyakusa_index
                    # except ZeroDivisionError:
                    #     df_data['相手着差'] = 100

                    df_data["当日馬番"] = house_index
                    df_horse = pd.concat([df_horse,df_data[0:1]], ignore_index=True)
                    print("df_horse:",df_horse)
                else:
                    print("Less Information")
    return df_horse
# 予想順に並べる
def bubble_sort_hourse(data_horse, hourse_list):
    # 正規化
    data_horse["上り正規化"] = regularization(data_horse["上り差平均"])
    data_horse["予想タイム標準化"] = standardization(data_horse["予想タイム差"])
    # 欠損値
    data_horse = data_horse.fillna(0)
    print("==========house_list===========")
    print(hourse_list)
    print("===============================")
    # print("df_タイム指数:",data_horse["ﾀｲﾑ指数標準化"])
    # print("df_賞金平均正規化:",data_horse["賞金平均正規化"])
    # print("df_着差平均:",data_horse["着差平均"])
    # print("df_勝率:",data_horse["勝率"])
    # data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均']] for i in range(len(data_horse))]
    # data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均'],data_horse.at[i,'勝率'],data_horse.at[i,'上り正規化'],data_horse.at[i,'本番年齢'],data_horse.at[i,'最初コーナーから着順平均']] for i in range(len(data_horse))]
    data_arr = [[data_horse.at[i-1,'着差平均_condision'],data_horse.at[i-1,'勝率_condision'], data_horse.at[i-1,"上り正規化"], data_horse.at[i-1,"予想タイム標準化"]] for i in hourse_list]
    print("==========data_array===========")
    data_arr = np.array(data_arr,dtype = 'float')
    print(data_arr)
    print(len(data_arr))
    print("===============================")
    # for _ in range(3):
    for i in range(len(data_arr)):
        for j in range(len(data_arr)-i-1):
            # print("j:",j)
            # print([[data_arr[j]],[data_arr[j+1]]])
            if ranknet.predict([np.array([data_arr[hourse_list[j]-1]]), np.array([data_arr[hourse_list[j+1]-1]])])[0][0] < 0.5:
                tmp = hourse_list[j]
                hourse_list[j] = hourse_list[j + 1]
                hourse_list[j+1] = tmp 
    print(data_arr)
    return hourse_list, data_arr

# 
# def sum_sort(data_horse, hourse_list):
#     # 正規化
#     data_horse["賞金平均正規化"] = regularization(data_horse["賞金平均"])
#     # 標準化
#     data_horse["ﾀｲﾑ指数標準化"] = standardization(data_horse["ﾀｲﾑ指数平均"])
#     data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均']] for i in range(len(data_horse))]
#     horse_result1 = []
#     horse_result2 = []
#     # print("data_array:",len(data_arr))
#     for i,horse_num in enumerate(hourse_list):
#         sum = 0
#         score = 0
#         for j in range(len(hourse_list)):
#             if i != j:
#                 tmp = ranknet.predict([np.array([data_arr[i-1]]), np.array([data_arr[j-1]])])[0][0]
#                 score += tmp
#                 if tmp > 0.5:
#                     sum += 1
#         horse_result1.append([horse_num,sum])
#         horse_result2.append([horse_num,score])
#     # print(horse_result1)
#     sort_list = sorted(horse_result1, key=lambda x:(x[1]), reverse=True)
#     score_list = sorted(horse_result2, key=lambda x:(x[1]), reverse=True)
#     return sort_list,score_list    


# 一個下の馬に勝つ確率
# def find_win_rate(data_horse, hourse_list):
#     # 正規化
#     data_horse["賞金平均正規化"] = regularization(data_horse["賞金平均"])
#     # 標準化
#     data_horse["ﾀｲﾑ指数標準化"] = standardization(data_horse["ﾀｲﾑ指数"])
#     data_arr = [[data_horse.at[i,'ﾀｲﾑ指数_調整_合計'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均'],data_horse.at[i,'勝率'] for i in range(len(data_horse))]
#     win_rate_list = []
#     for i in range(len(data_arr)-1):
#         win_rate_list.append(ranknet.predict([np.array([data_arr[hourse_list[i]-1]]), np.array([data_arr[hourse_list[i+1]-1]])])[0][0] * 100)
#     win_rate_list.append(0)
#     return win_rate_list


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

# 画像をアップロードするフォルダー
# upload_folder = './uploads'
# 画像の拡張子の制限
# set()で重複した要素を取り除く
# allowed_extenstions = set(["png","jpg","jpeg"])

# お決まり
app = Flask(__name__)
app.secret_key = "hogehoge"

# 設定の保存
# upload_folderの設定を保存
# UPLOAD_FOLDER = './uploads/'
# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# configの読み込み
app.config.from_object(__name__)

# main画面
@app.route("/main_page",methods = ["GET", "POST"])
def main_page():
    text = "データ入力ページ"
    return render_template("main_page.html",text = text)

# アップロードしたファイルの処理
@app.route('/result_page',methods = ["GET", "POST"])
# ファイルを表示する
def result_page():
    text = "予想結果"
    #データが届いたら
    if request.method == "POST":
        # 値のデータを取得
        race_url = request.form['race_url']
        chrome_driver = set_up_chrome_driver()
        login_netkeiba(chrome_driver)
        hourse_url_list,house_age,race_type_list,time_type_list,wight_list,kyori = get_horse_url(race_url)
        print("===========hourse_url_list==========")
        print(hourse_url_list)
        print("===========hourse_url_list==========")
        print("===========race_type_list==========")
        print(race_type_list)
        print("===========race_type_list==========")
        print("===========wight_type_list==========")
        print(wight_list)
        print("===========wight_type_list==========")
        data_horse = make_horse_DataFrame(chrome_driver,hourse_url_list, house_age, race_type_list,time_type_list,wight_list,kyori)
        hourse_list = [i+1 for i in range(len(data_horse))]
        uma_num_list = [i for i in data_horse['当日馬番']]
        print("bubble sort")
        hourse_list, data_arr = bubble_sort_hourse(data_horse, hourse_list)
        # win_rate_list = find_win_rate(data_horse, hourse_list)
        chrome_driver.close()
        return render_template('result_page.html',text = text , hourse_list=hourse_list, data_arr=data_arr, uma_num_list=uma_num_list ,zip=zip)

@app.route('/cheack_page',methods = ["GET", "POST"])
def cheack_page():
    text = "過去の予想"
    #データが届いたら
    if request.method == "POST":
        # 値のデータを取得
        race_url = request.form['race_url']
        chrome_driver = set_up_chrome_driver()
        login_netkeiba(chrome_driver)
        hourse_url_list,date, house_age = get_horse_url_and_date(race_url)
        data_horse = cheack_make_horse_DataFrame(chrome_driver,hourse_url_list,date,house_age)
        hourse_list = [int(i) for i in data_horse["本番馬番"]]
        print("===========hourse_list================")
        print(hourse_list)
        print("======================================")
        for _ in range(3):
            hourse_list = bubble_sort_hourse(data_horse, hourse_list)
        # win_rate_list = find_win_rate(data_horse, hourse_list)
        chrome_driver.close()
        return render_template('result_page.html',text = text , hourse_list=hourse_list)

## おまじない
if __name__ == "__main__":
    app.run(debug=True)