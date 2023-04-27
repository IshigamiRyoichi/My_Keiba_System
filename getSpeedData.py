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
race_json = open('./documents/JSON/race_Speed.json','r')
race_data = json.load(race_json)

kyori_json = open('./documents/JSON/kyori_Data.json','r')
kyori_data = json.load(kyori_json)

csv_folder = "2023_2_19/"
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
    speed_list = [df.at[i, '上り'] for i in range(5)]
    return house_list,date, house_age,wight_list,speed_list

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
    time.sleep(0.1)
    dropdown = chrome_driver.find_element_by_xpath('//*[@id="db_search_detail_form"]/form/table/tbody/tr[11]/td/select')
    select = Select(dropdown)
    select.select_by_index(1)
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
                    if race_count > index_date + 1 and race_count <= index_date + 3:
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


def write_csv(df,csv_file):
    df = df.reset_index()
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
    df_total = pd.DataFrame(index=[],columns=['開催所', '平均上り'])
    index = 0
    for race_name in race_data:
        for track_neme, track_type in zip(['芝','ダ'], ['check_track_1', 'check_track_2']):
            for kyori in kyori_data:
                try:
                    race_list = checkBox_search_race_url(chrome_driver,"https://db.netkeiba.com/?pid=race_search_detail",race_name , track_type, race_data[race_name], kyori_data[kyori], 'check_grade_9')
                    # print(race_list)
                    all_house_list = []
                    all_date = []
                    all_house_age = []
                    all_wight_list = []
                    all_speed_list = []
                    for race in race_list:
                        house_list,date, house_age,wight_list,speed_list = get_horse_url_and_date(race)
                        if date != 'error':
                            # race_type_list, time_type_list, track_type = set_column_race_type(track_neme, kyori)
                            all_house_list.append(house_list)
                            all_date.append(date)
                            all_house_age.append(house_age)
                            all_wight_list.append(wight_list)
                            all_speed_list.append(speed_list)
                            # print("error")紐
                    if len(race_list) != 0:
                        rane_track_kyori = race_name + track_neme + kyori
                        df_total.at[index, '開催所'] = rane_track_kyori
                        df_total.at[index, '平均上り'] = np.mean(all_speed_list)
                        index += 1
                        print("get_success")
                except:
                    print("error:get_data")
        write_csv(df_total, "./documents/csv/speed_means.csv")
    chrome_driver.quit()
