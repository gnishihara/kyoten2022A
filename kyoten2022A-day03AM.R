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

# url = "https://drive.google.com/file/d/1p6uR6YdlUBQFh3IotRMwnqHT_LYPk0PJ&export=download"
# ファイルのダウンロード
#download.file(url, destfile = "./hatatadataset.csv")

################################################################################


dset = read_csv("data/hatatadataset.csv")
names(dset)
dset

# 箱ひげ図

ggplot(dset) + 
  geom_boxplot(aes(x = station, y = PO4))

# 散布図
 
# dset が下流の関数のデフォルトデータ
ggplot(dset) + 
  geom_point(aes(x = station, y = PO4))

# 関数ごとにデータを指定する
# position: 点の場所
# alpha: 透明度
# size : 記号の大きさ
ggplot() + 
  geom_point(aes(x = station, y = PO4),
             data = dset,
             position = position_jitter(width = 0.05,
                                        height = 0),
             alpha = 0.5,
             size = 5)

# shape: 記号の形を変える
# color: 記号の色を変える

ggplot() + 
  geom_point(aes(x = station, y = PO4,
                 shape = station,
                 color = station),
             data = dset,
             position = position_jitter(width = 0.05,
                                        height = 0),
             alpha = 0.5,
             size = 5) + 
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = "リン酸塩 (mg / L)",
                     limits = c(0, 0.4),
                     breaks = seq(0, 0.4, by = 0.1))
  

# 軸タイトルの詳細設定
# PO[4] : ４を下つけ
# ^{-1} : -1 を上つけ
# ~ : 半角スペース
# 
ylabel = "PO[4]~(mg~L^{-1})"
ggplot() + 
  geom_point(aes(x = station, y = PO4,
                 shape = station,
                 color = station),
             data = dset,
             position = position_jitter(width = 0.05,
                                        height = 0),
             alpha = 0.5,
             size = 5) + 
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4),
                     breaks = seq(0, 0.4, by = 0.1))

#
# ?pch を実行して、記号の説明を確認する
# viridis: 色弱に対応している色

ylabel = "PO[4]~(mg~L^{-1})"
ggplot() + 
  geom_point(aes(x = station, 
                 y = PO4,
                 shape = station,
                 fill = station),
             data = dset,
             position = position_jitter(width = 0.05,
                                        height = 0),
             alpha = 0.5,
             size = 5) + 
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4),
                     breaks = seq(0, 0.4, by = 0.1)) +
  scale_shape_manual(name = "",
                       values = c(21, 22, 23, 24)) +
  scale_fill_viridis_d(name = "") +
  theme(legend.position = c(1.0,1.0),
        legend.justification = c(1,1),
        legend.background = element_blank(),
        axis.line = element_line(color = "red",
                                 size = 3, 
                                 linetype = "solid",
                                 lineend = "square"))

######################################################

# 平均値と標準偏差の図
# パイプは CTRL + SHIFT + M
dset |> 
  select(station, PO4) |> 
  print(n = 200)

dsetm = dset |> 
  group_by(station) |> 
  summarise(m = mean(PO4, na.rm = TRUE),
            s = sd(PO4, na.rm = TRUE),
            n_with_na = length(PO4),
            n_no_na   = sum(!is.na(PO4)))


c(T, F, T, F, NA)
is.na(c(T, F, T, F, NA))
sum(is.na(c(T, F, T, F, NA)))
sum(is.na(c(T, F, T, F, NA, NA)))
(!is.na(c(T, F, T, F, NA, NA)))
sum(!is.na(c(T, F, T, F, NA, NA)))


ylabel = "PO[4]~(mg~L^{-1})"
ggplot() +
  geom_point(aes(x = station, 
                 y = m),
             data = dsetm,
             size = 3) +
  geom_errorbar(aes(x = station,
                    ymin = m - s,
                    ymax = m + s),
                data = dsetm,
                width = 0.05) +
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.3),
                     breaks = seq(0, 0.3, by = 0.1)) +
    theme(legend.position = c(1.0,1.0),
        legend.justification = c(1,1),
        legend.background = element_blank())


# ggplot の annotation
# タイトルの追加

ylabel = "PO[4]~(mg~L^{-1})"
text1 = "Mean and one standard deviation."
ggplot() +
  geom_point(aes(x = station, 
                 y = m),
             data = dsetm,
             size = 3) +
  geom_errorbar(aes(x = station,
                    ymin = m - s,
                    ymax = m + s),
                data = dsetm,
                width = 0.05) +
  geom_text(aes(x = station,
                y = m + s + 0.01,
                label = sprintf("n = %d", n_no_na)),
            data = dsetm,
            family = "notosansjp") + 
  annotate("text",
           x = 1,
           y = 0.0,
           label = text1,
           hjust = 0,
           vjust = 0,
           family = "notosansjp") + 
  labs(title = "greg") +
  scale_x_discrete(name = "Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.3),
                     breaks = seq(0, 0.3, by = 0.1)) +
  theme(legend.position = c(1.0,1.0),
        legend.justification = c(1,1),
        legend.background = element_blank())

pdfname = "greg-po4-m-s.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 80,
       units = "mm")



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




# 全データの解析

se = function(x, na.rm = TRUE) {
  s = sd(x, na.rm)
  n = sum(!is.na(x))
  s / sqrt(n - 1)
}

dsetm = dset |> 
  group_by(station) |> 
  summarise(
    across(c(NO23, PO4, NH4),
           list(m = ~mean(.x, na.rm = TRUE),
                s = ~sd(.x, na.rm = TRUE),
                e = se))
  )

dsetl = dsetm |> 
  pivot_longer(cols = c(
    NO23_m, NO23_s, NO23_e,
    PO4_m, PO4_s, PO4_e,
    NH4_m, NH4_s, NH4_e
  ))


dsetl = dsetl |> 
  separate(name, into = c("nutrient", "statistic"))

dsetlm = dsetl |> 
  pivot_wider(names_from = statistic,
              values_from = value)

ylabel = "Concentration~(mg~L^{-1})"
ggplot() + 
  geom_point(aes(x = station,
                 y = m,
                 color = nutrient),
             data = dsetlm,
             position = position_dodge(width = 0.3)) +
  geom_errorbar(aes(x = station,
                    ymin = m - e,
                    ymax = m + e,
                    color = nutrient),
                data = dsetlm,
                position = position_dodge(width = 0.3),
                width = 0.1) +
  scale_color_viridis_d(name = "", 
                        end = 0.8) + 
  scale_x_discrete("Station") +
  scale_y_continuous(name = parse(text = ylabel)) +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.direction = "horizontal",
        legend.background = element_blank())



pdfname = "greg-nutrients-m-e.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 80,
       units = "mm")



library(ggpubr)
theme_pubr(base_family = "notosansjp") |> theme_set()

ylabel = "Concentration~(mg~L^{-1})"
ggplot() + 
  geom_point(aes(x = station,
                 y = m,
                 color = nutrient),
             data = dsetlm,
             position = position_dodge(width = 0.3)) +
  geom_errorbar(aes(x = station,
                    ymin = m - e,
                    ymax = m + e,
                    color = nutrient),
                data = dsetlm,
                position = position_dodge(width = 0.3),
                width = 0.1) +
  scale_color_viridis_d(name = "", 
                        end = 0.8) + 
  scale_x_discrete("Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4)) +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.direction = "horizontal",
        legend.background = element_blank())



pdfname = "greg-nutrients-m-e.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 80,
       units = "mm")




# 
# x-軸ラベルの工夫

dsetlm2 = dsetlm |> 
  mutate(station = factor(
    station,
    levels = c("Control", "Canopy edge", 
               "Canopy interior", "Sand")
  )) |> 
  mutate(nutrient = factor(
    nutrient,
    levels = c("PO4", "NO23", "NH4")
  ))

ylabel = "Concentration~(mg~L^{-1})"
ggplot() + 
  geom_point(aes(x = station,
                 y = m,
                 color = nutrient),
             data = dsetlm2,
             position = position_dodge(width = 0.3)) +
  geom_errorbar(aes(x = station,
                    ymin = m - e,
                    ymax = m + e,
                    color = nutrient),
                data = dsetlm2,
                position = position_dodge(width = 0.3),
                width = 0.1) +
  scale_color_viridis_d(name = "", 
                        end = 0.8) + 
  scale_x_discrete("Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4)) +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.direction = "horizontal",
        legend.background = element_blank())



pdfname = "greg-nutrients-m-e.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 80,
       units = "mm")

####################################################
##
# Patchwork
library(patchwork)

# is.na(direction) == TRUE # 外す
dsetx = dset |> 
  drop_na() |> 
  group_by(direction) |> 
  summarise(
    across(c(NO23, PO4, NH4),
           list(m = ~mean(.x, na.rm = TRUE),
                s = ~sd(.x, na.rm = TRUE),
                e = se))
  )

dsety = dsetx |> 
  pivot_longer(cols = c(
    NO23_m, NO23_s, NO23_e,
    PO4_m, PO4_s, PO4_e,
    NH4_m, NH4_s, NH4_e
  ))


dsety = dsety |> 
  separate(name, into = c("nutrient", "statistic"))

dsetyx = dsety |> 
  pivot_wider(names_from = statistic,
              values_from = value)
dsetyx = dsetyx |> 
  mutate(nutrient = factor(
    nutrient,
    levels = c("PO4", "NO23", "NH4")
  ))


ylabel = "Concentration~(mg~L^{-1})"
plot1 = ggplot() + 
  geom_point(aes(x = station,
                 y = m,
                 color = nutrient),
             data = dsetlm2,
             position = position_dodge(width = 0.3)) +
  geom_errorbar(aes(x = station,
                    ymin = m - e,
                    ymax = m + e,
                    color = nutrient),
                data = dsetlm2,
                position = position_dodge(width = 0.3),
                width = 0.1) +
  scale_color_viridis_d(name = "", 
                        end = 0.8) + 
  scale_x_discrete("Station") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4)) +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.direction = "horizontal",
        legend.background = element_blank())


ylabel = "Concentration~(mg~L^{-1})"
plot2 = ggplot() + 
  geom_point(aes(x = direction,
                 y = m,
                 color = nutrient),
             data = dsetyx,
             position = position_dodge(width = 0.3)) +
  geom_errorbar(aes(x = direction,
                    ymin = m - e,
                    ymax = m + e,
                    color = nutrient),
                data = dsetyx,
                position = position_dodge(width = 0.3),
                width = 0.1) +
  scale_color_viridis_d(name = "", 
                        end = 0.8) + 
  scale_x_discrete("Tidal direction") +
  scale_y_continuous(name = parse(text = ylabel),
                     limits = c(0, 0.4)) +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.direction = "horizontal",
        legend.background = element_blank())



plot1 + plot2 + plot_layout(ncol = 1,
                            guides = "collect")

pdfname = "greg-nutrients2-m-e.pdf"
ggsave(filename = pdfname,
       width = 2*80, 
       height = 2*80,
       units = "mm")






