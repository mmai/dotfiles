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
      echo "[ postgresql ] Service Initialization"
      pg_ctl -w -D $PGDATA  init
      sed -i 's/#port = 5432/port = ${cfg.port}/' $PGDATA/postgresql.conf
    fi

    if [ -e $PGDATA ]; then

      if pg_isready -h $DB_HOST -p ${cfg.port} >/dev/null ; then
         echo "[ postgresql ] Service already started on port ${cfg.port}"
      else
         echo "[ postgresql ] Starting service"
         pg_ctl -w -D $PGDATA -l $PSQL_LOG -o "-k $PGHOST" start

         if [[ -z `psql -h $DB_HOST -p ${cfg.port} -Atqc '\list ${cfg.name}' postgres` ]]; then
           echo "[ postgresql ] Database creation"
           createdb -h $DB_HOST -p ${cfg.port} ${cfg.name}

           echo "CREATE USER ${cfg.user} WITH ENCRYPTED PASSWORD '${cfg.password}'; GRANT ALL PRIVILEGES ON DATABASE ${cfg.name} TO ${cfg.user};" | psql -h $DB_HOST -p ${cfg.port} postgres
        fi
      fi

    fi
  '';

  shellStopService = ''
     pg_ctl -D $PGDATA -o "-k "$PGHOST stop
  '';

  shellDump = ''
    mkdir -p $ROOT_DUMP/psql
    pg_dumpall -h 127.0.0.1 -p ${cfg.port} -c -f $ROOT_DUMP/psql/dumpall.sql 
  '';

  shellRestore = ''
    psql -h 127.0.0.1 -p ${cfg.port} -f $ROOT_DUMP/psql/dumpall.sql postgres
    '';
}
