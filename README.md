# rootless-postgres

This project exists for those who want to run Postgres in a rootless environment. (Looking at you OpenShift)

This is also going to be my first project that I play with GitHub Actions. Want to try a way to have it dynamically build multiple versions of Postgres from one Dockerfile. Goal right now is to support v17 on Alpine. You can however take this Dockerfile and build it for any version of Postgres you want (just keep in mind non Alpine versions require different commands).

The Dockerfile will by default set PGDATA to `/tmp/data`. Do not override this value unless you plan to make changes to the Dockerfile as it further makes sure permissions are set correctly for the data directory.

For deployment be sure to reference the docker-compose.yml file. I plan to also add a Helm chart in the future.

The docker-compose.yml also mounts a `schema.sql` file. This file is used to initialize the database schema on first run. If you have your own schema to initialize, you can mount it here OR if you do not need a schema at all please omit it.

Everything else should be straightforward if you are familiar with using Postgres in a Docker container.
