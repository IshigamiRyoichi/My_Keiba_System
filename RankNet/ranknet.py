from flask import request
from numpy import random
import tensorflow as tf
from tensorflow.keras import layers, Model, Input
from tensorflow.nn import leaky_relu
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

    # def build_graph(self):
    #     x = [Input(shape=(10)), Input(shape=(10))]
    #     return Model(inputs=x, outputs=self.call(x))


years = [2020,2019,2018,2017,2016,2015,2014,2013,2012,2011]
df = pd.read_csv("./有馬記念Data.csv")
df["タイム指数2-3"] = df["タイム指数2"] - df["タイム指数3"]

index_num = 0
xi = []
xj = []
pij = []
pair_ids = []
pair_query_id = []

for year in years:
    one_year_Data = df[df['年数'] == year]

    # print(one_year_Data.loc[0:0,"タイム指数"])

    index_list = [i for i in range(len(one_year_Data))]
    random.shuffle(index_list)
    for pair_id in combinations(index_list, 2):
        pair_query_id.append(year)
        pair_ids.append(pair_id)
        i = pair_id[0]
        j = pair_id[1]
        xi.append([one_year_Data.at[i+index_num,"タイム指数2"],one_year_Data.at[i+index_num,"タイム指数2-3"],one_year_Data.at[i+index_num,"上り"]])
        xj.append([one_year_Data.at[j+index_num,"タイム指数2"],one_year_Data.at[j+index_num,"タイム指数2-3"],one_year_Data.at[j+index_num,"上り"]])

        if one_year_Data.at[i+index_num,"順位"]  == one_year_Data.at[j+index_num,"順位"] :
            pij_com = 0.5

        elif one_year_Data.at[i+index_num,"順位"]  > one_year_Data.at[j+index_num,"順位"] :
            pij_com = 0

        else:
            pij_com = 1

        pij.append(pij_com)
    index_num += len(one_year_Data)
    index_list.clear()

xi = np.array(xi)
xj = np.array(xj)
pij = np.array(pij)
pair_query_id = np.array(pair_query_id)

xi_train, xi_test, xj_train, xj_test, pij_train, pij_test, pair_id_train, pair_id_test = train_test_split(
    xi, xj, pij, pair_ids, test_size=0.2, stratify=pair_query_id)

ranknet = RankNet()
# ranknet.compile(optimizer='adam', loss='binary_crossentropy',metrics=['accuracy'])
ranknet.compile(optimizer='sgd', loss='binary_crossentropy',metrics=['accuracy'])
test_score = []
history = ranknet.fit([xi_train, xj_train], pij_train, epochs=85, batch_size=4, validation_data=([xi_test, xj_test], pij_test))

score = ranknet.evaluate([xi_test, xj_test], pij_test, batch_size=4, verbose=0)

# test_score.append([ep,bs,score[0],score[1]])

# for test in test_score:
#     print("epochs=",test[0]," batch_size=",test[1]," loss=",test[2]," accurary=",test[3])

print('validation loss:{0[0]}\nvalidation accuracy:{0[1]}'.format(score))

# plt.plot(history.history["acc"], label="acc", ls="-", marker="o")
plt.plot(history.history["val_accuracy"], label="val_acc", ls="-", marker="o")
plt.ylabel("accuracy")
plt.xlabel("epoch")
plt.legend(loc="best")
plt.savefig("ranknet.png")  

# tf.keras.models.save_model(ranknet,'keiba_ranknet_model')
ranknet.save("./keiba_ranknet_model")
# ranknet.save_weights("./keiba_ranknet.hdf5", save_format="hdf5")
ranknet.save_weights("./keiba_ranknet.hdf5")
# joblib.dump(ranknet,'keiba_ranknet_model.pkl2', compress=2)


# f_log = './log/'
# f_model = './model/'

# json_string = ranknet.to_json()
# open('./ranknet_model.json', 'w').write(json_string)
# # yaml_string = ranknet.to_yaml()
# open(os.path.join(f_model,'ranknet_model.yaml'), 'w').write(ranknet.to_yaml())
# print('save weights')
# ranknet.save_weights(os.path.join(f_model,'ranknet_model_weights.hdf5'))

y_predeict = ranknet.predict([xi_test, xj_test])

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