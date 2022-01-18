function giit(){

  # You can skip the repository question if you are already in the correct path
  # Feel free to customize it for your use

clear
  
  br=$(git rev-parse --abbrev-ref HEAD) && dir=$(pwd) 
  printf "[current: "${dir}" "on" "${br}"] \n"
  printf "Repository path: " && read -r repository
  printf "Pull changes before commiting (y/n): " && read -r pull
  printf "Commit message: " && read -r message
  printf "Push changes (y/n): " && read -r push

  if [ -z "$repository" ] ;then ;cd . ;else ;cd $repository ;fi

clear

  if [[ "$pull" != "${pull#[Yyes]}" && "$push" != "${push#[Yyes]}" ]] ;then 
    git add . && git pull && git commit -m "$message" && git push
 
  elif [[ "$pull" != "${pull#[Yyes]}" && "$push" != "${push#[Nno]}" ]] ;then 
    git add . && git pull && git commit -m "$message"
  
  elif [[ "$pull" != "${pull#[Nno]}" && "$push" != "${push#[Nno]}" ]] ;then
    git add . && git commit -m "$message"
  
  elif [[ "$pull" != "${pull#[Nno]}" && "$push" != "${push#[Yyes]}" ]] ;then
    # This can't be done, but it's here so the user can see the error.
    git add . && git commit -m "$message" && git push 
  fi

}