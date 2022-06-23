from ast import IsNot
from cmath import nan
from curses.ascii import isdigit
from distutils.log import error
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options 
from selenium.webdriver.support.select import Select
from datetime import datetime as dt
import chromedriver_binary
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
    chrome_driver.find_element_by_name('login_id').send_keys(login_id)
    # time.sleep(0.5)
    chrome_driver.find_element_by_name('pswd').send_keys(pswd)
    # time.sleep(0.5)
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
    return horse_list,date

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

def checkBox_search_race_url(chrome_driver, url, race_name, check_track, check_Jyo, check_kyori):
    chrome_driver.get(url)
    chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/table/tbody/tr[1]/td/input').send_keys(race_name)
    chrome_driver.find_element_by_id(check_track).click()
    chrome_driver.find_element_by_id(check_Jyo).click()
    # chrome_driver.find_element_by_id(check_baba).click()
    chrome_driver.find_element_by_id(check_kyori).click()
    time.sleep(1)
    dropdown = chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/table/tbody/tr[11]/td/select')
    select = Select(dropdown)
    select.select_by_index(2)
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

def make_horse_DataFrame(chrome_driver,horse_list,date):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均','平均タイム差','平均タイム差合計','平均タイム差平均','上り平均','勝率'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url in horse_list:
        df_data_total = horse_data(chrome_driver,horse_url)
        if type(df_data_total) is not int:
            print("Success!!")
            index_date = df_data_total[df_data_total['日付'] == date].index[0]
            if len(df_data_total.columns) < 28:
                print("Nothing")
            # 現在のレースのインデックスを取得
            # print(df_data_total)
            # print("index_date:",index_date)
            elif pd.notnull(df_data_total.at[index_date,'ﾀｲﾑ指数']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
                df_data = df_data_total[index_date:].copy()
                df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['着差'])].index, inplace=True)
                df_data = df_data.reset_index(drop=True).copy()
                print(df_data)
                # 本番着順
                # if type(df_data['着順']) == str:
                    # ややこしいものを削除
                df_data['平均タイム差'] = 0
                time_count = 0
                for i in range(1,len(df_data)):
                    print(type(df_data.at[i,'着順']))
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
                    
                # df_data.drop(df_data.loc[pd.isnull(df_data['平均タイム差'])].index, inplace=True)
                df_data['平均タイム差合計'] = sum(df_data['平均タイム差'])
                try:
                    df_data['平均タイム差平均'] = sum(df_data['平均タイム差']) / time_count
                except ZeroDivisionError:
                    df_data['平均タイム差平均'] = 0

                # print('-----着順---------:',df_data.at[index_date,'着順'])
                df_data['本番着順'] = df_data.at[0,'着順']
                # 合計賞金
                df_data["賞金"] = df_data["賞金"].fillna(0)
                df_data['合計賞金'] = sum(df_data['賞金'])
                # 賞金平均
                try:
                    df_data['賞金平均'] = df_data['合計賞金'] / len(df_data)
                except ZeroDivisionError:
                    df_data['賞金平均'] = 0
                # 着差平均
                try:
                    df_data['着差平均'] = sum(df_data['着差']) / len(df_data)
                except ZeroDivisionError:
                    df_data['着差平均'] = 0
                try:
                    df_data['上り平均'] = sum(df_data['上り']) / len(df_data['上り'])
                except ZeroDivisionError:
                    df_data['上り平均'] = 0
                # タイム指数平均
                index_tyakusa = df_data[pd.isnull(df_data['ﾀｲﾑ指数'])].index
                df_data['ﾀｲﾑ指数'].replace(np.nan,0)
                try:
                    df_data['ﾀｲﾑ指数平均'] = sum(df_data['ﾀｲﾑ指数']) / len(df_data['ﾀｲﾑ指数'])
                    # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
                except ZeroDivisionError:
                    df_data['ﾀｲﾑ指数平均'] = 0
                # BTmodel風のことをする
                total = sum(df_data['頭数'].astype('int')) - len(df_data)
                win = sum(df_data['頭数'].astype('int')) - sum(df_data['着順'].astype('int'))
                try:
                    df_data['勝率'] = win / total
                except ZeroDivisionError:
                    df_data['勝率'] = 0
                print(df_data[1:2])
                df_horse = pd.concat([df_horse,df_data[1:2]], ignore_index=True)
                print("df_horse:",df_horse)
    return df_horse


def write_csv(df,csv_file):
    # Nanを削除
    # df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | (df['本番着順'] == '中') | (df['本番着順'] == '取') | (df['本番着順'] == '除') | (df['本番着順'] == '降')].index, inplace=True)
    df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数平均']) | pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | pd.isnull(df['着差平均']) | (df['本番着順'].str.match('[^0-9]+'))].index, inplace=True)
    df = df.reset_index()
    # df.to_csv('./test.csv')
    # csv_file = './documents/csv/'+race+'.csv'
    df.to_csv(csv_file)

if __name__=='__main__':
    chrome_driver = set_up_chrome_driver()
    login_netkeiba(chrome_driver)
    for race_name in race_data:
        race_list = checkBox_search_race_url(chrome_driver,"https://db.netkeiba.com/?pid=race_search_detail",race_name , race_data[race_name]['check_track'], race_data[race_name]['check_Jyo'], race_data[race_name]['check_kyori'])
        # print(race_list)
        df_total = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金', '本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均'])
        for race in race_list:
            horse_list,date = get_horse_url_and_date(race)
            if date != 'error':
                df_horse = make_horse_DataFrame(chrome_driver, horse_list, date)
                df_total = pd.concat([df_total,df_horse], ignore_index=True)
                # print("error")
        print("-------------")
        csv_file = "./documents/csv/race/"+race_name+".csv"
        write_csv(df_total, csv_file)
        print(df_total)
    chrome_driver.quit()
