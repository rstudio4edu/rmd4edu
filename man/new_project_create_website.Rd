% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_distill.R
\name{new_project_create_website}
\alias{new_project_create_website}
\title{Create a Distill website}
\usage{
new_project_create_website(dir, ...)
}
\arguments{
\item{dir}{Directory for website}

\item{title}{Title of website}

\item{gh_pages}{Configure the site for publishing using [GitHub
Pages](https://pages.github.com/)}

\item{edit}{Open site index file or welcome post in an editor.}
}
\description{
Create a basic skeleton for a Distill website or blog. Use the `create_website()`
function for a website and the `create_blog()` function for a blog.
}
\note{
The `dir` and `title` parameters are required (they will be prompted for
  interatively if they are not specified).

this is the wrapper for the exported function that is used by
our RStudio project template
}
