#!/bin/sh

LOCAL_REPOSITORY=$HOME/Dotfiles
REMOTE_REPOSITORY=https://github.com/miraclesweeper/dotfiles.git

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
  echo "$LOCAL_REPOSITORY already exists. Do you want to replace it?"

  while true
  do
    read response
    case $response in
      yes)
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
      *)
        abort "Installation canceled."
        ;;
    esac
  done
fi

git clone $REMOTE_REPOSITORY $LOCAL_REPOSITORY
if [ ! -d $LOCAL_REPOSITORY ]; then
  abort "Couldn't download remote repository."
fi

files=($(getManagedDotfiles))
for file in ${files[@]}; do
  ln -fs $LOCAL_REPOSITORY/$file $HOME/$file
done

echo "Installation successful."