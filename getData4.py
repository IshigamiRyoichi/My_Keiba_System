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


# jsonからidとpassを読み込む
open_json = open('./documents/JSON/sessoin.json','r')
session = json.load(open_json)
login_id=session['login_id']
pswd=session['pswd']

# 平均の連想配列を作成
time_open = open('./documents/JSON/arrange_time.json','r')
arrange_time = json.load(time_open)

# 上り平均
speed_df = pd.read_csv('./documents/csv/speed_means.csv')

# race情報のjsonを読み込む
race_json = open('./documents/JSON/race_Data.json','r')
race_data = json.load(race_json)

# excelのパス
bms_excel = './documents/excel/bms/'
kisyu_excel = './documents/excel/kisyu/'
maec_excel = './documents/excel/maec/'
sbb_excel = './documents/excel/sbb/'

csv_folder = "2023_4_02/"
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
    print("date:",date)
    # print(elems)
    house_list = []
    for elem in elems:
        tmp = elem.get('href')
        if '/horse/' in tmp:
            house_list.append('https://db.netkeiba.com' + tmp)

        # elif '/race/list/' in tmp:
        #     date = tmp
        #     # 不要の物を削除
        #     date = date.replace('/race/list/', '')
        #     date = date.replace('/','')
        #     # yyyy/mm/dd表記に変換
        #     date = date[:4]+'/'+date[4:6]+'/'+date[6:]

    table_horse = soup_race.select('[class="race_table_01 nk_tb_common"]')
    table_horse = soup_race.select('[class="race_table_01 nk_tb_common"]')
    table_horse = str(table_horse).replace('<diary_snap_cut>','').replace('</diary_snap_cut>','')
    with io.StringIO(table_horse) as f:
        # print(f)
        df = pd.read_html(f)[0]
    house_age = [i for i in df['性齢']]
    wight_list = [i for i in df['斤量']]
    kisyu_list = [i for i in df['騎手']]
    speed_list = [df.at[i, '上り'] for i in range(5)]
    return house_list,date, house_age,wight_list,kisyu_list,speed_list

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

def horse_data_and_family_and_partner_race(chrome_driver,url,date):
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
        fahter_horse = soup_horse.select('td.b_ml:nth-child(1) > a:nth-child(1)')[0]
        mother_father_horse = soup_horse.select('.blood_table > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2) > a:nth-child(1)')[0]
        print("====")
        # fahter_horse_url = fahter_horse.get('href')
        pos1 = str(fahter_horse).find('">') + 2
        pos2 = str(fahter_horse).find('</a>')
        fahter_horse_name = str(fahter_horse)[pos1:pos2]
        pos1 = str(mother_father_horse).find('">') + 2
        pos2 = str(mother_father_horse).find('</a>')
        mother_father_horse_name = str(mother_father_horse)[pos1:pos2]
        print(fahter_horse_name)
        print(mother_father_horse_name)
        # print(table_horse[4])
        with io.StringIO(str(table_horse)) as f:
            # print(f)
            df = pd.read_html(f)[0]
        index_date = df[df['日付'] == date].index[0]
        print("========")
        print(index_date)
        print("========")
        elems = soup_horse.select('a')
        race_count = 0
        partner_race_list = []
        for elem in elems:
            tmp = elem.get('href')
            if type(tmp) is str:
                if '/race/2' in tmp or '/race/199' in tmp:
                    # print("========")
                    # print(tmp)
                    # print("========")
                    if race_count > index_date + 1 and race_count <= index_date + 2:
                        partner_race_list.append('https://db.netkeiba.com'+tmp)
                    race_count = race_count + 1

        return df, fahter_horse_name, mother_father_horse_name, partner_race_list
    return -1, -1, -1, -1

def serach_other_horse(chrome_driver, father_horse_name, mother_father_horse_name):
    chrome_driver.get('https://db.netkeiba.com/?pid=horse_search_pedigree')
    chrome_driver.find_element_by_name('F').send_keys(father_horse_name)
    chrome_driver.find_element_by_name('MF').send_keys(mother_father_horse_name)
    time.sleep(0.1)
    serach_button = chrome_driver.find_element_by_xpath('/html/body/div[1]/div[2]/div[1]/div[1]/div[2]/form/div/input[1]')
    chrome_driver.execute_script("arguments[0].click();",serach_button)
    time.sleep(0.1)
    other_horse_list = []
    cur_url = str(chrome_driver.current_url)
    if '/horse/' in cur_url:
        other_horse_list.append(cur_url)
    else:
        html = chrome_driver.page_source.encode("utf-8")
        soup_race = BeautifulSoup(html, 'html.parser')
        elems = soup_race.select('a')
        for elem in elems:
            tmp = elem.get('href')
            if type(tmp) is str:
                if '/horse/2' in tmp or '/horse/1' in tmp:
                    other_horse_list.append(tmp)
    return other_horse_list

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


def make_horse_DataFrame(chrome_driver,horse_list,date,house_age, wight_list, kisyu_list, race_type_list, time_type_list, kyori, min_speed, max_speed, df_bms, df_kisyu, df_sbb, df_maec):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url,age,wight,kisyu in zip(horse_list,house_age, wight_list, kisyu_list):
        df_data_total, fahter_horse_name, mother_father_horse_name, partner_race_list = horse_data_and_family_and_partner_race(chrome_driver,horse_url, date)
        if type(df_data_total) is not int:
            print("Success!!")
            index_date = df_data_total[df_data_total['日付'] == date].index[0]
            if len(df_data_total.columns) < 28:
                print("Nothing")
            # 現在のレースのインデックスを取得
            elif pd.notnull(df_data_total.at[index_date,'タイム']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
                print("Get Information")
                ###########################
                #           本馬          #
                ###########################
                wight_max = max(wight_list)
                df_data = df_data_total[index_date:].copy()
                df_data.drop(df_data.loc[pd.isnull(df_data['着差']) | pd.isnull(df_data['上り']) | pd.isnull(df_data['距離']) | pd.isnull(df_data['タイム'])].index, inplace=True)
                df_data = df_data.reset_index(drop=True).copy()
                for i in range(1,len(df_data)):
                    # print("型を確認:",type(df_data.at[i,'着順']))
                    if type(df_data.at[i,'着順']) is str:
                        df_data.at[i,'着順'] = df_data.at[i,'着順'].replace('(降)','')
                df_data_condision = df_data[df_data['距離'].isin(race_type_list)]
                df_data_time = df_data[df_data['距離'].isin(time_type_list)]
                df_data_speed = df_data[(df_data['上り'] >= min_speed) & (df_data['上り'] <= max_speed)]
                df_data_condision = df_data_condision.reset_index(drop=True).copy()
                df_data_time = df_data_time.reset_index(drop=True).copy()
                if len(df_data) >= 2 and len(df_data_time) >= 2 and len(df_data_condision) >= 2:
                    # 斤量とタイム、上り    
                    print(df_data_time)
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
                            # 上り
                            speed_df = pd.read_csv('./documents/csv/speed_means.csv')
                            arrange_speed = speed_df.loc[speed_df["開催所"] == place_and_kyori, "平均上り"]
                            this_speed = df_data_time.at[i, "上り"]
                            df_data_time.at[i, "上り差"] = float(arrange_speed - this_speed)  

                        except:
                            drop_list.append(i)

                    for i in range(1,len(df_data)):
                        # try:
                        base_time = pd.to_datetime('00:00.0', format='%M:%S.%f')
                        tmp = pd.to_datetime("1:47.4", format='%M:%S.%f') - base_time
                        df_data.at[i,'タイム計算'] = tmp.total_seconds()

                        # except:
                        #     drop_list.append(i)

                    try:
                        df_data_time.drop(df_data_time.index[drop_list], inplace=True)
                        df_data_time = df_data_time.reset_index(drop=True).copy()
                        res = np.polyfit(df_data_time.loc[1:,"距離のみ"].astype(float), df_data_time.loc[1:,"タイム差"], 1)
                        df_data["予想タイム差"] = np.poly1d(res)(int(kyori.replace("check_kyori_",""))) + (0.2 * (wight - wight_max))
                    except:
                        print("error m")

                    # 距離基準による着差平均
                    df_data_condision['着差_調整'] = df_data_condision['着差'].map(lambda x: x / 2 if x < 0 else x)
                    try:
                        df_data['着差平均_condision'] = sum(df_data_condision.loc[1:,'着差_調整']) / len(df_data_condision.loc[1:,'着差_調整'])
                    except ZeroDivisionError:
                        df_data['着差平均_condision'] = np.nan
                    # 距離基準による勝率
                    total = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - len(df_data_condision[1:])
                    win = sum(df_data_condision.loc[1:,'頭数'].astype('int')) - sum(df_data_condision.loc[1:,'着順'].astype('int'))
                    try:
                        df_data['勝率_condision'] = win / total
                    except ZeroDivisionError:
                        df_data['勝率_condision'] = np.nan
                    try:
                        df_data['上り差平均'] = sum(df_data_time.loc[1:,'上り差']) / len(df_data_time.loc[1:,'上り差'])
                    except:
                        df_data['上り差平均'] = np.nan
                    # 上り基準による着差平均
                    df_data_speed['着差_調整'] = df_data_speed['着差'].map(lambda x: x / 2 if x < 0 else x)
                    try:
                        df_data['着差平均_speed'] = sum(df_data_speed.loc[1:,'着差_調整']) / len(df_data_speed.loc[1:,'着差_調整'])
                    except ZeroDivisionError:
                        df_data['着差平均_speed'] = np.nan
                    # 上り基準による勝率
                    total = sum(df_data_speed.loc[1:,'頭数'].astype('int')) - len(df_data_speed[1:])
                    win = sum(df_data_speed.loc[1:,'頭数'].astype('int')) - sum(df_data_speed.loc[1:,'着順'].astype('int'))
                    try:
                        df_data['勝率_speed'] = win / total
                    except ZeroDivisionError:
                        df_data['勝率_speed'] = 0
                    df_data['本番着順'] = df_data.at[0,'着順']


                    try:
                        df_data['着差平均'] = sum(df_data.loc[1:,'着差']) / len(df_data.loc[1:,'着差'])
                    except ZeroDivisionError:
                        df_data['着差平均'] = np.nan

                    try:
                        df_data['上り平均'] = sum(df_data.loc[1:,'上り']) / len(df_data.loc[1:,'上り'])
                    except:
                        df_data['上り平均'] = np.nan

                    try:
                        df_data['着順平均'] = sum(df_data.loc[1:,'着順']) / len(df_data.loc[1:,'着順'])
                    except:
                        df_data['着順平均'] = np.nan

                    try:
                        df_data['タイム計算平均'] = sum(df_data.loc[1:,'タイム計算']) / len(df_data.loc[1:,'タイム計算'])
                    except:
                        df_data['タイム計算平均'] = np.nan
                    ###########################
                    #          血統馬         #
                    ###########################
                    df_data['種牡馬成績'] = df_sbb.loc[df_sbb['種牡馬'] == fahter_horse_name, '検定']
                    df_data['母父成績'] = df_bms.loc[df_bms['BMS'] == mother_father_horse_name, '検定']
                    ###########################
                    #          騎手           #
                    ###########################
                    # df_data['騎手成績'] = df_kisyu.loc[df_kisyu['騎手'] == kisyu, '検定']
                    ###########################
                    #         相手関係        #
                    ###########################
                    # total = 0
                    # win = 0
                    # tyakusa_total = 0
                    # tyakusa_index = 0
                    # for race in partner_race_list:
                    #     partner_house_list,this_date, house_age_s,wight_list_s,kisyu_list_s,speed_list_s = get_horse_url_and_date(race)
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
                    #             print(df_pt[-1:])
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
                    #     df_data['相手着差'] = 1
                    
                    df_horse = pd.concat([df_horse,df_data[0:1]], ignore_index=True)
                    print("df_horse:",df_horse)
                else:
                    print("Less Information")
            else:
                print("Not Get")
    return df_horse


def write_csv(df,csv_file):
    # Nanを削除
    # df.drop(df.loc[pd.isnull(df['ﾀｲﾑ指数']) | pd.isnull(df['上り']) | pd.isnull(df['着差']) | pd.isnull(df['本番着順']) | (df['本番着順'] == '中') | (df['本番着順'] == '取') | (df['本番着順'] == '除') | (df['本番着順'] == '降')].index, inplace=True)
    df.drop(df.loc[ pd.isnull(df['上り']) | pd.isnull(df['着差平均_condision']) | pd.isnull(df['本番着順']) | pd.isnull(df['予想タイム差']) | (df['本番着順'].str.match('[^0-9]+'))].index, inplace=True)
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
    return race_type_list, time_type_list, track_type

if __name__=='__main__':
    chrome_driver = set_up_chrome_driver()
    login_netkeiba(chrome_driver)
    for race_name in race_data:
    # for race_name in ["宝塚記念"]:
        race_list = checkBox_search_race_url(chrome_driver,"https://db.netkeiba.com/?pid=race_search_detail",race_name , race_data[race_name]['check_track'], race_data[race_name]['check_Jyo'], race_data[race_name]['check_kyori'], race_data[race_name]['check_grade'])
        # print(race_list)
        all_house_list = []
        all_date = []
        all_house_age = []
        all_wight_list = []
        all_speed_list = []
        all_kisyu_list = []
        df_total = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順'])
        for race in race_list:
            # chrome_driver.get(race)
            # print(race)
            try:
                house_list,date, house_age,wight_list,kisyu_list,speed_list = get_horse_url_and_date(race)
                if date != 'error':
                    race_type_list, time_type_list, track_type = set_column_race_type(race_data[race_name]['check_track'], race_data[race_name]['check_kyori'])
                    all_house_list.append(house_list)
                    all_date.append(date)
                    all_house_age.append(house_age)
                    all_wight_list.append(wight_list)
                    all_kisyu_list.append(kisyu_list)
                    for speed in speed_list:
                        all_speed_list.append(speed)
                    # print("error")紐
            except:
                print("get_info_error")
        min_speed = min(all_speed_list)
        max_speed = max(all_speed_list)
        race_jyo = race_name[:2]
        race_kyori = race_data[race_name]['check_kyori'].replace("check_kyori_","")
        data_excel = race_data[race_name]['data_excel']

        # 各データフレームを読み込み
        df_bms = pd.read_excel(bms_excel+data_excel)
        df_kisyu = pd.read_excel(kisyu_excel+data_excel)
        df_sbb = pd.read_excel(sbb_excel+data_excel)
        df_maec = pd.read_excel(maec_excel+data_excel)

        # スクレイピング
        for house_list, date, house_age, wight_list, kisyu_list in zip(all_house_list, all_date, all_house_age, all_wight_list, all_kisyu_list):
            df_horse = make_horse_DataFrame(chrome_driver, house_list, date,house_age,wight_list,kisyu_list ,race_type_list, time_type_list, race_data[race_name]['check_kyori'], min_speed, max_speed, df_bms, df_kisyu, df_sbb, df_maec)
            df_total = pd.concat([df_total,df_horse], ignore_index=True)
            print("===========df_total=============")
            print(df_total)
        print("-------------")
        csv_file = "./documents/csv/"+csv_folder+race_name+".csv"
        write_csv(df_total, csv_file)
        print(df_total)
    chrome_driver.quit()
