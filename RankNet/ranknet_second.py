import glob
from numpy import random
from tensorflow.keras import layers, Model
from tensorflow.nn import leaky_relu
import tensorflow as tf
import numpy as np
from itertools import combinations
import random
from sklearn.model_selection import train_test_split
import pandas as pd
import matplotlib.pyplot as plt

# model architecture
class RankNet(Model):
    def __init__(self):
        super().__init__()
        self.dense = [layers.Dense(16, activation=leaky_relu), layers.Dense(8, activation=leaky_relu)]
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

score = []
csv_list = glob.glob('../documents/csv/race/*.csv')
for csv in csv_list:
    k = 0
    xi = []
    xj = []
    pij = []
    pair_ids = []
    pair_query_id = []

    df = pd.read_csv(csv)
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
            xi.append([df.at[i,"ﾀｲﾑ指数"],df.at[i,"賞金平均"],df.at[i,"着差平均"],df.at[i,"上り"]])
            xj.append([df.at[j,"ﾀｲﾑ指数"],df.at[j,"賞金平均"],df.at[j,"着差平均"],df.at[j,"上り"]])

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



    print(len(xi))

    xi_train, xi_test, xj_train, xj_test, pij_train, pij_test = train_test_split(xi, xj, pij, test_size=0.2)


    ranknet = RankNet()
    ranknet.compile(optimizer='sgd', loss=tf.keras.losses.LogCosh(), metrics=['accuracy'])
    history = ranknet.fit([xi_train, xj_train], pij_train, epochs=100, batch_size=4, validation_data=([xi_test, xj_test], pij_test))

    score = ranknet.evaluate([xi_test, xj_test], pij_test, batch_size=4, verbose=0)


    print('validation loss:{0[0]}\nvalidation accuracy:{0[1]}'.format(score))

    plt.plot(history.history["val_accuracy"], label="val_acc", ls="-", marker="o")
    plt.ylabel("accuracy")
    plt.xlabel("epoch")
    plt.legend(loc="best")
    plt.savefig("ranknet.png")  

    # ranknet.save("./keiba_ranknet_model")
    model_name = csv.replace(".csv","").replace("/csv/race/","/model/")+"_model"
    ranknet.save(model_name)

    y_predeict = ranknet.predict([xi_test, xj_test])

    print(y_predeict)

    tp = 0
    fp = 0
    tn = 0
    fn = 0
    for t,p in zip(pij_test, y_predeict):
        if t == 0 and p < 0.5:
            tp += 1
        elif t == 0 and p > 0.5:
            fp += 1
        elif t == 1 and p < 0.5:
            fn += 1
        elif t == 1 and p > 0.5:
            tn += 1
    conf_mat = np.array([[tp,fp],[fn,tn]])
    print("混同行列\n",conf_mat)
    print('精度:',(tp+tn)/(tp+fp+tn+fn))
    score.append([model_name,(tp+tn)/(tp+fp+tn+fn)])

for s in score:
    print(s)