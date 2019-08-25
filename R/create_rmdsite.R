#' Create an `rstudio4edu` website with R Markdown
#'
#' Create a basic skeleton for an `rstudio4edu` website. Use the `create_rmdsite()`
#' function for a website, or alternately you may use the project wizard in the
#' RStudio IDE to make a new website within an R project. If you want to learn
#' how to make this R Markdown website from scratch, please see:
#' https://rstudio4edu.github.io/rstudio4edu-book/intro-rmd.html
#'
#' @param dir Directory for website
#' @param title Title of website
#' @param gh_pages Configure the site for publishing using [GitHub
#'   Pages](https://pages.github.com/)
#' @param edit Open site index file or welcome post in an editor.
#'
#' @note The `dir` and `title` parameters are required (they will be prompted for
#'   interatively if they are not specified).
#'
#' @examples
#' \dontrun{
#' library(rmd4edu)
#' create_rmdsite("mysite", "My Site")
#' }
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

  # prompt for arguments if we need to
  if (missing(dir)) {
    if (interactive())
      dir <- readline(sprintf("Enter directory name for %s: ", type))
    else
      stop("dir argument must be specified", call. = FALSE)
  }
  if (missing(title)) {
    if (interactive())
      title <- readline(sprintf("Enter a title for the %s: ", type))
    else
      stop("title argument must be specified", call. = FALSE)
  }

  # ensure dir exists
  message("Creating Rmd website directory ", dir)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)

  # copy 'rmdsite' folder to dir
  file.copy(
    list.files(rmd4edu_file('rstudio', 'templates', 'project', 'rmdsite'), full.names = TRUE),
    dir, recursive = TRUE, overwrite = TRUE
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
