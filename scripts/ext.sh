function ext {

  # Function to extract files

  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"; do
      if [ -f "$n" ]; then
        case "${n%,}" in
        *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
          tar xvf "$n"
          ;;
        *.lzma) unlzma ./"$n" ;;
        *.bz2) bunzip2 ./"$n" ;;
        *.cbr | *.rar) unrar x -ad ./"$n" ;;
        *.gz) gunzip ./"$n" ;;
        *.cbz | *.epub | *.zip) unzip ./"$n" ;;
        *.z) uncompress ./"$n" ;;
        *.7z | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
          7z x ./"$n"
          ;;
        *.xz) unxz ./"$n" ;;
        *.exe) cabextract ./"$n" ;;
        *.cpio) cpio -id <./"$n" ;;
        *.cba | *.ace) unace x ./"$n" ;;
        *)
          echo "extract: '$n' - unknown archive method"
          return 1
          ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}
