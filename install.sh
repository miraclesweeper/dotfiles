#!/bin/sh

LOCAL_REPOSITORY=$HOME/Dotfiles

abort() {
  echo $1
  exit 1
}

getManagedDotfiles() {
  result=()

  cd $LOCAL_REPOSITORY
  for file in .??*; do
    if [ -f $file ]; then
      case $file in
        .gitignore)
          ;;
        *)
          result+=($file)
          ;;
      esac
    fi
  done

  echo ${result[@]}
}

if [ -d $LOCAL_REPOSITORY ]; then
  echo "$LOCAL_REPOSITORY already exists. Replace it? [y]es, [n]o:"

  while true
  do
    read response
    case $response in
      y)
        files=($(getManagedDotfiles))
        for file in ${files[@]}; do
          if [ -f $HOME/$file ]; then
            rm $HOME/$file
          fi
        done

        cd
        rm -fr $LOCAL_REPOSITORY

        break
        ;;
      n)
        abort "Installation has been canceled."
        ;;
      *)
        echo "Invalid response."
        ;;
    esac
  done
fi

git clone https://github.com/miraclesweeper/dotfiles.git $LOCAL_REPOSITORY
if [ ! -d $LOCAL_REPOSITORY ]; then
  abort "Could not download remote repository."
fi

files=($(getManagedDotfiles))
for file in ${files[@]}; do
  ln -fs $LOCAL_REPOSITORY/$file $HOME/$file
done

echo "Installation was successful."