#' Create a Distill website
#'
#' Create a basic skeleton for a Distill website or blog. Use the `create_website()`
#' function for a website and the `create_blog()` function for a blog.
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
#' this is the wrapper for the exported function that is used by
#' our RStudio project template
new_project_create_website <- function(dir, ...) {
  params <- list(...)
  distill::create_website(dir, params$title, params$gh_pages, edit = FALSE)
}


#' this is the wrapper for the exported function that is used by
#' our RStudio project template
new_project_create_blog <- function(dir, ...) {
  params <- list(...)
  distill::create_blog(dir, params$title, params$gh_pages, edit = FALSE)
}
