# 公開臨海データ解析実習　A日程
# 2022 September 20 AM
# Greg Nishihara


# 論理値と比較演算

iris #　あやめのデータ

find_length = 5.0 # 検索する・フィルターにかける長さ

# SHIFT+ ALT + 下矢印: 行をコピーする
iris$Sepal.Length > find_length   # よりおおきい
iris$Sepal.Length >= find_length  # 以上


# 等しい, えらーおこしやすいので、
iris$Sepal.Length == find_length
1/3 == 0.3333333333333333

# dplyr　パッケージの near() 関数を使う。
dplyr::near(1/3, 0.33, tol = 0.01) # dplyr の関数
identical(1/3, 0.3)  # Base R の関数
all.equal(1/3, 0.33) # Base R の関数

iris$Sepal.Length <= find_length
iris$Sepal.Length != find_length

## 論理ベクトルをつかって
## データを抽出する

logical_sl = iris$Sepal.Length > find_length   # よりおおきい

iris$Sepal.Length[1]
iris$Sepal.Length[2]
iris$Sepal.Length[c(1, 5)]

iris$Sepal.Length[logical_sl]
iris$Sepal.Length[!logical_sl]

iris$Petal.Length[iris$Petal.Length > 10] # numeric(0) が帰ってくる
iris$Petal.Length[iris$Petal.Length > 6.5] 


logical01 = iris$Petal.Length >= 5
logical02 = iris$Petal.Length <= 6

iris$Petal.Length[logical01] 
iris$Petal.Length[logical02] 

# 5 >= Petal.Length >= 6
iris$Petal.Length[logical01 & logical02] 
iris$Petal.Length[iris$Petal.Length >= 5 & iris$Petal.Length <= 6] 

# 5 >= Petal.Length >= 6 または species == setosa
iris$Petal.Length[(logical01 & logical02) | iris$Species == "setosa"] 

# データフレームを返す方法
# 検索の条件

logical01 = iris$Sepal.Length > 5
logical02 = iris$Sepal.Width  > 3

iris[logical01, ] # Sepal.Length > 5
iris[logical02, ] # Sepal.Width > 3

# Sepal.Length > 5 & Sepal.Width > 3
iris[logical01 & logical02, ] 

# 1行目
#[行 , 列]
iris[1, ]

# 1行目,2から３列め
iris[1, c(2, 3)]


# 論理ベクトルのかけざん
# TRUE: 1
# FALSE: 0
c(TRUE, TRUE, FALSE) * c(FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE) & c(FALSE, TRUE, FALSE)
c(1, 1, 0) * c(0, 1, 0)


# R関数の作り方（サイコロ）
# 6目サイコロ

n = 1:6 # c(1, 2, 3, 4, 5, 6)

# 重複ありサンプリング
sample(x = n, size = 3, replace = TRUE)

# 重複なしサンプリング
sample(x = n, size = 3)

# ２つのサイコロの和
value = sample(x = n, size = 2, replace = TRUE)
sum(value) # サイコロの和
value


## for-loop.

j = 0
for(i in 1:50) {
  print(i)
  j = j + i 
  print(j)
}


value01 = sample(x = n, size = 2, replace = TRUE)
sum_value01 = sum(value01)

value02 = sample(x = n, size = 2, replace = TRUE)
sum_value02 = sum(value02)

value03 = sample(x = n, size = 2, replace = TRUE)
sum_value03 = sum(value03)

value04 = sample(x = n, size = 2, replace = TRUE)
sum_value04 = sum(value04)

value05 = sample(x = n, size = 2, replace = TRUE)
sum_value05 = sum(value05)

c(sum_value01, sum_value02, sum_value03, 
  sum_value04, sum_value05)

sum_value = c(0, 0, 0, 0, 0)
for(i in 1:5) {
  value = sample(x = n, size = 2, replace = TRUE)
  sum_value[i] = sum(value)
  print(sum_value)
}
sum_value

# ２つのサイコロを 1000 投げて、和をとる
sum_value = rep(0, times = 1000)
for(i in 1:1000) {
  value = sample(x = n, size = 2, replace = TRUE)
  sum_value[i] = sum(value)
  print(sum_value)
}
sum_value

mean(sum_value)
sd(sum_value)
median(sum_value)

table(sum_value)

dicerolls = table(sum_value)
dicerolls = as.data.frame(dicerolls)

barplot(height = dicerolls$Freq,
        names.arg = dicerolls$sum_value)


 
