## Load packages
library(dplyr)
library(googledrive)
library(purrr)
library(stringr)
library(here)
options(googledrive_quiet = TRUE)

## Authenticate into googledrive service account
googledrive::drive_auth()

## Find Google Drive folder 'Centre Circle Data & Info'
data_folder <- drive_ls(path = "Centre Circle Data & Info")

## Filter for just the .csv files
data_csv <- data_folder %>% filter(str_detect(name, ".csv")) %>% arrange(name)

## download function
get_Drive_CPL_data <- function(g_id, data_name) {
  cat("... Trying to download", data_name, "...")

  ## Set folder for downloads
  data_path <- here::here("data/CanPL_data")  
  
  # Wrap drive_download function in safely()
  safe_drive_download <- purrr::safely(drive_download)
  
  ## Run download function for all data files
  dl_return <- safe_drive_download(file = as_id(g_id), path = paste0(data_path, "/", data_name), overwrite = TRUE)
  
  if (is.null(dl_return$result)) {
    cat("\nSomething went wrong!\n")
  } else {
    res <- dl_return$result
    cat("\nFile:", res$name, "download successful!", "\nPath:", res$local_path, "\n")
  }
}

## Download all files from Google Drive!
map2(data_csv$id, data_csv$name,
     ~ get_Drive_CPL_data(g_id = .x, data_name = .y))

cat("\nAll done!\n")