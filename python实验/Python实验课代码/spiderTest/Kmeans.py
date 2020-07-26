from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt
import numpy as np

# 生成聚类所用数据集
X,y = make_blobs(n_samples=150,
                 n_features=2,
                 centers=3,
                 cluster_std=0.5,
                 shuffle=True,
                 random_state=0)
# 欧氏距离计算
def distEclud(x, y):
    return sum([(i - j) ** 2 for i, j in zip(x, y)]) ** 0.5  # 计算欧氏距离


# 为给定数据集构建一个包含K个随机质心的集合
def randCent(dataSet, k):
    m, n = dataSet.shape
    centroids = np.zeros((k, n))
    for i in range(k):
        index = int(np.random.uniform(0, m))  # 生成一个正态分布的随机数
        centroids[i, :] = dataSet[index, :]  # 用随机数作为索引，指定某k个样本为质心
    return centroids  # centroids: [[x1, y1],[x2, y2], ...] 里面每个都是质心


# k均值聚类
def KMeans(dataSet, k, max_iter=3, random_state=0):
    np.random.seed(random_state)
    cur_iter = 1
    m = np.shape(dataSet)[0]  # 行的数目
    # 第一列存样本属于哪一簇
    # 第二列存样本的到簇的中心点的误差
    clusterAssment = np.mat(np.zeros((m, 2)))
    clusterChange = True

    # 随机选择k个质心
    centroids = randCent(dataSet, k)
    while clusterChange:  # 开始迭代
        clusterChange = False

        # 遍历所有的样本（行）
        for i in range(m):
            minDist = 100000.0  # 假设一个足够大的距离，然后逐渐通过更新缩小
            minIndex = -1

            # 遍历所有的质心
            # 第2步 找出最近的质心
            for j in range(k):
                # 计算该样本到质心的欧式距离
                distance = distEclud(centroids[j, :], dataSet[i, :])
                if distance < minDist:  # 如果比原有类的质心更近，那么更新最小距离，与新的类
                    minDist, minIndex = distance, j
                    clusterAssment[i, :] = minIndex, minDist ** 2
            # 更新每一行样本所属的簇，如果没有更新，说明中心点已经不会变化了，所以停止迭代
            if clusterAssment[i, 0] != minIndex:
                clusterChange = True


                # 更新质心：计算各簇的中心点，替代原有的中心点
        if clusterChange:
            for j in range(k):
                pointsInCluster = dataSet[np.nonzero(clusterAssment[:, 0].A == j)[0]]  # 获取簇类所有的点
                centroids[j, :] = np.mean(pointsInCluster, axis=0)  # 对矩阵的行求均值

        if cur_iter == max_iter:
            clusterChange = False
            print('达到最大迭代次数:{}次'.format(max_iter))
        else:
            cur_iter += 1

    return centroids, clusterAssment


def showCluster(dataSet, k, centroids, clusterAssment):
    # 绘制所有的样本
    plt.scatter(dataSet[:, 0], dataSet[:, 1], c=[i[0] for i in clusterAssment[:, 0].tolist()])
    # 绘制质心
    plt.scatter(centroids[:, 0], centroids[:, 1], c='r')
    plt.show()


def Kmean_show_sse(X, k=3, max_iter=3, random_state=0):
    centroids,clusterAssment = KMeans(X,k,max_iter,random_state)
    sse = sum([i[0] for i in clusterAssment[:, 1].A])
    return sse

Kmean_show_sse(X, 1, 30, random_state=1)