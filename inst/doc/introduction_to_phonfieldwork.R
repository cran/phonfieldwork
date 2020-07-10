## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
#  install.packages("phonfieldwork")

## -----------------------------------------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("agricolamz/phonfieldwork")

## ---- eval=TRUE---------------------------------------------------------------
library("phonfieldwork")

## ---- eval=TRUE---------------------------------------------------------------
packageVersion("phonfieldwork")

## ---- eval=TRUE---------------------------------------------------------------
citation("phonfieldwork")

## -----------------------------------------------------------------------------
#  my_stimuli <- c("tip", "tap", "top")

## -----------------------------------------------------------------------------
#  my_stimuli_df <- read.csv("my_stimuli_df.csv")
#  my_stimuli_df

## -----------------------------------------------------------------------------
#  library("readxl")
#  # run install.packages("readxl") in case you don't have it installed
#  my_stimuli_df <- read_xlsx("my_stimuli_df.xlsx")
#  my_stimuli_df

## -----------------------------------------------------------------------------
#  create_presentation(stimuli = my_stimuli_df$stimuli,
#                      output_file = "first_example",
#                      output_dir = getwd())

## -----------------------------------------------------------------------------
#  rename_soundfiles(stimuli = my_stimuli_df$stimuli,
#                    prefix = "s1_",
#                    path = "s1/")

## -----------------------------------------------------------------------------
#  rename_soundfiles(stimuli = my_stimuli_df$stimuli,
#                    prefix = "s2_",
#                    suffix = paste0("_", 1:3),
#                    path = "s2/",
#                    backup = FALSE)

## -----------------------------------------------------------------------------
#  get_sound_duration("s1/s1_tap.wav")

## -----------------------------------------------------------------------------
#  get_sound_duration(sounds_from_folder = "s2/")

## -----------------------------------------------------------------------------
#  concatenate_soundfiles(path = "s1/",
#                         result_file_name = "s1_all")

## ---- echo=FALSE--------------------------------------------------------------
#  draw_sound("s1/s1_all.wav", "s1/s1_all.TextGrid")

## -----------------------------------------------------------------------------
#  my_stimuli_df$stimuli
#  annotate_textgrid(annotation =  sort(my_stimuli_df$stimuli),
#                    textgrid = "s1/s1_all.TextGrid")

## ---- echo=FALSE--------------------------------------------------------------
#  draw_sound("s1/s1_all.wav", "s1/s1_all.TextGrid")

## -----------------------------------------------------------------------------
#  create_subannotation(textgrid = "s1/s1_all.TextGrid",
#                       tier = 1, # this is a baseline tier
#                       n_of_annotations = 3) # how many empty annotations per unit?

## ---- echo=FALSE--------------------------------------------------------------
#  draw_sound("s1/s1_all.wav", "s1/s1_all.TextGrid")

## -----------------------------------------------------------------------------
#  annotate_textgrid(annotation = c("", "æ", "", "", "ı", "", "", "ɒ", ""),
#                    textgrid = "s1/s1_all.TextGrid",
#                    tier = 3,
#                    backup = FALSE)

## ---- echo=FALSE--------------------------------------------------------------
#  draw_sound("s1/s1_all.wav", "s1/s1_all.TextGrid")

## ---- include=FALSE-----------------------------------------------------------
#  file.copy("files/s1_all.TextGrid", to = "s1/s1_all.TextGrid", overwrite = TRUE)

## ---- echo=FALSE--------------------------------------------------------------
#  draw_sound("s1/s1_all.wav", "s1/s1_all.TextGrid")

## -----------------------------------------------------------------------------
#  dir.create("s1/s1_sounds")

## -----------------------------------------------------------------------------
#  extract_intervals(file_name = "s1/s1_all.wav",
#                    textgrid = "s1/s1_all.TextGrid",
#                    tier = 3,
#                    path = "s1/s1_sounds/",
#                    prefix = "s1_")

## -----------------------------------------------------------------------------
#  draw_sound(file_name = "s1/s1_sounds/2_s1_ı.wav")

## -----------------------------------------------------------------------------
#  draw_sound("s1/s1_all.wav",
#             "s1/s1_all.TextGrid",
#             from = 0.4,
#             to = 0.95)

## -----------------------------------------------------------------------------
#  draw_sound("s1/s1_all.wav",
#             "s1/s1_all.TextGrid",
#             zoom = c(0.4, 0.95))

## -----------------------------------------------------------------------------
#  draw_sound(file_name = "s1/s1_sounds/2_s1_ı.wav",
#             output_file = "s1/s1_tip",
#             title = "s1 tip")

## -----------------------------------------------------------------------------
#  draw_sound(sounds_from_folder = "s1/s1_sounds/",
#             pic_folder_name = "s1_pics")

## -----------------------------------------------------------------------------
#  raven_an <- data.frame(time_start = 450,
#                         time_end  = 520,
#                         freq_low = 3,
#                         freq_high = 4.5)
#  
#  draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"),
#             raven_annotation = raven_an)

## -----------------------------------------------------------------------------
#  raven_an <- data.frame(time_start = c(250, 450),
#                         time_end  = c(400, 520),
#                         freq_low = c(1, 3),
#                         freq_high = c(2, 4.5),
#                         colors = c("red", "blue"),
#                         content = c("a", "b"))
#  
#  draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"),
#             raven_annotation = raven_an)

## ---- eval=TRUE---------------------------------------------------------------
textgrid_to_df(system.file("extdata", "test.TextGrid", package = "phonfieldwork"))

## ---- eval=TRUE---------------------------------------------------------------
eaf_to_df(system.file("extdata", "test.eaf", package = "phonfieldwork"))

## ---- eval=TRUE---------------------------------------------------------------
exb_to_df(system.file("extdata", "test.exb", package = "phonfieldwork"))

## ---- eval=TRUE---------------------------------------------------------------
srt_to_df(system.file("extdata", "test.srt", package = "phonfieldwork"))

## ---- eval=TRUE---------------------------------------------------------------
audacity_to_df(system.file("extdata", "test_audacity.txt", package = "phonfieldwork"))

## -----------------------------------------------------------------------------
#  flextext_to_df("files/zilo_test.flextext")

## -----------------------------------------------------------------------------
#  create_glossed_document(flextext = "files/zilo_test.flextext",
#                          output_dir = ".") # you need to specify the path to the output folder

## ---- eval=TRUE---------------------------------------------------------------
draw_sound(file_name = system.file("extdata", "test.wav", package = "phonfieldwork"), 
           annotation = eaf_to_df(system.file("extdata", "test.eaf", package = "phonfieldwork")))

## -----------------------------------------------------------------------------
#  list.files("s1/s1_sounds/") # sounds
#  list.files("s1/s1_pics/") # pictures

## -----------------------------------------------------------------------------
#  df <- data.frame(word  = c("tap", "tip", "top"),
#                   sounds = c("æ", "ı", "ɒ"))
#  df

## -----------------------------------------------------------------------------
#  create_viewer(audio_dir = "s1/s1_sounds/",
#                picture_dir = "s1/s1_pics/",
#                table = df,
#                output_dir = "s1/",
#                output_file = "stimuli_viewer")

## -----------------------------------------------------------------------------
#  textgrid_to_df("s1/s1_all.TextGrid")

## -----------------------------------------------------------------------------
#  t1 <- tier_to_df("s1/s1_all.TextGrid", tier = 1)
#  t1
#  t3 <- tier_to_df("s1/s1_all.TextGrid", tier = 3)
#  t3

## -----------------------------------------------------------------------------
#  t3 <- t3[t3$content != "",]
#  t3

## -----------------------------------------------------------------------------
#  new_df <- data.frame(words = t1$content,
#                       sounds = t3$content)
#  new_df

## -----------------------------------------------------------------------------
#  create_viewer(audio_dir = "s1/s1_sounds/",
#                picture_dir = "s1/s1_pics/",
#                table = new_df,
#                output_dir = "s1/",
#                output_file = "stimuli_viewer")

## -----------------------------------------------------------------------------
#  new_df$glottocode <- c("russ1263", "poli1260", "czec1258")
#  create_viewer(audio_dir = "s1/s1_sounds/",
#                picture_dir = "s1/s1_pics/",
#                table = new_df,
#                output_dir = "s1/",
#                output_file = "stimuli_viewer2",
#                map = TRUE)

