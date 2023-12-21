# Here we can add some custom package installations

download_repbox_pkg_zip_from_github = function(dest_dir, user="repboxr", pkgs,  branch="main") {
  urls = paste0("http://github.com/",user,"/",pkgs,"/archive/",branch,".zip")
  files = paste0(dest_dir, "/",pkgs,".zip")
  if (!dir.exists(dest_dir)) stop("Destination directory does not exist.")
  i = 1
  for (i in seq_along(urls)) {
    download.file(urls[i],files[i] )
  }
}

unzip_pkgs_sources = function(zip_dir, dest_dir=zip_dir) {
  files = list.files(zip_dir, glob2rx("*.zip"),ignore.case = TRUE,full.names = TRUE)
  for (file in files) {
    cat("\nUnzip ", file, " to ", dest_dir)
    unzip(file,exdir = dest_dir)
  }
}

install_pkg_sources = function(parent_dir, pkgs) {
  library(remotes)
  for (pkg in pkgs) {
    dir = file.path(parent_dir, pkg)
    if (!dir.exists(dir)) {
      dir = paste0(dir,"-main")
    }
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

cat("\n\nDirectories in ", pkg_dir,"\n\n")
print(list.dirs(pkg_dir,recursive = FALSE,full.names = FALSE))

cat("\n\nBuild and install packages...\n\n")
install_pkg_sources(pkg_dir, pkgs)