#' Create a glossed document
#'
#' Creates a file with glossed example (export from .flextext or other formats)
#'
#' @author George Moroz <agricolamz@gmail.com>
#'
#' @param flextext path to a .flextext file or a dataframe with the following
#' columns: \code{p_id}, \code{s_id}, \code{w_id}, \code{txt}, \code{cf},
#' \code{hn}, \code{gls}, \code{msa}, \code{morph}, \code{word}, \code{phrase},
#' \code{paragraph}, \code{free_trans}, \code{text}, \code{text_title}
#' @param rows vector of row names from the flextext that should appear in the
#' final document. Possible values are: "cf", "hn", "gls", "msa". "gls" is
#' default.
#' @param output_file the name of the result \code{.html} file (by default
#' \code{glossed_document}).
#' @param output_dir the output directory for the rendered file
#' @param output_format The option can be "html" or "docx"
#' @param example_pkg vector with name of the LaTeX package for glossing
#' (possible values: \code{"gb4e"}, \code{"langsci"}, \code{"expex"},
#' \code{"philex"})
#'
#' @return If \code{render} is \code{FALSE}, the function returns a path to
#' the temporary file with .csv file. If \code{render} is \code{TRUE}, there is
#' no output in a function.
#'
#' @export
#' @importFrom rmarkdown render
#' @importFrom utils installed.packages
#' @importFrom utils write.csv

create_glossed_document <- function(flextext = NULL,
                                    rows = c("gls"),
                                    output_dir,
                                    output_file = "glossed_document",
                                    output_format = "html",
                                    example_pkg = NULL) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop(paste0(
      "For this function you need to install dplyr package with a",
      ' command install.packages("dplyr").'
    ))
  }
  if (!requireNamespace("tidyr", quietly = TRUE)) {
    stop(paste0(
      "For this function you need to install tidyr package with a",
      ' command install.packages("tidyr").'
    ))
  }

  match.arg(output_format, c("docx", "html"))

  if (!inherits(flextext, "data.frame")) {
    flextext <- flextext_to_df(flextext)
  }
  tmp1 <- tempfile(fileext = ".csv")
  on.exit(file.remove(tmp1))
  utils::write.csv(flextext, tmp1, row.names = FALSE, na = "")
  output_format2 <- ifelse(output_format == "docx", "word", output_format)
  rmarkdown::render(
    system.file("rmarkdown", "templates", "glossed_document", "skeleton",
      "skeleton.Rmd",
      package = "phonfieldwork"
    ),
    params = list(data = tmp1, rows = rows, example_pkg = example_pkg),
    output_dir = output_dir,
    output_format = paste0(output_format2, "_document"),
    quiet = TRUE,
    output_file = output_file
  )
  message(paste0(
    "Output created: ", normalizePath(output_dir), "/",
    output_file, ".", output_format
  ))
}
