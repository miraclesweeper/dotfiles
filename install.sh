#!/bin/sh

LOCAL_REPOSITORY_PATH=$HOME/Dotfiles
REMOTE_REPOSITORY_URL=https://github.com/miraclesweeper/dotfiles.git

abort() {
  echo $1
  exit 1
}

getManagedDotfiles() {
  result=()

  cd $LOCAL_REPOSITORY_PATH
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

if [ -d $LOCAL_REPOSITORY_PATH ]; then
  echo "$LOCAL_REPOSITORY_PATH already exists. Replace it? [y]es, [n]o:"

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
        rm -fr $LOCAL_REPOSITORY_PATH

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

git clone $REMOTE_REPOSITORY_URL $LOCAL_REPOSITORY_PATH
if [ ! -d $LOCAL_REPOSITORY_PATH ]; then
  abort "Could not download remote repository."
fi

files=($(getManagedDotfiles))
for file in ${files[@]}; do
  ln -fs $LOCAL_REPOSITORY_PATH/$file $HOME/$file
done

echo "Installation was successful."