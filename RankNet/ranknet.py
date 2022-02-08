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

xi = []
xj = []
pij = []
pair_ids = []
pair_query_id = []
years = ['2021','2020','2019','2018','2017','2016','2015','2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004','2003','2002']
csv_list = glob.glob('../documents/csv/*.csv')

for csv in csv_list:
    df = pd.read_csv(csv)
    index_num = 0
    for year in years:
        one_year_Data = df[df['日付'].str.contains(year)].index.tolist()

        # print("a",one_year_Data)
        # print(one_year_Data.loc[0:0,"タイム指数"])

        # index_list = [i for i in range(len(one_year_Data))]
        random.shuffle(one_year_Data)
        for pair_id in combinations(one_year_Data, 2):
            # pair_query_id.append(year)
            pair_ids.append(pair_id)
            i = pair_id[0]
            j = pair_id[1]
            # print("i:",df.at[i,"ﾀｲﾑ指数平均"],df.at[i,"賞金平均"],df.at[i,"着差平均"])
            # print("j:",df.at[j,"ﾀｲﾑ指数平均"],df.at[j,"賞金平均"],df.at[j,"着差平均"])
            xi.append([df.at[i,"ﾀｲﾑ指数平均"],df.at[i,"賞金平均"],df.at[i,"着差平均"]])
            xj.append([df.at[j,"ﾀｲﾑ指数平均"],df.at[j,"賞金平均"],df.at[j,"着差平均"]])

            if df.at[i,"本番着順"]  == df.at[j,"本番着順"] :
                pij_com = 0.5

            elif df.at[i,"本番着順"]  > df.at[j,"本番着順"] :
                pij_com = 0

            else:
                pij_com = 1

            pij.append(pij_com)
        # index_num += len(one_year_Data)
        # index_list.clear()

xi = np.array(xi,dtype = 'float')
xj = np.array(xj,dtype = 'float')
pij = np.array(pij,dtype = 'float')

# pair_query_id = np.array(pair_query_id)

print(len(xi))

xi_train, xi_test, xj_train, xj_test, pij_train, pij_test = train_test_split(xi, xj, pij, test_size=0.2)

print(xi_train)
print(xi_test)
print(xj_train)
print(xj_test)
print(pij_train)
print(pij_test)
print(len(xi_train))
print(len(xi_test))
print(len(xj_train))
print(len(xj_test))
print(len(pij_train))
print(len(pij_test))

np.savetxt("./txt/xi_train.txt",xi_train)
np.savetxt("./txt/xi_test.txt",xi_test)
np.savetxt("./txt/xj_train.txt",xj_train)
np.savetxt("./txt/xj_test.txt",xj_test)
np.savetxt("./txt/pij_train.txt",pij_train)
np.savetxt("./txt/pij_test.txt",pij_test)

ranknet = RankNet()
# ranknet.compile(optimizer='adam', loss='binary_crossentropy',metrics=['accuracy'])
ranknet.compile(optimizer='sgd', loss=tf.keras.losses.LogCosh(), metrics=['accuracy'])
# ranknet.compile(optimizer='sgd', loss='mean_squared_error', metrics=['accuracy'])
# test_score = []
history = ranknet.fit([xi_train, xj_train], pij_train, epochs=100, batch_size=32, validation_data=([xi_test, xj_test], pij_test))

score = ranknet.evaluate([xi_test, xj_test], pij_test, batch_size=32, verbose=0)

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
# ranknet.save_weights("./keiba_ranknet.hdf5")
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

print(y_predeict)
np.savetxt('./txt/predeict.txt', y_predeict)

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