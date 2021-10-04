# note : the db user name is the user who started the nix shell initially
{ pkgs, cfg }:

let createDb = dbname: ''
  echo "CREATE DATABASE IF NOT EXISTS ${dbname}" | mysql -P${cfg.port} -p${cfg.password} -h127.0.0.1
  '';
    createAllDatabases = builtins.foldl' (a: b: a + b ) "" (map createDb cfg.databases);
in
{
  buildInputs = (with pkgs; [ mysql ]);

  shellInit = ''
    MYSQL_PATH=$ROOT_VAR/mysql
    '';

  shellStartService = ''
    if [ ! -e $MYSQL_PATH/data/mysql ]; then
      echo "[ mysql ] Service initialization"
      ${pkgs.mysql}/bin/mysql_install_db --basedir=${pkgs.mysql} --datadir=$MYSQL_PATH/data && touch $MYSQL_PATH/data/initRequired
      mkdir -p $MYSQL_PATH/tmp
    fi

    if [ -e $MYSQL_PATH/data/mysql ]; then

      if test -f $MYSQL_PATH/data/mysqld.pid && ps -p $(cat $MYSQL_PATH/data/mysqld.pid) > /dev/null; then
         echo "[ mysql ] Service already started whith pid $MYSQL_PATH/data/mysqld.pid"
      else
        echo "[ mysql ] Starting service"
        echo "[ mysql ] to activate logs:"
        echo "[ mysql ] ${pkgs.mysql}/bin/mysqladmin --socket=$MYSQL_PATH/tmp/mysql.sock shutdown"

        echo "[ mysql ] ${pkgs.mysql}/bin/mysqld --port=${cfg.port} --bind-address=127.0.0.1 --socket=$MYSQL_PATH/tmp/mysql.sock --datadir=$MYSQL_PATH/data --pid-file=$MYSQL_PATH/data/mysqld.pid --general_log=1 --general_log_file=$MYSQL_PATH/tmp/requests.log &)"

        ${pkgs.mysql}/bin/mysqld --port=${cfg.port} --bind-address=127.0.0.1 --socket=$MYSQL_PATH/tmp/mysql.sock --datadir=$MYSQL_PATH/data --pid-file=$MYSQL_PATH/data/mysqld.pid &
        test -e $MYSQL_PATH/data/initRequired && (echo "[ mysql ] Initializing password..." && sleep 5 && mysqladmin --socket=$MYSQL_PATH/tmp/mysql.sock password "${cfg.password}" && rm -f $MYSQL_PATH/data/initRequired)

        ${createAllDatabases}
      fi

    fi
  '';

  shellStopService = ''
     echo "[ mysql ] Stopping service"
     ${pkgs.mysql}/bin/mysqladmin --socket=$MYSQL_PATH/tmp/mysql.sock shutdown
  '';

  shellDump = ''
    echo "[ mysql ] Dump"
    mkdir -p $ROOT_DUMP/mysql
    ${pkgs.mysql}/bin/mysqldump -h127.0.0.1 -P${cfg.port} -p${cfg.password} --all-databases > $ROOT_DUMP/mysql/dumpall.sql
  '';

  shellRestore = ''
    echo "[ mysql ] Restore"
    ${pkgs.mysql}/bin/mysql -h127.0.0.1 -P${cfg.port} -p${cfg.password} < $ROOT_DUMP/mysql/dumpall.sql
    '';
}
