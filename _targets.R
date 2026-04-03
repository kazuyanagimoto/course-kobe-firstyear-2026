library(targets)
library(tarchetypes)

# Utility functions ------------------------------------------------------------
here_rel <- function(...) {
  fs::path_rel(here::here(...))
}


# Main pipeline ----------------------------------------------------------------
tar_source()
tar_plan(
  #---- Image ----
  tar_gif,
  tar_typst,
  #---- Website ----
  tar_file(
    static,
    {
      gif
      typst_svg
      list.files(
        here_rel("static"),
        recursive = TRUE,
        full.names = TRUE
      )
    }
  ),
  tar_file(
    website,
    {
      static
      quarto::quarto_render(here_rel("."))
      here_rel("_book", "index.html")
    }
  )
)
