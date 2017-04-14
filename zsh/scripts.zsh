#===============================================================================
# SCRIPTS
#===============================================================================

if [ -e ~/.localscripts ]; then; source ~/.localscripts; fi

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

pip-update()
{
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U
}

gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

getinode(){
 echo $(ls -li "$1" | grep -o -m 1 '[0-9][0-9]*' | head -1)
}

findlinks(){
local inode=$(getinode "$1")
find . -xdev -inum $inode
while shift && [ -n "$1" ]; do
  inode=$(getinode "$1")
  find . -xdev -inum $inode
done
}

dellinks(){
local inode=$(getinode "$1")
find . -xdev -inum $inode | xargs rm
while shift && [ -n "$1" ]; do
  inode=$(getinode "$1")
  find . -xdev -inum $inode | xargs rm
done
}
