#' Create an `rstudio4edu` online book with `bookdown`
#'
#' Create a basic skeleton for an `rstudio4edu` book, using the
#' `bookdown::gitbook()` output format. Use the `create_book()`
#' function, or alternately you may use the project wizard in the
#' RStudio IDE to make a new bookdown site within an R project.
#' If you want to learn how to make this bookdown site from scratch,
#' please see:
#' https://rstudio4edu.github.io/rstudio4edu-book/intro-bookdown.html
#'
#' @param dir Directory for book
#' @param title Title of book
#' @param gh_pages Configure the book website for publishing using [GitHub
#'   Pages](https://pages.github.com/)
#' @param edit Open site index file or welcome post in an editor.
#'
#' @note The `dir` and `title` parameters are required (they will be prompted for
#'   interatively if they are not specified).
#'
#' @examples
#' \dontrun{
#' library(rmd4edu)
#' create_book("mybook", "My Book")
#' }
#' @rdname create_book
#' @export
create_book <- function(dir, title, gh_pages = FALSE, edit = interactive()) {
  do_create_book(dir, title, gh_pages, edit, "book")
  invisible(NULL)
}

#' this is the wrapper for the exported function that is used by
#' our RStudio project template
new_project_create_book <- function(dir, ...) {
  params <- list(...)
  create_book(dir, params$title, params$gh_pages, edit = FALSE)
}

do_create_book <- function(dir, title, gh_pages, edit, type) {

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
  message("Creating bookdown website directory", dir)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)

  # copy 'book' folder to dir
  file.copy(
    list.files(rmd4edu_file('rstudio', 'templates', 'project', 'book'), full.names = TRUE),
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

  # add book_filename to _bookdown.yml and default to the base path name
  f = file.path(dir, '_bookdown.yml')
  x = xfun::read_utf8(f)
  xfun::write_utf8(c(sprintf('book_filename: "%s"', basename(dir)), x), f)

  TRUE
}
