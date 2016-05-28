#===============================================================================
# SCRIPTS
#===============================================================================

curlto(){
if [ ! -d "$2" ]; then
  mkdir "$2"
fi
cd "$2" && { curl -O "$1" ; cd -;}
local myfile=$(sed "s/.*\///" <<<  "$1")
local mypath="$2$myfile"
while shift && [ -n "$2" ]; do
  if [ ! -d $2 ]; then
    mkdir "$2"
  fi
  ln -h "$mypath" "$2$myfile"
done
}

curlone(){
if [ -d "$1" ]; then
  cd "$1"
else
  mkdir "$1"
  cd "$1"
fi
while shift && [ -n "$1" ]; do
  curl -O "$1"
done
cd -
}

if [ -e ~/.scripts ]; then; source ~/.scripts; fi

