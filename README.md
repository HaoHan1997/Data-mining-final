# Data-mining-final
数据挖掘机期末大挖掘。

## Problem 1 数据筛选

已完成。

### Usage
```bash
cd Step1
python filter_data.py
```
然后会生成ratings_test.txt, ratings_train.txt，分别是测试集和训练集数据，
单行数据用半角逗号分离，格式如下：
```
用户ID,电影ID,评级,时间戳
```

## Problem 2 Recommendation 推荐算法
蛋疼的20分，第三步居然要看论文 \_(:з」∠)_。
### Usage
执行顺序：

1. 初始化（problem2_init.m）【不推荐直接运行，请下载该步骤的<a href="http://pan.baidu.com/s/1qXsR3n2">缓存数据</a>，放在Problem2文件夹下】
2. 使用item-based baseline estimator预测（step1.m）。
3. 初始化Step2（step2_init.m）【不推荐直接运行，请下载该步骤的<a href="http://pan.baidu.com/s/1hqYjhxa">缓存数据</a>，放在Problem2文件夹下】
4. 使用item-based neighbour estimator预测（step2_1.m）。
5. 使用user-based neighbour estimator预测（step2_2.m）。
6. TODO

### 生成的csv

自带的ratings_train.csv和ratings_test.csv就是第一步生成的txt改个后缀名而已。
执行以上步骤后会生成以下csv文件：

1. baseline_predict.csv
2. neighbour_predict_1.csv
3. neighbour_predict_2.csv

每行格式为：

预测值,真实值,均方差,从第一行开始的均方差之和

## Problem 3 K-means Clustering K-means聚类

TODO

## Problem 4

TODO