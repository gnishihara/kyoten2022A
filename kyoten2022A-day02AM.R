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
 

# R関数の作り方（サイコロ）


# tidyverse の紹介

 
