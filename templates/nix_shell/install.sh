DIR=$( dirname $0 )

echo -n "Nom du projet : "
read NAME

cat $DIR/flake.nix | sed 's/MyProject/'$NAME'/' > flake.nix
cp -R $DIR/nixfiles  .

cp $DIR/envrc_tpl  ./.envrc

cat $DIR/Makefile >> ./Makefile

git add flake.nix
git add nixfiles
