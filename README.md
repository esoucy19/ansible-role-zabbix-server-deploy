# zabbix-server-deploy

This role fully deploys a standalone Zabbix server with a recent version of
MariaDB as its backend.

This is mainly a wrapper around
[dj-wasabi's](https://galaxy.ansible.com/dj-wasabi)
[zabbix-server](https://galaxy.ansible.com/dj-wasabi/zabbix-server) and
[zabbix-web](https://galaxy.ansible.com/dj-wasabi/zabbix-web) roles, as well as
[bertvv's](https://galaxy.ansible.com/bertvv)
[mariadb](https://galaxy.ansible.com/bertvv/mariadb) role.
Credit goes
to them for the heavy-lifting.

The decision to use a recent version of MariaDB instead of the default version
from REL/CentOS 7's repositories was mostly made so we can leverage MariaDB's
Mariabackup software for database backups. See my
[mariabackup](https://galaxy.ansible.com/esoucy19/mariabackup) role if you'd
like to use Mariabackup in your deployment.

As of right now, this role does not install Zabbix with TLS support, although
it probably will once I get around to setting it up.

Requirements
------------
No requirements besides a fresh install of REL/CentOS 7. The role and its
dependencies take care of installing MariaDB and Apache for you.

Do make sure installation of package docs by Yum isn't disabled, though, as
some .sql files zabbix-server depends on are distributed by Zabbix as docs. This
will probably only be an issue if you deploy to a container though.

Role Variables
--------------
The following variables are hard-coded into the role:

- zabbix\_server\_database: mysql
- zabbix\_server\_database\_long: mysql
- zabbix\_server\_database\_creation: true
- zabbix\_server\_database\_sqlload: true

As this is a deployment role, it is opiniated and does not support using a
database other than MariaDB as its backend.

The role also uses the following default variables:

- zabbix\_version: 4.0
- zabbix\timezone: America/Toronto

Staying on the freshly released LTS version 4.0 for the near-future is probably
a good idead, so our role will default to that. Other versions will not be
supported by this role, but feel free to try them.

See [zabbix-server](https://galaxy.ansible.com/dj-wasabi/zabbix-server),
[zabbix-web](https://galaxy.ansible.com/dj-wasabi/zabbix-web) and 
[mariadb](https://galaxy.ansible.com/bertvv/mariadb) for other sensible
variables you may want to set to localize your installation.

Variables of note you will most likely want to set:

- mariadb\_root\_password: Default is "". Set to a non-empty secure password.
- zabbix\_server\_dbpassword: Set to a secure password.
- zabbix\_url: Default is zabbix.example.com. Set according to your environment.
- zabbix\_timezone: Default is America/Toronto


Dependencies
------------

- bertvv.mariadb
- dj-wasabi.zabbix-server
- dj-wasabi.zabbix-web

Example Playbook
----------------

    - hosts: servers
      roles:
         - {role: esoucy19.zabbix-server-deploy,
            mariadb_root_password: password,
            zabbix_server_dbpassword: zabbix,
            zabbix_url: zabbix-server.example.com
            zabbix_timezone: America/Toronto}

License
-------

MIT

Author Information
------------------

This role was created in 2018 by
[Etienne Soucy](https://github.com/esoucy19)
