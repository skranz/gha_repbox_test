# Here we can add some custom package installations

download_repbox_pkg_zip_from_github = function(dest_dir, user="repboxr", pkgs,  branch="main") {
  restore.point("download_repbox_pkg_zip_from_github")
  urls = paste0("http://github.com/",user,"/",pkgs,"/archive/",branch,".zip")
  files = paste0(dest_dir, "/",pkgs,".zip")
  if (!dir.exists(dest_dir)) stop("Destination directory does not exist.")
  i = 1
  for (i in seq_along(urls)) {
    download.file(urls[i],files[i] )
  }
}

unzip_pkgs_sources = function(zip_dir, dest_dir=zip_dir) {
  restore.point("unzip_pkgs_sources")
  files = list.files(zip_dir, glob2rx("*.zip"),ignore.case = TRUE,full.names = TRUE)
  for (file in files) {
    unzip(file,exdir = zip_dir)
  }
}

install_pkg_sources = function(parent_dir) {
  library(remotes)
  restore.point("install_pkgs_sources")
  dirs = list.dirs(parent_dir,full.names = TRUE,recursive = FALSE)
  for (dir in dirs) {
    remotes::install_local(dir, upgrade="never", force=TRUE)
  }  
}

pkg_dir = "/root/pkgs"
dir.create(pkg_dir)
pkgs = c("GithubActions","sourcemodify","pkgFunIndex","repboxUtils","repboxCodeText","repboxRun","repboxGithub","repboxArt","repboxR","repboxHtml","repboxDB","repboxRfun","repboxEvaluate","repboxReg","repboxMap","repboxStata","ExtractSciTab","repboxDeploy","repboxverse")

cat("\n\nDownload repbox packages as ZIP from Github...\n\n")
download_repbox_pkg_zip_from_github(pkg_dir, user="repboxr", pkgs = pkgs)
cat("\n\nExtract packages ZIP...\n\n")
unzip_pkgs_sources(pkg_dir)
cat("\n\nBuild and install packages...\n\n")
install_pkg_sources(pkg_dir)