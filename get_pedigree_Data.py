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
import openpyxl
import glob
import re
import io
import time
import json

# def set_up_chrome_driver():
#     # ここでいろいろやる
#     options = Options() 
#     options.binary_location = '/usr/bin/google-chrome' 
#     #chrome binary location specified here 
#     options.add_argument('--start-maximized') 
#     #open Browser in maximized mode 
#     options.add_argument('--no-sandbox') 
#     #bypass OS security model 
#     options.add_argument('--disable-dev-shm-usage') 
#     #overcome limited resource problems 
#     options.add_experimental_option('excludeSwitches', ['enable-automation']) 
#     options.add_experimental_option('useAutomationExtension', False) 
#     chrome_driver = webdriver.Chrome(options=options, executable_path=r'/usr/bin/chromedriver')
#     return chrome_driver

# 各コースのurlを一覧にする
def get_course_data_list(site_url):
    res_race = requests.get(site_url)
    # エラーチェック
    res_race.raise_for_status()
    # htmlデータ抽出
    soup_race = bs4.BeautifulSoup(res_race.content, 'lxml')
    table_elems = soup_race.find('table')
    a_elems = table_elems.select('a')
    course_data_list = []
    for a_elem in a_elems:
        tmp = a_elem.get('href')
        course_data_list.append('http://cani.fool.jp/total/sbb/' + tmp)
    return course_data_list

# コース事にdfを生成
def create_course_df(course_data):
    res_race = requests.get(course_data)
    # エラーチェック
    res_race.raise_for_status()
    # htmlデータ抽出
    soup_race = bs4.BeautifulSoup(res_race.content, 'lxml')
    table_pedigree = soup_race.select('table')
    with io.StringIO(str(table_pedigree)) as f:
        df = pd.read_html(f)[0]
    return df

# csv出力
def write_csv(df, csv_file_name):
    csv_file_name = csv_file_name.replace('http://cani.fool.jp/total/', './documents/excel/').replace('htm','xlsx')
    df.to_excel(csv_file_name)

# csvを編集
def edit_csv():
    csv_list = glob.glob('./documents/excel/*/*.xlsx')
    for csv_data in csv_list:
        wb = openpyxl.load_workbook(csv_data)
        # csv_sheet = csv_data.replace('./documents/excel/course_data/','').replace('.xlsx','')
        # print(csv_sheet)
        ws = wb['Sheet1']
        ws.delete_rows(1)
        ws.delete_cols(23,3)
        ws.delete_cols(1,11)
        wb.save(csv_data)


if __name__=='__main__':
    sbb_data_list = get_course_data_list('http://cani.fool.jp/total/sbb/1sbbindex.htm')
    for sbb_data in sbb_data_list:
        try:
            df_sbb = create_course_df(sbb_data)
            kisyu_data = sbb_data.replace('sbb','kisyu')
            df_kisyu = create_course_df(sbb_data)
            maec_data = sbb_data.replace('sbb','maec')
            df_maec = create_course_df(sbb_data)
            write_csv(df_sbb, sbb_data)
            write_csv(df_kisyu, kisyu_data)
            write_csv(df_maec, maec_data)
        except:
            print('access error')
    edit_csv()