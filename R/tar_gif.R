tar_gif <- tar_plan(
  tar_files(mov_files, {
    list.files(
      here_rel("static", "mov"),
      pattern = "\\.mov$",
      full.names = TRUE,
      recursive = TRUE
    )
  }),
  tar_target(
    gif,
    mov_to_gif(mov_files),
    pattern = map(mov_files),
    format = "file"
  )
)

mov_to_gif <- function(input) {
  name <- fs::path_ext_remove(basename(input))
  output <- here_rel("static", "img", paste0(name, ".gif"))
  if (!dir.exists(dirname(output))) {
    dir.create(dirname(output), recursive = TRUE)
  }
  palette <- tempfile(fileext = ".png")
  filters <- "fps=15,scale=1200:-1:flags=lanczos"
  system(
    paste(
      "ffmpeg -i",
      shQuote(input),
      "-vf",
      shQuote(paste0(filters, ",palettegen=stats_mode=diff")),
      "-y",
      shQuote(palette)
    )
  )
  system(
    paste(
      "ffmpeg -i",
      shQuote(input),
      "-i",
      shQuote(palette),
      "-lavfi",
      shQuote(paste0(
        filters,
        " [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=3"
      )),
      "-loop 0 -y",
      shQuote(output)
    )
  )
  unlink(palette)
  output
}
