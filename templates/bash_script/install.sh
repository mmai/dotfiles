DIR=$( dirname $0 )

echo -n "Nom du script (sans extension): "
read NAME

cp $DIR/script_template.sh  ./$NAME.sh
