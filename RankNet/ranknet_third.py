import glob
from numpy import random
from tensorflow.keras import layers, Model
from tensorflow.nn import leaky_relu
import tensorflow as tf
import numpy as np
from itertools import combinations
import random
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
import statistics
import scipy.stats
import pandas as pd
import matplotlib.pyplot as plt

# model architecture
class RankNet(Model):
    def __init__(self):
        super().__init__()
        self.dense = [layers.Dense(4, activation=leaky_relu),layers.Dense(3, activation=leaky_relu), layers.Dense(2, activation=leaky_relu)]
        self.o = layers.Dense(1, activation='linear')
        self.oi_minus_oj = layers.Subtract()
    
    def call(self, inputs):
        xi, xj = inputs
        densei = self.dense[0](xi)
        densej = self.dense[0](xj)
        for dense in self.dense[1:]:
            densei = dense(densei)
            densej = dense(densej)
        oi = self.o(densei)
        oj= self.o(densej)
        oij = self.oi_minus_oj([oi, oj])
        output = layers.Activation('sigmoid')(oij)
        return output

# 正規化関数
def regularization(df):
    return (df - df.min()) / (df.max() - df.min())
    # return preprocessing.minmax_scale(df)

# 標準化関数
def standardization(df):
    return (df - df.mean()) / df.std()

score = []
csv_list = glob.glob('../documents/csv/2023_4_02/阪神2R.csv')
for csv in csv_list:
    k = 0
    xi = []
    xj = []
    pij = []
    pair_ids = []
    pair_query_id = []

    df = pd.read_csv(csv)
    # df.drop(df.loc[pd.isnull(df['賞金平均']) | pd.isnull(df['ﾀｲﾑ指数平均'])].index, inplace=True)
    df.drop(df.loc[ pd.isnull(df['上り差平均']) | pd.isnull(df['着差平均_condision'])  | pd.isnull(df['相手勝率'])  | pd.isnull(df['相手着差']) | pd.isnull(df['本番着順']) | pd.isnull(df['予想タイム差']) ].index, inplace=True)
    df = df.reset_index(drop=True).copy()
    # 正規化
    # df["賞金平均正規化"] = regularization(df["賞金平均"])
    df["上り正規化"] = regularization(df["上り差平均"])
    # df["前ペース平均"] = regularization(df["前ペース平均"])
    # 標準化
    # df["ﾀｲﾑ指数標準化"] = standardization(df["ﾀｲﾑ指数平均"])
    # df["上り標準化"] = standardization(df["上り"])
    df["本番着順"] = df["本番着順"].astype(int)
    df["予想タイム標準化"] = standardization(df["予想タイム差"])

    index_num = 0
    print(len(df))
    while(k<len(df)):
        one_year_Data = []
        print("---------------")
        for _ in range(len(df)):
            if k+1 >= len(df) or df.at[k,"本番着順"] > df.at[k+1,"本番着順"]:
                break
            print(k,"行目:",df.at[k,"本番着順"],df.at[k+1,"本番着順"])
            one_year_Data.append(k)
            k += 1
        k += 1

        # print(one_year_Data)

        random.shuffle(one_year_Data)
        for pair_id in combinations(one_year_Data, 2):
            # pair_query_id.append(year)
            pair_ids.append(pair_id)
            i = pair_id[0]
            j = pair_id[1]
            # print(i,":",j)
            # df.at[i,'ﾀｲﾑ指数_調整_合計'],
            xi.append([df.at[i,'着差平均_condision'],df.at[i,'勝率_condision'], df.at[i,"上り正規化"], df.at[i,"予想タイム標準化"]])
            xj.append([df.at[j,'着差平均_condision'],df.at[j,'勝率_condision'], df.at[j,"上り正規化"], df.at[j,"予想タイム標準化"]])

            if df.at[i,"本番着順"]  == df.at[j,"本番着順"] :
                pij_com = 0.5

            elif df.at[i,"本番着順"]  > df.at[j,"本番着順"] :
                pij_com = 0

            else:
                pij_com = 1

            pij.append(pij_com)

    xi = np.array(xi,dtype = 'float')
    xj = np.array(xj,dtype = 'float')
    pij = np.array(pij,dtype = 'float')
    # print(xi[0])



    print(len(xi))

    xi_train, xi_test, xj_train, xj_test, pij_train, pij_test = train_test_split(xi, xj, pij, test_size=0.2)


    ranknet = RankNet()
    ranknet.compile(optimizer='sgd', loss=tf.keras.losses.LogCosh(), metrics=['accuracy'])
    history = ranknet.fit([xi_train, xj_train], pij_train, epochs=150, batch_size=4, validation_data=([xi_test, xj_test], pij_test))

    model_score = ranknet.evaluate([xi_test, xj_test], pij_test, batch_size=4, verbose=0)


    print('validation loss:{0[0]}\nvalidation accuracy:{0[1]}'.format(model_score))

    plt.plot(history.history["val_accuracy"], label="val_acc", ls="-", marker="o")
    plt.ylabel("accuracy")
    plt.xlabel("epoch")
    plt.legend(loc="best")
    plt.savefig("ranknet.png")  

    # ranknet.save("./keiba_ranknet_model")
    model_name = csv.replace(".csv","").replace("/csv/","/model/")+"_model"
    ranknet.save(model_name)

    y_predeict = ranknet.predict([xi_test, xj_test])

    print(y_predeict)

    # tp = 0
    # fp = 0
    # tn = 0
    # fn = 0
    # for t,p in zip(pij_test, y_predeict):
    #     if t == 0 and p < 0.5:
    #         # print("合っている")
    #         # print(y_predeict[tp+fp+tn+fn],xi_test[tp+fp+tn+fn],xj_test[tp+fp+tn+fn])
    #         tp += 1
    #     elif t == 0 and p > 0.5:
    #         # print("間違ってる")
    #         # print(y_predeict[tp+fp+tn+fn],xi_test[tp+fp+tn+fn],xj_test[tp+fp+tn+fn])
    #         fp += 1
    #     elif t == 1 and p < 0.5:
    #         # print("間違ってる")
    #         # print(y_predeict[tp+fp+tn+fn],xi_test[tp+fp+tn+fn],xj_test[tp+fp+tn+fn])
    #         fn += 1
    #     elif t == 1 and p > 0.5:
    #         # print("合っている")
    #         # print(y_predeict[tp+fp+tn+fn],xi_test[tp+fp+tn+fn],xj_test[tp+fp+tn+fn])
    #         tn += 1
    # conf_mat = np.array([[tp,fp],[fn,tn]])
    # print("混同行列\n",conf_mat)
    # print('精度:',(tp+tn)/(tp+fp+tn+fn))
    score.append([model_name,model_score])

for s in score:
    print(s)