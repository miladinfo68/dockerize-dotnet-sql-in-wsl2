# #!/bin/bash
set -e

# Start SQL Server
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start up
sleep 30s

# Run SQL scripts to create database and insert data
/opt/mssql-tools/bin/sqlcmd -S $MASTER_DB_SERVER_IP -U sa -P $SQL_SA_USER_PASSWORD -d master -i initdb.sql
#  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Pass123! -d master -C -i initdb.sql
#  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Pass123! -d master -i initdb.sql
# ubuntu ip inside wsl (in windows) ====> windows 10 ---> wsl ---> ubuntu 22.04

# # Keep the container running
tail -f /dev/null


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# # !/bin/bash
# set -e

# if [ "$1" = '/opt/mssql/bin/sqlservr' ]; then
#   # If this is the container's first run, initialize the application database
#   if [ ! -f /tmp/app-initialized ]; then
#     # Initialize the application database asynchronously in a background process. This allows a) the SQL Server process to be the main process in the container, which allows graceful shutdown and other goodies, and b) us to only start the SQL Server process once, as opposed to starting, stopping, then starting it again.
#     function initialize_app_database() {
#       # Wait a bit for SQL Server to start. SQL Server's process doesn't provide a clever way to check if it's up or not, and it needs to be up before we can import the application database
#       sleep 20s

#       #run the setup script to create the DB and the schema in the DB
#       /opt/mssql-tools/bin/sqlcmd -S $MASTER_DB_SERVER_IP -U sa -P $SQL_SA_USER_PASSWORD -d master -i initdb.sql
#       #/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Pass123! -d master -i initdb.sql

#       # Note that the container has been initialized so future starts won't wipe changes to the data
#       touch /tmp/app-initialized
#     }
#     initialize_app_database &
#   fi
# fi

# exec "$@"

# # Keep the container running
# tail -f /dev/null








