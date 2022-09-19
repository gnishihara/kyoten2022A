# 公開臨海データ解析実習　A日程
# 2022 September 19
# Greg Nishihara

# 代入演算子の使い方

a = 4.2　 # これもつかえます
b <- 5.2  # 伝統的なやりかた
# 3 -> B # つかわない
# 4 = D  # つかえない

A = a * 2
B = sqrt(b)

# R のオブジェクト名のルール
# １）アルファベットと数字と _, .　をつかう
# ２）小文字と大文字は区別される
# ３）空白記号はつかわない
# 無効なオブジェクト名
#   123Base
#   base 123
#   Base-123
#   Base123&
# 有効なオブジェクト名
#   Base
#   BaSe
#   Base123
#   Base_123
#   Base.123

# R の関数は 関数名()
a = c(1, 2, 3, 4, 5)
a
# 平均値の関数
mean(a)

# 総和の関す
sum(a)

# 値の数(ベクトル要素の数)
length(a)

sum(a) / length(a) # これも平均値


# 　データタイプ

a = c(25.5, 27.8, 24.4)
class(a) # numeric, double

# 文字列は "" をつかって囲む
b = c("rabbit", "cat", "dog")
class(b) # character
length(b)


# 論理値
d = c(TRUE, FALSE, T, F)
class(d) # logical

# 因子（要因）

factor(b) # あいうえお・アルファベット順

factor(b, levels = c("dog", "rabbit", "cat")) # 因子のレベル順を指定する

B = factor(b,
           levels = c("dog", "rabbit", "cat"),
           labels = c("犬", "うさぎ", "猫"))

class(B) # factor


#####################################
# 14:55 まで休憩
# チャットの google form にいって、データを入れてください。
#####################################


siblings = c(3, 1, 1, 2, 1, 1, 2,
             1, 3, 1, 1, 0, 3, 2,
             1, 2, 1, 0, 3, 0, 1,
             1, 1, 0)
siblings

length(siblings) #　ベクトルの長さ

# 平均値、標準偏差、標準誤差、中央地
mean(siblings)
sd(siblings)
median(siblings)

# 標準誤差の求め方
# standard deviation / sqrt(n - 1)

sdev = sd(siblings)
n = length(siblings)
sdev / sqrt(n - 1)

# 自作関数

se = function(x) {
  sdev = sd(x)
  n = length(x)
  sdev / sqrt(n - 1)
  # sdev / sqrt(n)
}

se(siblings)


university = c(
  "長崎大学",
  "北海道大学",
  "近畿大学",
  "長崎大学",
  "近畿大学",
  "北海道大学",
  "長崎大学",
  "近畿大学",
  "長崎大学",
  "鹿児島大学",
  "奈良女子大学",
  "帯広畜産大学",
  "近畿大学",
  "長崎大学",
  "北海道大学",
  "帯広畜産大学",
  "東京海洋大学",
  "筑波大学",
  "長崎大学",
  "近畿大学",
  "長崎大学",
  "長崎大学",
  "北海道大学"
)

unitab = table(university)
class(unitab)
unitab

# データフレーム
unitab = as.data.frame(unitab)
class(unitab)

# データフレームの要素の抽出

unitab$university
unitab$Freq

unitab[["university"]]
unitab[["Freq"]]

unitab_names = names(unitab)
unitab_names

## ベクトルの要素を抽出する
unitab_names[1]
unitab_names[2]

unitab[[unitab_names[1]]]

a = unitab_names[1]
a
unitab[[a]]

b = unitab_names[2]
b
unitab[[b]]


barplot(height = unitab$Freq,
        names.arg = unitab$university)










