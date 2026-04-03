tar_typst <- tar_plan(
  tar_files(typst_files, {
    list.files(
      here_rel("static", "typst"),
      pattern = "\\.typ$",
      full.names = TRUE
    )
  }),
  tar_target(
    typst_svg,
    typst_to_svg(typst_files),
    pattern = map(typst_files),
    format = "file"
  )
)

typst_to_svg <- function(input) {
  name <- fs::path_ext_remove(basename(input))
  output <- here_rel("static", "img", "01-quarto", paste0(name, ".svg"))
  if (!dir.exists(dirname(output))) {
    dir.create(dirname(output), recursive = TRUE)
  }
  system2(
    "quarto",
    c(
      "typst",
      "compile",
      "--format",
      "svg",
      shQuote(input),
      shQuote(output)
    )
  )
  output
}
