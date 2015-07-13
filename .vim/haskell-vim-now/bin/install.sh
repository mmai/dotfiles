#!/usr/bin/env bash

endpath="$HOME/.vim/haskell-vim-now"

echo "Updating cabal package list"
cabal update

function create_stackage_sandbox {
  echo "Initializing stackage sandbox in $dir"
  dir=$1
  cd $dir
  cabal sandbox init
  curl -L https://www.stackage.org/lts/cabal.config > cabal.config
  cd -
}

function build_shared_binary {
  dir=$1
  pkg=$2
  constraint=$3

  if [ -e $endpath/bin/$pkg ]
  then
    echo "$pkg is already installed, skipping build"
    return
  fi

  echo "Building $pkg (in $dir)"
  cd $dir
  cabal install -j --reorder-goals --disable-documentation --datadir=$endpath/data --force-reinstalls "${constraint:-$pkg}"

  echo "Saving $pkg binaries"
  mv .cabal-sandbox/bin/* $endpath/bin
  cd -
}

sb=`mktemp -d ${TMPDIR:-/tmp}/build-XXXX`
create_stackage_sandbox $sb

for i in ghc-mod hasktags codex hscope pointfree pointful hoogle stylish-haskell; do
  build_shared_binary $sb $i
done

rm -fr $sb

echo "Building Hoogle database..."
$endpath/bin/hoogle data

echo "Setting git to use fully-pathed vim for messages..."
git config --global core.editor $(which vim)

echo "Configuring codex to search in sandboxes..."
cat > $HOME/.codex <<EOF
hackagePath: .cabal-sandbox/packages/
tagsFileHeader: false
tagsFileSorted: false
tagsCmd: hasktags --extendedctag --ignore-close-implementation --ctags --tags-absolute --output='\$TAGS' '\$SOURCES'
EOF
