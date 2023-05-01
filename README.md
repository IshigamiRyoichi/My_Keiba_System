# My_Keiba_System

## データ整形に利用するデータ作成
```
$ getSpeedData.py
```

## スクレイピング
* `documents/JSON/session.json`を作成
```
{
    "login_id":"netkeibaのid",
    "pswd":"netkeibaのパスワード"
}
```
* 実行
```
$ python3 getData4.py
```

## RankNetのモデルを作成

* `RankNEt/rabknet_third.py`の読み込むcsvファイルを指定
```python
csv_list = glob.glob('任意のcsvファイル')
```

* 実行
```
$ cd RabkNet
$ python3 rabknet_third.py
```

## Webアプリケーションの実行
* 実行
```
$ python3 keiba_app.py
```

* `localhost:5000/main`にアクセス