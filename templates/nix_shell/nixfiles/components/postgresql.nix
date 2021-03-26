{ pkgs, cfg }:

{
  buildInputs = with pkgs; [ postgresql ];

  shellInit = ''
    PSQL_PATH=$ROOT_VAR/psql
    PSQL_LOG=$PSQL_PATH/psql.log
    PGDATA=$PSQL_PATH/data
    PGHOST=$PSQL_PATH # path where psql lock file is created
    '';

  shellStartService = ''
    DB_HOST='127.0.0.1'
    DB_USER='${cfg.user}'
    DB_PORT='${cfg.port}'
    DB_PASS='${cfg.password}'
    DB_NAME='${cfg.name}'

    if [ ! -e $PGDATA ]; then
      echo "[ postgresql ] Initialisation du service"
      pg_ctl -w -D $PGDATA  init
      sed -i 's/#port = 5432/port = ${cfg.port}/' $PGDATA/postgresql.conf
    fi

    if [ -e $PGDATA ]; then
       echo "[ postgresql ] Demarrage du service"
       pg_ctl -w -D $PGDATA -l $PSQL_LOG -o "-k $PGHOST" start

       if [[ -z `psql -h $DB_HOST -p ${cfg.port} -Atqc '\list ${cfg.name}' postgres` ]]; then
         echo "[ postgresql ] Creation de la base de donnnee"
         createdb -h $DB_HOST -p ${cfg.port} ${cfg.name}

         echo "CREATE USER ${cfg.user} WITH ENCRYPTED PASSWORD '${cfg.password}'; GRANT ALL PRIVILEGES ON DATABASE ${cfg.name} TO ${cfg.user};" | psql -h $DB_HOST -p ${cfg.port} postgres
      fi
    fi
  '';

  shellStopService = ''
     pg_ctl -D $PGDATA -o "-k "$PGHOST stop
  '';
}