from flask import Flask, request, session, g, redirect, url_for, abort, render_template
import os
import numpy as np
from keras.models import  load_model
import cv2


# ranknetの読み込み
ranknet = load_model("./documents/keiba_ranknet_model")
# resnetの読み込み
# resnet =load_model("./documents/hourse_resnet.h5")

# 予想順に並べる
def bubble_sort_hourse(data_arr, hourse_list):
    for i in range(len(data_arr)):
        for j in range(len(data_arr)-i-1):
            if ranknet.predict([np.array([data_arr[j]]), np.array([data_arr[j+1]])]) < 0.5:
                data_arr[j], data_arr[j + 1] = data_arr[j + 1], data_arr[j]
                hourse_list[j],hourse_list[j + 1] = hourse_list[j + 1], hourse_list[j]

# 画像の予測
# def image_predict(hourse_list):
#     img_index = hourse_list[0]
#     hourse_max = 0
#     for i in range(5):
#         img = cv2.imread('./uploads/h'+str(hourse_list[i])+'_img_file.jpg')
#         img_rot = cv2.resize(img,(64,64))
#         #色成分を分割
#         b,g,r = cv2.split(img_rot)
#         #色成分を結合
#         img_cha = cv2.merge([r,g,b])
#         img_exp = np.expand_dims(img_cha,axis=0)
#         y_p = resnet.predict(img_exp)[0][0]
#         if y_p > hourse_max:
#             hourse_max = y_p
#             img_index = hourse_list[i]
#     return img_index

# 画像をアップロードするフォルダー
upload_folder = './uploads'
# 画像の拡張子の制限
# set()で重複した要素を取り除く
allowed_extenstions = set(["png","jpg","jpeg"])

# お決まり
app = Flask(__name__)
app.secret_key = "hogehoge"

# 設定の保存
# upload_folderの設定を保存
UPLOAD_FOLDER = './uploads/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

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
        hourse_num = request.form['hourse_num']
        data_arr = [[int(request.form['h'+str(i+1)+'_time_num1']),int(request.form['h'+str(i+1)+'_time_num1'])-int(request.form['h'+str(i+1)+'_time_num2']),float(request.form['h'+str(i+1)+'_agari'])] for i in range(int(hourse_num))]
        hourse_list = [i+1 for i in range(int(hourse_num))]
        bubble_sort_hourse(data_arr, hourse_list)

        # ファイルを読み込む
        # for i in range(5):
        #     img_file = request.files['h'+str(hourse_list[i])+'_img_file']
        #     filename = 'h'+str(hourse_list[i])+'_img_file.jpg'
        #     # 画像のアップロード先URLを生成する
        #     img_url = os.path.join(app.config['UPLOAD_FOLDER'], filename) 
        #     # 画像をアップロード先に保存する
        #     img_file.save(img_url)

        # 画像解析
        # index = image_predict(hourse_list)

        return render_template('result_page.html',text = text , hourse_list=hourse_list)

## おまじない
if __name__ == "__main__":
    app.run(debug=True)