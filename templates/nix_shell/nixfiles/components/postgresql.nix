{ pkgs, cfg }:

{
  buildInputs = with pkgs; [ postgresql ];

  shellInit = ''
    PSQL_PATH=$ROOT_VAR/psql
    PSQL_DATA=$PSQL_PATH/data
    PSQL_LOG=$PSQL_PATH/psql.log
    PGHOST=$PSQL_PATH # path where psql lock file is created
    '';

  shellStartService = ''
    DB_HOST='127.0.0.1'
    DB_PORT='${cfg.port}'
    DB_USER='${cfg.user}'
    DB_PASS='${cfg.password}'
    DB_NAME='${cfg.name}'
     if [ $(whoami) != $DB_USER ]; then
        echo "/!\ Veuillez utiliser l'utilisateur $(whoami) pour vous connecter"
        echo "DATABASE_URL=pgsql://"$(whoami)":"$DB_PASS"@127.0.0.1:"$DB_PORT"/"$DB_NAME
     else
       if [ ! -e $PSQL_DATA ]; then
         echo ">>  Creation de la base de donnee"
         pg_ctl -D $PSQL_DATA  init
       fi

       pg_ctl -D $PSQL_DATA -l $PSQL_LOG -o "-k "$PGHOST start
     fi
  '';

  shellStopService = ''
     pg_ctl -D $PSQL_DATA -o "-k "$PGHOST stop
  '';
}
