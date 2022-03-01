from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options 
from selenium.webdriver.support.select import Select
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
            if '/race/2' in tmp:
                race_list.append('https://db.netkeiba.com'+tmp)
                # print(tmp)
                
    return race_list

def checkBox_search_race_url(chrome_driver, url, check_track, check_Jyo, check_kyori):
    chrome_driver.get(url)
    chrome_driver.find_element_by_id(check_track).click()
    chrome_driver.find_element_by_id(check_Jyo).click()
    chrome_driver.find_element_by_id(check_kyori).click()
    dropdown = chrome_driver.find_element_by_xpath("/html/body/div[1]/div[3]/div[1]/div/div[2]/form/table/tbody/tr[11]/td/select")
    select = Select(dropdown)
    select.select_by_index(2)
    chrome_driver.find_element_by_xpath("/html/body/div[1]/div[3]/div[1]/div/div[2]/form/div/input[1]").click()
    # utf変換
    html = chrome_driver.page_source.encode("utf-8")
    soup_race = BeautifulSoup(html, 'html.parser')
    elems = soup_race.select('a')
    race_list = []
    for elem in elems:
        tmp = elem.get('href')
        # この気持ち悪い書き方じゃないと、上手くいかない
        if type(tmp) is str:
            if '/race/2' in tmp:
                race_list.append('https://db.netkeiba.com'+tmp)
                # print(tmp)
                
    return race_list

def horse_data(chrome_driver,url):
    chrome_driver.get(url)
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

def make_horse_DataFrame(chrome_driver,horse_list,date):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url in horse_list:
        df_data_total = horse_data(chrome_driver,horse_url)
        # print(df_data_total)
        # 現在のレースのインデックスを取得
        index_date = df_data_total[df_data_total['日付'] == date].index[0]
        print("index_date:",index_date)
        if pd.notnull(df_data_total.at[index_date,'ﾀｲﾑ指数']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
            df_data = df_data_total[index_date:]
            df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['上り']) | pd.isnull(df_data['着差'])].index, inplace=True)
            print(df_data)
            print('index_date:',index_date)
            # 本番着順
            if type(df_data['着順']) == str:
                # ややこしいものを削除
                df_data['着順'].str.replace('[\(*\)]','',regex= True)
                df_data['着順'].str.replace('(降)','',regex= True)
            print('-----着順---------:',df_data.at[index_date,'着順'])
            df_data['本番着順'] = df_data.at[index_date,'着順']
            # 合計賞金
            df_data["賞金"] = df_data["賞金"].fillna(0)
            df_data['合計賞金'] = sum(df_data['賞金'])
            # 賞金平均
            df_data['賞金平均'] = sum(df_data['賞金']) / len(df_data['合計賞金'])
            # 着差平均
            try:
                df_data['着差平均'] = sum(df_data['着差']) / len(df_data['着差'])
            except ZeroDivisionError:
                df_data['着差平均'] = 0
            # タイム指数平均
            index_tyakusa = df_data[pd.isnull(df_data['ﾀｲﾑ指数'])].index
            print('ﾀｲﾑ指数:',len(index_tyakusa))
            df_data['ﾀｲﾑ指数'].replace(np.nan,0)
            print('タイム指数：',df_data['ﾀｲﾑ指数'])
            try:
                df_data['ﾀｲﾑ指数平均'] = sum(df_data['ﾀｲﾑ指数']) / len(df_data['ﾀｲﾑ指数'])
                print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
            except ZeroDivisionError:
                df_data['ﾀｲﾑ指数平均'] = 0
            # print(df_data[index_date + 1:index_date + 2])
            df_horse = pd.concat([df_horse,df_data[index_date + 1:index_date + 2]], ignore_index=True)
    print("df_horse:",df_horse)
    return df_horse


def write_csv(df,csv_file):
    # Nanを削除
    # df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | (df['本番着順'] == '中') | (df['本番着順'] == '取') | (df['本番着順'] == '除') | (df['本番着順'] == '降')].index, inplace=True)
    df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | pd.isnull(df['着差平均']) | (df['本番着順'].str.match('[^0-9]+'))].index, inplace=True)
    df = df.reset_index()
    # df.to_csv('./test.csv')
    # csv_file = './documents/csv/'+race+'.csv'
    df.to_csv(csv_file)

if __name__=='__main__':
    chrome_driver = set_up_chrome_driver()
    login_netkeiba(chrome_driver)
    # for race_name in ['有馬記念','東京優駿','宝塚記念','安田記念','エリザベス女王','スプリンターズS']:
    # for race_name in ['佐賀']:
    for check_track, type_name in zip(["check_track_1", "check_track_2"],["芝","ダート"]):
        for check_Jyo, place_name in zip(["check_Jyo_01","check_Jyo_02","check_Jyo_03","check_Jyo_04","check_Jyo_05","check_Jyo_06","check_Jyo_07","check_Jyo_08","check_Jyo_09","check_Jyo_10"],["札幌","函館","福島","新潟","東京","中山","中京","京都","阪神","小倉"]):
            for check_kyori, kyori_name in zip(["check_kyori_1000","check_kyori_1150","check_kyori_1200","check_kyori_1300","check_kyori_1400","check_kyori_1500","check_kyori_1600","check_kyori_1700","check_kyori_1800","check_kyori_1900","check_kyori_2000","check_kyori_2100","check_kyori_2200","check_kyori_2300","check_kyori_2400","check_kyori_2500","check_kyori_2600","check_kyori_3000","check_kyori_3200","check_kyori_3400","check_kyori_3600","check_kyori_4000"],["1000m以下","1150m","1200m","1300m","1400m","1500m","1600m","1700m","1800m","1900m","2000m","2100m","2200m","2300m","2400m","2500m","2600m","3000m","3200m","3400m","3600m","4000m以上"]):
                # race_list = get_race_url(chrome_driver,race_name)
                # print(race_list)
                race_list = checkBox_search_race_url(chrome_driver,"https://db.netkeiba.com/?pid=race_search_detail", check_track, check_Jyo, check_kyori)
                df_total = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金', '本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均'])
                for race in race_list:
                    # print("race:",race)
                    horse_list,date = get_horse_url_and_date(race)
                    # print("horse_list:",horse_list)
                    # time.sleep(0.1)
                    if date != 'error':
                        df_horse = make_horse_DataFrame(chrome_driver, horse_list, date)
                        df_total = pd.concat([df_total,df_horse], ignore_index=True)
                        # print("error")
                print("-------------")
                csv_file = "./documents/csv/race/"+place_name+type_name+kyori_name+".csv"
                write_csv(df_total, csv_file)
                print(df_total)
    chrome_driver.quit()
