# from distill

have_rstudio_project_api <- function() {
  rstudioapi::isAvailable("1.1.287")
}
