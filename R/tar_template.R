tar_template <- tar_plan(
  tar_files(
    template_report_files,
    list_template_files("template-report")
  ),
  tar_files(
    template_slides_files,
    list_template_files("template-slides")
  ),
  tar_target(
    template_report_zip,
    zip_template("template-report", template_report_files),
    format = "file"
  ),
  tar_target(
    template_slides_zip,
    zip_template("template-slides", template_slides_files),
    format = "file"
  )
)

# Generated outputs and caches that must never end up in a student download.
template_exclude_re <- paste0(
  "(^|/)\\.quarto(/|$)|",
  "(^|/)_freeze(/|$)|",
  "_files/|",
  "\\.pdf$|",
  "(^|/)\\.DS_Store$"
)

# Source files tracked as the zip's inputs, so the archive is rebuilt only when
# the template contents actually change.
list_template_files <- function(name) {
  root <- here_rel("template", name)
  files <- list.files(
    root,
    recursive = TRUE,
    full.names = TRUE,
    all.files = TRUE,
    no.. = TRUE
  )
  files[!grepl(template_exclude_re, files)]
}

# Bundle a template directory into static/download/<name>.zip. `files` is the
# tracked input (see list_template_files); zipping with -r keeps the empty
# data/ and img/ scaffolding directories while -x drops generated artifacts.
zip_template <- function(name, files) {
  force(files)
  out <- here_rel("static", "download", paste0(name, ".zip"))
  fs::dir_create(fs::path_dir(out))
  if (fs::file_exists(out)) {
    fs::file_delete(out)
  }
  out_abs <- fs::path_abs(out)
  withr::with_dir(here_rel("template"), {
    system2(
      "zip",
      c(
        "-rqX",
        shQuote(out_abs),
        name,
        "-x",
        shQuote(paste0(name, "/.quarto/*")),
        shQuote(paste0(name, "/_freeze/*")),
        shQuote(paste0(name, "/*_files/*")),
        shQuote(paste0(name, "/*.pdf")),
        shQuote("*.DS_Store")
      )
    )
  })
  out
}
