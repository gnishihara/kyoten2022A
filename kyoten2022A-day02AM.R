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
dplyr::near(1/3, 0.33, tol = 0.01)
iris$Sepal.Length <= find_length
iris$Sepal.Length != find_length



 
# R関数の作り方（サイコロ）


# tidyverse の紹介

 
