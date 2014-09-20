#!/bin/bash

# postgres access problems
#
# psql -U postgres -h localhost
# Password for user postgres: 
# psql: FATAL:  password authentication failed for user "postgres"
# FATAL:  password authentication failed for user "postgres"
#
# psql -U postgres
# psql: FATAL:  Peer authentication failed for user "postgres"
#
# $ psql
# psql: FATAL:  Peer authentication failed for user "vagrant"


# solution
#
# sudo -u postgres psql postgres
# postgres=# CREATE ROLE vagrant LOGIN CREATEDB;
# CREATE ROLE
# postgres=# \du
#                             List of roles
#  Role name |                   Attributes                   | Member of 
# -----------+------------------------------------------------+-----------
#  postgres  | Superuser, Create role, Create DB, Replication | {}
#  vagrant   | Create DB    
#

# alt solution
#
# sudo vi /etc/postgresql/9.3/main/pg_hba.conf
# change METHOD from peer to ident map=aaa

# sudo vi /etc/postgresql/9.3/main/pg_ident.conf
# add line:
# aaa             vagrant                 postgres

# sudo -u postgres usr/lib/postgresql/9.3/bin/pg_ctl reload -D /etc/postgresql/9.3/main/
# response:
# server signaled
# 2014-09-20 21:00:19 UTC LOG:  received SIGHUP, reloading configuration files

# then login:
# psql -U postgres
# psql (9.3.5)
# Type "help" for help.

# then add in config/database.yml
# username: postgres
#
