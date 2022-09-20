# 公開臨海データ解析実習　A日程
# 2022 September 20 AM: 課題
# Greg Nishihara


# （１）サイコロの目の数を８にして、２つのサイコロの和をとる。回数の1000回。
# （２）（１）のヒストグラムを示す。

n = 1:8 # ここでサウコロの目を決める
sum_value = rep(0, times = 1000)
for(i in 1:1000) {
  value = sample(x = n, size = 2, replace = TRUE)
  sum_value[i] = sum(value)
}
sum_value

dicerolls = table(sum_value)
dicerolls = as.data.frame(dicerolls)

barplot(height = dicerolls$Freq,
        names.arg = dicerolls$sum_value)

# （３）サイコロの目の数を6にして、３つのサイコロの和をとる。回数の1000回。
# （４）（１）のヒストグラムを示す。

n = 1:6 # ここでサウコロの目を決める
sum_value = rep(0, times = 1000)
for(i in 1:1000) {
  value = sample(x = n, size = 3, replace = TRUE) # size = 3 に設定すると一度に投げる数をきめる。
  sum_value[i] = sum(value)
}
sum_value

dicerolls = table(sum_value)
dicerolls = as.data.frame(dicerolls)

barplot(height = dicerolls$Freq,
        names.arg = dicerolls$sum_value)


## apply() 関数の使い方