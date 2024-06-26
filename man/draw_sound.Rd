% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draw_sound.R
\name{draw_sound}
\alias{draw_sound}
\title{Draw Oscilogram, Spectrogram and annotation}
\usage{
draw_sound(
  file_name,
  annotation = NULL,
  from = NULL,
  to = NULL,
  zoom = NULL,
  text_size = 1,
  output_file = NULL,
  title = NULL,
  freq_scale = "kHz",
  frequency_range = c(0, 5),
  dynamic_range = 50,
  window_length = 5,
  window = "kaiser",
  windowparameter = -1,
  preemphasisf = 50,
  spectrum_info = TRUE,
  raven_annotation = NULL,
  formant_df = NULL,
  pitch = NULL,
  pitch_range = c(75, 350),
  intensity = NULL,
  output_width = 750,
  output_height = 500,
  output_units = "px",
  sounds_from_folder = NULL,
  textgrids_from_folder = NULL,
  pic_folder_name = "pics",
  title_as_filename = TRUE,
  prefix = NULL,
  suffix = NULL,
  autonumber = FALSE
)
}
\arguments{
\item{file_name}{a sound file}

\item{annotation}{a source for annotation files (path to TextGrid file or dataframe created from other linguistic types, e. g. via \code{textgrid_to_df()}, \code{eaf_to_df()} or other functions)}

\item{from}{Time in seconds at which to start extraction.}

\item{to}{Time in seconds at which to stop extraction.}

\item{zoom}{numeric vector of zoom window time (in seconds). It will draw
the whole oscilogram and part of the spectrogram.}

\item{text_size}{numeric, text size (default = 1).}

\item{output_file}{the name of the output file}

\item{title}{the title for the plot}

\item{freq_scale}{a string indicating the type of frequency scale.
Supported types are: "Hz" and "kHz".}

\item{frequency_range}{vector with the range of frequencies to be displayed
for the spectrogram up to a maximum of fs/2. By default this is set to 0-5
kHz.}

\item{dynamic_range}{values greater than this many dB below the maximum will
be displayed in the same color}

\item{window_length}{the desired analysis window length in milliseconds.}

\item{window}{A string indicating the type of window desired. Supported types
are: "rectangular", "hann", "hamming", "cosine", "bartlett", "gaussian", and
"kaiser".}

\item{windowparameter}{The parameter necessary to generate the window, if
appropriate. At the moment, the only windows that require parameters are the
Kaiser and Gaussian windows. By default, these are set to 2 for kaiser and
0.4 for gaussian windows.}

\item{preemphasisf}{Preemphasis of 6 dB per octave is added to frequencies
above the specified frequency. For no preemphasis, set to a frequency higher
than the sampling frequency.}

\item{spectrum_info}{logical. If \code{TRUE} then add information about
window method and params.}

\item{raven_annotation}{Raven (Center for Conservation Bioacoustics) style
annotations (boxes over spectrogram). The dataframe that contains
\code{time_start}, \code{time_end}, \code{freq_low} and \code{freq_high}
columns. Optional columns are \code{colors} and \code{content}.}

\item{formant_df}{dataframe with formants from \code{formant_to_df()} function}

\item{pitch}{path to the Praat `.Pitch` file or result of
\code{pitch_to_df()} function. This variable provide data for visualisation
of a pitch contour exported from Praat.}

\item{pitch_range}{vector with the range of frequencies to be displayed.
By default this is set to 75-350 Hz.}

\item{intensity}{path to the Praat `.Intensity` file or result of
\code{intensity_to_df()} function. This variable provide data for
visualisation of an intensity contour exported from Praat.}

\item{output_width}{the width of the device}

\item{output_height}{the height of the device}

\item{output_units}{the units in which height and width are given.
Can be "px" (pixels, the default), "in" (inches), "cm" or "mm".}

\item{sounds_from_folder}{path to a folder with multiple sound files.
If this argument is not \code{NULL}, then the function goes through all
files and creates picture for all of them.}

\item{textgrids_from_folder}{path to a folder with multiple .TextGrid files.
If this argument is not \code{NULL}, then the function goes through all files
and create picture for all of them.}

\item{pic_folder_name}{name for a folder, where all pictures will be stored
in case \code{sounds_from_folder} argument is not \code{NULL}}

\item{title_as_filename}{logical. If true adds filename title to each picture}

\item{prefix}{prefix for all file names for created pictures in case
\code{sounds_from_folder} argument is not \code{NULL}}

\item{suffix}{suffix for all file names for created pictures in case
\code{sounds_from_folder} argument is not \code{NULL}}

\item{autonumber}{if TRUE automatically add number of extracted sound to the
file_name. Prevents from creating a duplicated files and wrong sorting.}
}
\value{
Oscilogram and spectrogram plot (and possibly TextGrid annotation).
}
\description{
Create oscilogram and spectrogram plot.
}
\examples{
\donttest{
draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"))

draw_sound(
  system.file("extdata", "test.wav", package = "phonfieldwork"),
  system.file("extdata", "test.TextGrid",
    package = "phonfieldwork"
  )
)

draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"),
  system.file("extdata", "test.TextGrid", package = "phonfieldwork"),
  pitch = system.file("extdata", "test.Pitch",
    package = "phonfieldwork"
  ),
  pitch_range = c(50, 200)
)
draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"),
  system.file("extdata", "test.TextGrid", package = "phonfieldwork"),
  pitch = system.file("extdata", "test.Pitch",
    package = "phonfieldwork"
  ),
  pitch_range = c(50, 200),
  intensity = intensity_to_df(system.file("extdata", "test.Intensity",
    package = "phonfieldwork"
  ))
)
draw_sound(system.file("extdata", "test.wav", package = "phonfieldwork"),
  formant_df = formant_to_df(system.file("extdata", "e.Formant",
    package = "phonfieldwork"
  ))
)
}
}
\author{
George Moroz <agricolamz@gmail.com>
}
