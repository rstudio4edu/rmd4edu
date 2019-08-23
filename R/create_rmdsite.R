#' from rmarkdown
#' and the distill packages
#'
#' @rdname create_rmdsite
#' @export
create_rmdsite <- function(dir, title, gh_pages = FALSE, edit = interactive()) {
  do_create_rmdsite(dir, title, gh_pages, edit, "website")
  invisible(NULL)
}

#' this is the wrapper for the exported function that is used by
#' our RStudio project template
new_project_create_rmdsite <- function(dir, ...) {
  params <- list(...)
  create_rmdsite(dir, params$title, params$gh_pages, edit = FALSE)
}

do_create_rmdsite <- function(dir, title, gh_pages, edit, type) {

  # ensure dir exists
  message("Creating Rmd website directory ", dir)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)

  # copy 'rmdsite' folder to dir
  file.copy(
    list.files(rmd4edu_file('rstudio', 'templates', 'project', 'rmdsite'), full.names = TRUE),
    dir, overwrite = TRUE
  )

  # if this is for gh-pages then create .nojekyll
  if (gh_pages) {
    nojekyll <- file.path(dir, ".nojekyll")
    message("Creating ", nojekyll, " for gh-pages")
    file.create(nojekyll)
  }

  # if we are running in RStudio then create Rproj
  if (have_rstudio_project_api())
    rstudioapi::initializeProject(dir)
}
