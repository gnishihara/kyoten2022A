# 公開臨海データ解析実習　A日程
# 2022 September 20 PM
# Greg Nishihara

# tidyverse の紹介
library(tidyverse)
library(lubridate)
 
# コンマ区切りファイルの読み込み関数
# read.csv() # base R　関数
read_csv() # tidyverse (readr) 関数

url1 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201007.csv"
url2 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201110.csv"
url3 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_201223.csv"
url4 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_210326.csv"
url5 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_210528.csv"
url6 = "https://raw.githubusercontent.com/gnishihara/kyoten2022A/master/data/Microstation_00_ecser_surface_220116.csv"

# path1 = "./data/Microstation_00_ecser_surface_201007.csv"

ds1 = read_csv(file = url1, skip = 1)
# ds1 = read_csv(file = path1, skip = 1)
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

ds6 # 最初の10行
tail(ds6) # 最後の６行


# |> # パイプ記号 CTRL+SHIFT+M
ds6 |> tail()

ds6 |> slice(1:12) |> tail() # パイプにの連結
tail(slice(ds6, 1:12))       # 関数のネスティング
  
sample(1:6, size =  3) |> mean()

# 複数データの結合

# ds1 4911 x 6
# ds2 6200 x 6
dset = bind_rows(ds1, ds2, ds3, ds4, ds5, ds6)

# lubridate::parse_date_time()

# 時間データを文字列から時間データへ変換する
dset = dset |> 
  mutate(datetime = parse_date_time(datetime,
                              orders = "mdyT"))
# 時間データの切り捨て処理
dset = dset |> 
  mutate(datetime = floor_date(datetime, 
                              unit = "minutes"))

# 一日におけるデータ数
6 * 24

dset = dset |> 
  mutate(day = floor_date(datetime, 
                          unit = "days"))

dset |> 
  group_by(day) |> 
  filter(length(day) < (6 * 24)) 

# 144 点のデータだけ残す
dset = dset |> 
  group_by(day) |> 
  filter(near(length(day), 6 * 24)) 

dset

# day ごとの平均値

dset_summary = dset |> 
  group_by(day) |> 
  summarise(wind = mean(wind),
            gust = mean(gust),
            par  = mean(par),
            pressure = mean(pressure))


# 作図


ggplot(dset_summary) + 
  geom_point(aes(x = day,
                 y = pressure))

ggplot(dset_summary) + 
  geom_point(aes(x = pressure,
                 y = wind))


ggplot(dset_summary) + 
  geom_point(aes(x = pressure,
                 y = wind)) +
  scale_x_continuous(name = "平均気圧 (mbar)",
                     breaks = c(990, 1000, 1010, 1020, 1030, 1040),
                     limits = c(990, 1040)) +
  scale_y_continuous(name = "平均風速 (m / s)",
                     breaks = seq(0, 8, by = 2),
                     limits = c(0, 8))


ggsave("mbar-wind.pdf", width = 80, height = 80, units = "mm")

# オプションパッケージのインストール
install.packages("showtext")
install.packages("magick")

library(showtext)
library(magick)

################################################################
# 日本語フォントの準備
 
font_files() |> as_tibble() # システムフォントの閲覧
font_files() |> as_tibble() |>
  filter(str_detect(ps_name, "NotoSansCJK")) |> 
  select(file, face, ps_name) 

# 埋め込みフォントの指定
font_add(family = "notosansjp",
         regular = "NotoSansCJKjp-Regular.otf")

# フォントを有効にする
theme_gray(base_family = "notosansjp") |> theme_set()

# Windows の場合
font_add(family = "meiryo", regular = "meiryo.ttc")
theme_gray(base_family = "meiryo") |> theme_set()
showtext_auto()
################################################################

ggplot(dset_summary) + 
  geom_point(aes(x = pressure,
                 y = wind)) +
  scale_x_continuous(name = "平均気圧 (mbar)",
                     breaks = c(990, 1000, 1010, 1020, 1030, 1040),
                     limits = c(990, 1040)) +
  scale_y_continuous(name = "平均風速 (m / s)",
                     breaks = seq(0, 8, by = 2),
                     limits = c(0, 8))

ggsave("mbar-wind.pdf", width = 80, height = 80, units = "mm")



pdfname = "greg-mbar-wind.pdf"
pngname = "greg-mbar-wind.png"

library(magick)
img = image_read_pdf(pdfname, density = 600)
image_write(img, path = pngname)









