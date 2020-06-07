#' Create boundaries in a texgrid tier
#'
#'
#' @author George Moroz <agricolamz@gmail.com>
#'
#' @param textgrid character with a filename or path to the TextGrid
#' @param tier value that could be either ordinal number of the tier either name of the tier
#' @param new_tier_name a name of a new created tier
#' @param n_of_annotations number of new annotations per annotation to create
#' @param each non-negative integer. Each new blank annotation is repeated every first, second or ... times
#' @param omit_blank logical. If TRUE (by dafault) it doesn't create subannotation for empy annotations.
#' @param overwrite logical. If TRUE (by dafault) it overwrites an existing tier.
#'
#' @return a string that contain TextGrid. If argument write is \code{TRUE}, then no output.
#'
#' @examples
#' create_subannotation(textgrid = example_textgrid, tier = 1, overwrite = FALSE)
#'
#' @export
#'

create_subannotation <- function(textgrid,
                                 tier = 1,
                                 new_tier_name = "",
                                 n_of_annotations = 4,
                                 each = 1,
                                 omit_blank = TRUE,
                                 overwrite = TRUE){

# read TextGrid -----------------------------------------------------------
  if(grepl("TextGrid", textgrid[2])){
    tg <- textgrid
  } else{
    tg <- readLines(normalizePath(textgrid))
  }

  df <- phonfieldwork::tier_to_df(tg, tier = tier)
  df

  if(omit_blank){
    df <- df[df$annotation != "",]
  }

  lapply(1:nrow(df), function(i){
    t <- seq(df$start[i], df$end[i], length.out = each*(n_of_annotations+1))
    data.frame(start = t[-length(t)],
               end = t[-1])
  }) ->
    l

  final <- Reduce(rbind, l)
  final <- cbind(id = 1:nrow(final), final, annotation = "")
  phonfieldwork::df_to_tier(final,
                            textgrid = textgrid,
                            tier_name = new_tier_name,
                            overwrite = overwrite)
}