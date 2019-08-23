#' Custom HTML template
#'
#' Loads additional style and template file
#'
#' @param toc should a table of contents be displayed?
#' @param ... additional arguments provided to \@code{html_document}
#' @export
#'
lesson_single = function(toc = TRUE, ...) {

  # locations of resource files in the package
  pkg_resource = function(...) {
    system.file(..., package = "rmd4edu")
  }

  template = pkg_resource("rmarkdown/templates/lesson_single/resources/template.html")
  css = pkg_resource("rmarkdown/templates/lesson_single/resources/styles.css")
  footer = pkg_resource("rmarkdown/templates/lesson_single/resources/footer.html")

  # call the base html_document function
  rmarkdown::html_document(
    toc = toc,
    toc_float = TRUE,
    fig_width = 6.5,
    fig_height = 4,
    theme = "flatly",
    highlight = "tango",
    code_folding = "show",
    code_download = TRUE,
    number_sections = FALSE,
    css = css,
    includes = rmarkdown::includes(after_body = footer),
    ...
  )
}
