# 公開臨海データ解析実習　A日程
# 2022 September 20 PM
# Greg Nishihara

# tidyverse の紹介
library(tidyverse)
 
# コンマ区切りファイルの読み込み関数
# read.csv() # base R　関数
read_csv() # tidyverse (readr) 関数

url1 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201007.csv"
url2 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201110.csv"
url3 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201223.csv"
url4 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_210326.csv"
url5 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_210528.csv"
url6 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_220116.csv"

ds1 = read_csv(file = url1, skip = 1)
ds2 = read_csv(file = url2, skip = 1)
ds3 = read_csv(file = url3, skip = 1)
ds4 = read_csv(file = url4, skip = 1)
ds5 = read_csv(file = url5, skip = 1)
ds6 = read_csv(file = url6, skip = 1)

ds1 # tidyverse の data frame は　tibble 

# matches() は正規表現で変数名を探します

ds1 = rename(ds1, 
       n = `#`,
       datetime = `日付 時間, GMT+09:00`,
       par = matches("PAR"),
       wind = matches("風速"),
       gust = matches("突風"),
       pressure = matches("mbar"))

ds2 = rename(ds2, 
             n = `#`,
             datetime = `日付 時間, GMT+09:00`,
             par = matches("PAR"),
             wind = matches("風速"),
             gust = matches("突風"),
             pressure = matches("mbar"))

ds3 = rename(ds3, 
             n = `#`,
             datetime = `日付 時間, GMT+09:00`,
             par = matches("PAR"),
             wind = matches("風速"),
             gust = matches("突風"),
             pressure = matches("mbar"))

ds4 = rename(ds4, 
             n = `#`,
             datetime = `日付 時間, GMT+09:00`,
             par = matches("PAR"),
             wind = matches("風速"),
             gust = matches("突風"),
             pressure = matches("mbar"))

ds5 = rename(ds5, 
             n = `#`,
             datetime = `日付 時間, GMT+09:00`,
             par = matches("PAR"),
             wind = matches("風速"),
             gust = matches("突風"),
             pressure = matches("mbar"))

ds6 = rename(ds6, 
             n = `#`,
             datetime = `日付 時間, GMT+09:00`,
             par = matches("PAR"),
             wind = matches("風速"),
             gust = matches("突風"),
             pressure = matches("mbar"))

# データの読み方

# データの操作

# 作図



