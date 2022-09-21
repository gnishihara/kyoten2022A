# 公開臨海データ解析実習　A日程
# 2022 September 21 AM: 課題
# Greg Nishihara


# NO23 の平均値と標準偏差の図をつくる。
# タイトルに名前をいれる
# 
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
##############################
##############################



dset = read_csv("data/hatatadataset.csv")


dsetno23 = dset |> 
  group_by(station) |> 
  summarise(m = mean(NO23, na.rm = TRUE),
            s = sd(NO23, na.rm = TRUE),
            n_with_na = length(NO23),
            n_no_na   = sum(!is.na(NO23)))


ylabel = "NO[2]+NO[3]~(mg~L^{-1})"
text1 = "Mean and one standard deviation."
ggplot() +
  geom_point(aes(x = station, 
                 y = m),
             data = dsetno23,
             size = 3) +
  geom_errorbar(aes(x = station,
                    ymin = m - s,
                    ymax = m + s),
                data = dsetno23,
                width = 0.05) +
  geom_text(aes(x = station,
                y = m + s + 0.03,
                label = sprintf("n = %d", n_no_na)),
            data = dsetno23,
            family = "notosansjp") + 
  annotate("text",
           x = 1,
           y = 0.8,
           label = text1,
           hjust = 0,
           vjust = 1,
           family = "notosansjp") + 
  labs(title = "greg") +
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(-0.1, 0.8),
                     breaks = seq(0, 0.8, by = 0.2)) +
  theme(legend.position = c(1.0,1.0),
        legend.justification = c(1,1),
        legend.background = element_blank())

pdfname = "greg-no23-m-s.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 80,
       units = "mm")

