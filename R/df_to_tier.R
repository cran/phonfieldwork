#' Dataframe to TextGrid's tier
#'
#' Convert a dataframe to a Praat TextGrid.
#'
#' @author George Moroz <agricolamz@gmail.com>
#'
#' @param df an R dataframe object that contains columns named "content",
#' "time_start" and "time_end"
#' @param textgrid a character with a filename or path to the TextGrid
#' @param tier_name a vector that contain a name for a created tier
#' @param overwrite a logic argument, if \code{TRUE} overwrites the existing
#' TextGrid file
#' @return If \code{overwrite} is \code{FALSE}, then the function returns a
#' vector of strings with a TextGrid. If \code{overwrite} is \code{TRUE}, then
#' no output.
#' @examples
#' time_start <- c(0.00000000, 0.01246583, 0.24781914, 0.39552363, 0.51157715)
#' time_end <- c(0.01246583, 0.24781914, 0.39552363, 0.51157715, 0.65267574)
#' content <- c("", "T", "E", "S", "T")
#' df_to_tier(data.frame(id = 1:5, time_start, time_end, content),
#'   system.file("extdata", "test.TextGrid",
#'     package = "phonfieldwork"
#'   ),
#'   overwrite = FALSE
#' )
#' @export
#'
#'

df_to_tier <- function(df, textgrid, tier_name = "", overwrite = TRUE) {
  if (!("time_start" %in% names(df)) |
      !("time_end" %in% names(df)) |
      !("content" %in% names(df))) {
    stop(paste0(
      'df columns should have the folowing names: "content"',
      '"time_start" and "time_end"'
    ))
  }

  df <- df[which(names(df) %in% c("time_start", "time_end", "content"))]

  tg <- read_textgrid(textgrid)

  n_tiers <- as.numeric(gsub("\\D", "", tg[7]))
  tg[7] <- paste0("size = ", n_tiers + 1, " ")
  textgrid_duration <- gsub("[a-z\\=\\s]", "", tg[5]) |> as.double()

  if (!(FALSE %in% (df$time_start == df$time_end))) {
    df <- df[, -which(names(df) %in% "time_end")]
  }

  if (TRUE %in% (df$time_end[-nrow(df)] != df$time_start[-1])){
    wrong_time_end <- which(df$time_end[-nrow(df)] != df$time_start[-1])
    silence <- lapply(rev(wrong_time_end), function(i){
      df <<- rbind(df[c(1:i),],
                   data.frame(time_start = df$time_end[i],
                              time_end = df$time_start[i+1],
                              content = ""),
                   df[-c(1:i),])
    })
  }

  if("time_end" %in% names(df)){
    if(df$time_end[nrow(df)] != textgrid_duration){
      df <- rbind(df,
                  data.frame(time_start = df$time_end[nrow(df)],
                             time_end = textgrid_duration,
                             content = ""))
    }
  } else {
    if(df$time_start[nrow(df)] != textgrid_duration){
      df <- rbind(df,
                  data.frame(time_start = df$time_start[nrow(df)],
                             content = ""))
    }
  }

  tier_class <- ifelse("time_end" %in% names(df),
                       '        class = "IntervalTier" ',
                       '        class = "TextTier" '
  )

  tier_type <- ifelse("time_end" %in% names(df),
                      paste0("        intervals"),
                      paste0("        points")
  )


  if ("time_end" %in% names(df)) {
    all_annotations <- lapply(seq_along(df$time_start), function(i) {
      c(
        paste0(tier_type, " [", i, "]:"),
        paste0("            xmin = ", df$time_start[i], " "),
        paste0("            xmax = ", df$time_end[i], " "),
        paste0('            text = "', df$content[i], '" ')
      )
    })
  } else {
    all_annotations <- lapply(seq_along(df$time_start), function(i) {
      c(
        paste0(tier_type, "[", i, "]:"),
        paste0("            number = ", df$time_start[i], " "),
        paste0('            mark = "', df$content[i], '" ')
      )
    })
  }

  add_tier <- c(
    paste0("    item [", n_tiers + 1, "]:"),
    tier_class,
    paste0('        name = "', tier_name, '" '),
    paste0("        ", tg[4]),
    paste0("        ", tg[5]),
    paste0(tier_type, ": size = ", nrow(df), " "),
    unlist(all_annotations)
  )
  if (overwrite) {
    writeLines(append(tg, add_tier), textgrid)
  } else {
    append(tg, add_tier)
  }
}
