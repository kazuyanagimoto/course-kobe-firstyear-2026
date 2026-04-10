tar_data <- tar_plan(
  tar_file(
    pop_marriage_raw,
    download_estat_csv(
      path = here_rel("data", "raw", "pop_marriage.csv"),
      appid = Sys.getenv("ESTAT_API_KEY"),
      stats_data_id = "0003410382",
      cdTab = "1060", # Number of people
    )
  )
)

download_estat_csv <- function(path, appid, stats_data_id, ...) {
  dat <- estatapi::estat_getStatsData(
    appId = appid,
    statsDataId = stats_data_id,
    ...
  )
  fs::dir_create(fs::path_dir(path))
  readr::write_csv(dat, path)
  path
}
