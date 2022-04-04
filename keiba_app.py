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
import time

# jsonからidとpassを読み込む
open_json = open('./documents/JSON/sessoin.json','r')
session = json.load(open_json)
login_id=session['login_id']
pswd=session['pswd']

# ranknetの読み込み
# ranknet = load_model("./documents/keiba_ranknet_model")
ranknet = load_model("./documents/model/桜花賞_model")

# driverの用意
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

# ログイン
def login_netkeiba(chrome_driver):
    chrome_driver.get('https://regist.sp.netkeiba.com/')
    chrome_driver.find_element_by_name('login_id').send_keys(login_id)
    # time.sleep(0.5)
    chrome_driver.find_element_by_name('pswd').send_keys(pswd)
    # time.sleep(0.5)
    chrome_driver.find_elements_by_class_name('FormItem_Submit_Btn')[0].click()
    # driver
    return chrome_driver

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
    return horse_list

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
    # print("date:",date)
    # print(elems)
    horse_list = []
    for elem in elems:
        tmp = elem.get('href')
        if '/horse/' in tmp:
            horse_list.append("https://db.netkeiba.com"+tmp)

        elif '/race/list/' in tmp:
            date = tmp
            # 不要の物を削除
            date = date.replace('/race/list/', '')
            date = date.replace('/','')
            # yyyy/mm/dd表記に変換
            date = date[:4]+'/'+date[4:6]+'/'+date[6:]
    # print('date:',date)
    return horse_list,date

# 馬データを取得
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


def cheack_make_horse_DataFrame(chrome_driver,horse_list,date):
     # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金','本番着順', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均'])
    # df_data = horse_data(chrome_driver,horse_list[0])
    # index_date = df_data[df_data['日付'] == date].index[0]
    # df_horse = df_data[index_date + 1:index_date + 2]
    # print(df_data[index_date + 1:index_date + 2])
    for horse_url in horse_list:
        df_data_total = horse_data(chrome_driver,horse_url)
        # 現在のレースのインデックスを取得
        index_date = df_data_total[df_data_total['日付'] == date].index[0]
        print(df_data_total)
        print("index_date:",index_date)
        if pd.notnull(df_data_total.at[index_date,'ﾀｲﾑ指数']) & pd.notnull(df_data_total.at[index_date,'上り']) & pd.notnull(df_data_total.at[index_date,'着差']):
            df_data = df_data_total[index_date:].copy()
            df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['着差'])].index, inplace=True)
            # 本番着順
            if type(df_data['着順']) == str:
                # ややこしいものを削除
                df_data['着順'].str.replace('[\(*\)]','',regex= True)
                df_data['着順'].str.replace('(降)','',regex= True)
            # print('-----着順---------:',df_data.at[index_date,'着順'])
            df_data['本番着順'] = df_data.at[index_date,'着順']
            df_data['本番馬番'] = df_data.at[index_date,'馬番']
            # 合計賞金
            df_data["賞金"] = df_data["賞金"].fillna(0)
            df_data['合計賞金'] = sum(df_data['賞金'])
            # 賞金平均
            df_data['賞金平均'] = sum(df_data['賞金']) / len(df_data)
            # 着差平均
            try:
                df_data['着差平均'] = sum(df_data['着差']) / len(df_data)
            except ZeroDivisionError:
                df_data['着差平均'] = 0
            # タイム指数平均
            index_tyakusa = df_data[pd.isnull(df_data['ﾀｲﾑ指数'])].index
            # print('ﾀｲﾑ指数:',len(index_tyakusa))
            df_data['ﾀｲﾑ指数'].replace(np.nan,0)
            # print('タイム指数：',df_data['ﾀｲﾑ指数'])
            try:
                df_data['ﾀｲﾑ指数平均'] = sum(df_data['ﾀｲﾑ指数']) / len(df_data['ﾀｲﾑ指数'])
                # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
            except ZeroDivisionError:
                df_data['ﾀｲﾑ指数平均'] = 0
            print(df_data[1:2])
            df_horse = pd.concat([df_horse,df_data[1:2]], ignore_index=True)
            print("df_horse:",df_horse)
    return df_horse

def make_horse_DataFrame(chrome_driver,horse_list):
    # 空のDaraFrame
    df_horse = pd.DataFrame(index=[],columns=['日付', '開催', '天気', 'R', 'レース名', '映像', '頭数', '枠番', '馬番', 'オッズ', '人気', '着順', '騎手', '斤量', '距離', '馬場', '馬場指数', 'タイム', '着差', 'ﾀｲﾑ指数', '通過', 'ペース', '上り', '馬体重', '厩舎ｺﾒﾝﾄ', '備考', '勝ち馬(2着馬)', '賞金', '合計賞金', '賞金平均', '着差平均','ﾀｲﾑ指数平均'])
    for horse_url in horse_list:
        df_data = horse_data(chrome_driver,horse_url)
        df_data.drop(df_data.loc[pd.isnull(df_data['ﾀｲﾑ指数']) | pd.isnull(df_data['上り']) | pd.isnull(df_data['着差'])].index, inplace=True)
        df_data = df_data.reset_index()
        # print(df_data)
        # 本番着順
        if type(df_data['着順']) == str:
            # ややこしいものを削除
            df_data['着順'] = df_data['着順'].str.replace('[\(*\)]','',regex= True)
            df_data['着順'] = df_data['着順'].str.replace('(降)','',regex= True)
        # print('-----着順---------:',df_data.at[index_date,'着順'])
        # df_data['本番着順'] = df_data.at[index_date,'着順']
        # 合計賞金
        df_data["賞金"] = df_data["賞金"].fillna(0)
        df_data['合計賞金'] = sum(df_data['賞金'])
        # 賞金平均
        try:
            df_data['賞金平均'] = sum(df_data['賞金']) / len(df_data['合計賞金'])
        except:
            df_data['賞金平均'] = 0
        # 着差平均
        try:
            df_data['着差平均'] = sum(df_data['着差']) / len(df_data['着差'])
        except ZeroDivisionError:
            df_data['着差平均'] = 0
        # タイム指数平均
        # print('ﾀｲﾑ指数:',len(index_tyakusa))
        df_data['ﾀｲﾑ指数'].replace(np.nan,0)
        # print('タイム指数：',df_data['ﾀｲﾑ指数'])
        try:
            df_data['ﾀｲﾑ指数平均'] = sum(df_data['ﾀｲﾑ指数']) / len(df_data['ﾀｲﾑ指数'])
            # print('タイム指数平均：',df_data.at[index_date,'ﾀｲﾑ指数平均'])
        except ZeroDivisionError:
            df_data['ﾀｲﾑ指数平均'] = 0
        df_horse = pd.concat([df_horse,df_data[0:1]], ignore_index=True)
        print(df_data)
        time.sleep(0.1)
    return df_horse

# 予想順に並べる
def bubble_sort_hourse(data_horse, hourse_list):
    # 正規化
    data_horse["賞金平均正規化"] = regularization(data_horse["賞金平均"])
    # 標準化
    data_horse["ﾀｲﾑ指数標準化"] = standardization(data_horse["ﾀｲﾑ指数平均"])
    data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均']] for i in range(len(data_horse))]
    for i in range(len(data_arr)):
        for j in range(len(data_arr)-i-1):
            if ranknet.predict([np.array([data_arr[hourse_list[j]-1]]), np.array([data_arr[hourse_list[j+1]-1]])])[0][0] < 0.5:
                data_arr[hourse_list[j]-1], data_arr[hourse_list[j+1]-1] = data_arr[hourse_list[j+1]-1], data_arr[hourse_list[j]-1]
                hourse_list[j],hourse_list[j + 1] = hourse_list[j + 1], hourse_list[j]
    return hourse_list

# 
def sum_sort(data_horse, hourse_list):
    # 正規化
    data_horse["賞金平均正規化"] = regularization(data_horse["賞金平均"])
    # 標準化
    data_horse["ﾀｲﾑ指数標準化"] = standardization(data_horse["ﾀｲﾑ指数平均"])
    data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均']] for i in range(len(data_horse))]
    horse_result1 = []
    horse_result2 = []
    # print("data_array:",len(data_arr))
    for i,horse_num in enumerate(hourse_list):
        sum = 0
        score = 0
        for j in range(len(hourse_list)):
            if i != j:
                tmp = ranknet.predict([np.array([data_arr[i-1]]), np.array([data_arr[j-1]])])[0][0]
                score += tmp
                if tmp > 0.5:
                    sum += 1
        horse_result1.append([horse_num,sum])
        horse_result2.append([horse_num,score])
    # print(horse_result1)
    sort_list = sorted(horse_result1, key=lambda x:(x[1]), reverse=True)
    score_list = sorted(horse_result2, key=lambda x:(x[1]), reverse=True)
    return sort_list,score_list    


# 一個下の馬に勝つ確率
def find_win_rate(data_horse, hourse_list):
    # 正規化
    data_horse["賞金平均正規化"] = regularization(data_horse["賞金平均"])
    # 標準化
    data_horse["ﾀｲﾑ指数標準化"] = standardization(data_horse["ﾀｲﾑ指数"])
    data_arr = [[data_horse.at[i,'ﾀｲﾑ指数標準化'], data_horse.at[i,'賞金平均正規化'],data_horse.at[i,'着差平均']] for i in range(len(data_horse))]
    win_rate_list = []
    for i in range(len(data_arr)-1):
        win_rate_list.append(ranknet.predict([np.array([data_arr[hourse_list[i]-1]]), np.array([data_arr[hourse_list[i+1]-1]])])[0][0] * 100)
    win_rate_list.append(0)
    return win_rate_list

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
        hourse_url_list = get_horse_url(race_url)
        hourse_list = [i+1 for i in range(len(hourse_url_list))]
        data_horse = make_horse_DataFrame(chrome_driver,hourse_url_list)
        for _ in range(10):
            hourse_list = bubble_sort_hourse(data_horse, hourse_list)
        win_rate_list = find_win_rate(data_horse, hourse_list)
        chrome_driver.close()
        return render_template('result_page.html',text = text , hourse_list=hourse_list, win_rate_list=win_rate_list ,zip=zip)

@app.route('/cheack_page',methods = ["GET", "POST"])
def cheack_page():
    text = "過去の予想"
    #データが届いたら
    if request.method == "POST":
        # 値のデータを取得
        race_url = request.form['race_url']
        chrome_driver = set_up_chrome_driver()
        login_netkeiba(chrome_driver)
        hourse_url_list,date = get_horse_url_and_date(race_url)
        data_horse = cheack_make_horse_DataFrame(chrome_driver,hourse_url_list,date)
        hourse_list = [int(i) for i in data_horse["本番馬番"]]
        print(hourse_list)
        for _ in range(10):
            hourse_list = bubble_sort_hourse(data_horse, hourse_list)
        win_rate_list = find_win_rate(data_horse, hourse_list)
        chrome_driver.close()
        return render_template('result_page.html',text = text , hourse_list=hourse_list, win_rate_list=win_rate_list ,zip=zip)

## おまじない
if __name__ == "__main__":
    app.run(debug=True)