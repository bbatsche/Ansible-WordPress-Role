Ansible WordPress Role
======================

[![Build Status](https://travis-ci.org/bbatsche/Ansible-WordPress-Role.svg?branch=master)](https://travis-ci.org/bbatsche/Ansible-WordPress-Role)

This role will download WordPress and automatically configure it to connect to a local MySQL database. It will also configure the required cryptographic keys and salts to make sure your WordPress site is secure.

Role Variables
--------------

- `wordpress_version` &mdash; Version of WordPress to download. Default: 4.4.2
- `domain` &mdash; Site domain to install WordPress under
- `db_name` &mdash; MySQL database to use for WordPress
- `new_db_user` &mdash; MySQL user WordPress will use to connect
- `new_db_pass` &mdash; Password for MySQL user
- `storage_dir` &mdash; Cryptographic keys are generated using the Ansible password lookup utility. Those keys will be stored under this directory on the *local* computer
- `http_root` &mdash; Location to store files for sites. Default: /srv/http
- `php_version` &mdash; Optional variable used if a custom version of PHP is required. If specified, this role will use [`bbatsche.Phpenv`](https://galaxy.ansible.com/bbatsche/Phpenv/). If this is omitted, the OS default version of PHP will be installed by [`bbatsche.Codeup-PHP`](https://galaxy.ansible.com/bbatsche/Codeup-PHP/)

_**Note:** The dependencies for this role have multiple other variables that they require as well! Pay attention to the documentation for the other required roles._

Dependencies
------------

This role depends on [`bbatsche.MySQL-Manage`](https://galaxy.ansible.com/bbatsche/MySQL-Manage/) and [`bbatsche.Phpenv`](https://galaxy.ansible.com/bbatsche/Phpenv/) or [`bbatsche.Codeup-PHP`](https://galaxy.ansible.com/bbatsche/Codeup-PHP/). Those roles in turn require [`bbatsche.MySQL-Install`](https://galaxy.ansible.com/bbatsche/MySQL-Install/) and [`bbatsche.Nginx`](https://galaxy.ansible.com/bbatsche/Nginx/). These must be installed before using this role.

```bash
ansible-galaxy install bbatsche.Phpenv
# OR
ansible-galaxy install bbatsche.Codeup-PHP

ansible-galaxy install bbatsche.Nginx
ansible-galaxy install bbatsche.MySQL-Install
ansible-galaxy install bbatsche.MySQL-Manage
```

Example Playbook
----------------

```yml
- hosts: servers
  roles:
  - role: bbatsche.WordPress
    domain: my-blog.com
    db_name: wordpress_db
    new_db_user: wordpress_user
    new_db_pass: super_secure_password
```

License
-------

MIT

Testing
-------

Included with this role is a set of specs for testing each task individually or as a whole. To run these tests you will first need to have [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed. The spec files are written using [Serverspec](http://serverspec.org/) so you will need Ruby and [Bundler](http://bundler.io/). _**Note:** To keep things nicely encapsulated, everything is run through `rake`, including Vagrant itself. Because of this, your version of bundler must match Vagrant's version requirements. As of this writing (Vagrant version 1.8.1) that means your version of bundler must be between 1.5.2 and 1.10.6._

To run the full suite of specs:

```bash
$ gem install bundler -v 1.10.6
$ bundle install
$ rake
```

To see the available rake tasks (and specs):

```bash
$ rake -T
```

There are several rake tasks for interacting with the test environment, including:

- `rake vagrant:up` &mdash; Boot the test environment (_**Note:** This will **not** run any provisioning tasks._)
- `rake vagrant:provision` &mdash; Provision the test environment
- `rake vagrant:destroy` &mdash; Destroy the test environment
- `rake vagrant[cmd]` &mdash; Run some arbitrary Vagrant command in the test environment. For example, to log in to the test environment run: `rake vagrant[ssh]`

These specs are **not** meant to test for idempotence. They are meant to check that the specified tasks perform their expected steps. Idempotency can be tested independently as a form of integration testing.
