# 公開臨海データ解析実習　A日程
# 2022 September 21 AM
# Greg Nishihara

# tidyverse の紹介
library(tidyverse)
library(lubridate)
library(magick)
library(showtext)

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
# font_add(family = "meiryo", regular = "meiryo.ttc")
# theme_gray(base_family = "meiryo") |> theme_set()
showtext_auto()
################################################################
# このリンクからCSVファイルをDLする。
url = "https://drive.google.com/file/d/1p6uR6YdlUBQFh3IotRMwnqHT_LYPk0PJ/view?usp=sharing"

download.file(url, destfile = "./hatatadataset.csv")





















