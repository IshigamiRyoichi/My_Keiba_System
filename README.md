# My_Keiba_System

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