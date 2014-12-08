# common

[![Build Status](https://travis-ci.org/dhoppe/puppet-common.png?branch=master)](https://travis-ci.org/dhoppe/puppet-common)
[![Puppet Forge](https://img.shields.io/puppetforge/v/dhoppe/common.svg)](https://forge.puppetlabs.com/dhoppe/common)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with common](#setup)
    * [What common affects](#what-common-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with common](#beginning-with-common)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

This module manages user accounts and common packages.

## Module Description

This module handles managing user accounts and installing common packages across a range of operating systems and distributions.

## Setup

### What common affects

* user accounts.
* common packages.

### Setup Requirements

* Puppet >= 2.7
* Facter >= 1.6
* [Stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)

### Beginning with common

Install common with the default parameters ***(No configuration files will be changed)***.

```puppet
    class { 'common': }
```

Install common with the recommended parameters.

```puppet
    class { 'common':
      config_file_hash => {
        'passwd' => {},
        'shadow' => {
          config_file_group => 'shadow',
          config_file_mode  => '0640',
        },
      },
      package_list     => [
        'colordiff',
        'dcfldd',
        'debian-goodies',
        'deborphan',
        'dstat',
        'ethtool',
        'htop',
        'ifstat',
        'iftop',
        'iotop',
        'ipcalc',
        'iperf',
        'molly-guard',
        'mtr-tiny',
        'nmap',
        'parted',
        'pwgen',
        'rsync',
        'sysstat',
        'tcpdump',
        'tree',
        'unrar',
        'unzip',
      ],
      groups_hash      => {
        'docker' => {
          members => ['dhoppe'],
        }
      },
      users_hash       => {
        'dhoppe' => {
          'comment'         => 'Dennis Hoppe',
          'groups'          => [
            'audio',
            'cdrom',
            'dip',
            'floppy',
            'plugdev',
            'sudo',
            'video',
          ],
          'password'        => '$6$9zv3v3FT5qU$W/0yudPmRfUl55EaCv2nCk7eLB5TJ2YpLCRMurdR/bP2HpMbXM3eHvZmxu7JahYjFHZ1ThOkjc8KNQ3oIa1Aq1',
          'ssh_key'         => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDuXXte0XbIfh7iAEjw7gNKMhNFnlNwI2yt5CR4xrDuBWqNF9JZ266R9e77Z/uo4ayev/whmk8btuw3IsYJdQ4FGwJp7yOShcOKk/Y44/7ROggM71K525MdxhlYthe2hzbFMzRw6IUvhJih81ehD/VULEIuD0nsqutrTfe2c4Dgd2BeTeKPFazyYKSdhb2NGsXwe2tEOJKpRCopmOPDGnyiLPEW7j2DX1uwBVFx/ZUh8gwEia7gLqgLeqBN30DuDk8RAO6cL0cMB7H0tPXDtq/Ooyn974pk73MXPoCkiAwe/9xROLQzqDEqf1N5t7+cDeLWaClh80scEyBTNRkoUDLR',
        },
      },
    }
```

## Usage

Update the common package.

```puppet
    class { 'common':
      package_ensure => 'latest',
    }
```

Remove the common package.

```puppet
    class { 'common':
      package_ensure => 'absent',
    }
```

Purge the common package ***(All configuration files will be removed)***.

```puppet
    class { 'common':
      package_ensure => 'purged',
    }
```

Deploy the configuration files from source directory.

```puppet
    class { 'common':
      config_dir_source => 'puppet:///modules/common/etc',
    }
```

Deploy the configuration files from source directory ***(Unmanaged configuration files will be removed)***.

```puppet
    class { 'common':
      config_dir_purge  => true,
      config_dir_source => 'puppet:///modules/common/etc',
    }
```

Deploy the configuration file from source.

```puppet
    class { 'common':
      config_file_source => 'puppet:///modules/common/etc/group',
    }
```

Deploy the configuration file from string.

```puppet
    class { 'common':
      config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
    }
```

Deploy the configuration file from template.

```puppet
    class { 'common':
      config_file_template => 'common/etc/group.erb',
    }
```

Deploy the configuration file from custom template ***(Additional parameters can be defined)***.

```puppet
    class { 'common':
      config_file_template     => 'common/etc/group.erb',
      config_file_options_hash => {
        'key' => 'value',
      },
    }
```

Deploy additional configuration files from source, string or template.

```puppet
    class { 'common':
      config_file_hash => {
        'group.2nd' => {
          config_file_path   => '/etc/group.2nd',
          config_file_source => 'puppet:///modules/common/etc/group.2nd',
        },
        'group.3rd' => {
          config_file_path   => '/etc/group.3rd',
          config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        },
        'group.4th' => {
          config_file_path     => '/etc/group.4th',
          config_file_template => 'common/etc/group.4th.erb',
        },
      },
    }
```

## Reference

### Classes

#### Public Classes

* common: Main class, includes all other classes.

#### Private Classes

* common::install: Handles the packages.
* common::config: Handles the configuration file.

### Parameters

#### `package_ensure`

Determines if the package should be installed. Valid values are 'present', 'latest', 'absent' and 'purged'. Defaults to 'present'.

#### `package_name`

Determines the name of package to manage. Defaults to 'undef'.

#### `package_list`

Determines if additional packages should be managed. Defaults to 'undef'.

#### `config_dir_ensure`

Determines if the configuration directory should be present. Valid values are 'absent' and 'directory'. Defaults to 'directory'.

#### `config_dir_path`

Determines if the configuration directory should be managed. Defaults to '/etc'

#### `config_dir_purge`

Determines if unmanaged configuration files should be removed. Valid values are 'true' and 'false'. Defaults to 'false'.

#### `config_dir_recurse`

Determines if the configuration directory should be recursively managed. Valid values are 'true' and 'false'. Defaults to 'true'.

#### `config_dir_source`

Determines the source of a configuration directory. Defaults to 'undef'.

#### `config_file_ensure`

Determines if the configuration file should be present. Valid values are 'absent' and 'present'. Defaults to 'present'.

#### `config_file_path`

Determines if the configuration file should be managed. Defaults to '/etc/group'

#### `config_file_owner`

Determines which user should own the configuration file. Defaults to 'root'.

#### `config_file_group`

Determines which group should own the configuration file. Defaults to 'root'.

#### `config_file_mode`

Determines the desired permissions mode of the configuration file. Defaults to '0644'.

#### `config_file_source`

Determines the source of a configuration file. Defaults to 'undef'.

#### `config_file_string`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_template`

Determines the content of a configuration file. Defaults to 'undef'.

#### `config_file_require`

Determines which package a configuration file depends on. Defaults to 'undef'.

#### `config_file_hash`

Determines which configuration files should be managed via `common::define`. Defaults to '{}'.

#### `config_file_options_hash`

Determines which parameters should be passed to an ERB template. Defaults to '{}'.

### Parameters within `common::group`

#### `ensure`

Determines if the group should be created. Valid values are 'absent' and 'present'. Defaults to 'present'.

#### `gid`

Determines which group ID should be used. Defaults to 'undef'.

#### `members`

Determines the members of the group. Defaults to 'undef'.

### Parameters within `common::user`

#### `ensure`

Determines if the user should be created. Valid values are 'absent' and 'present'. Defaults to 'present'.

#### `uid`

Determines which user ID should be used. Defaults to 'undef'.

#### `gid`

Determines which group ID should be used. Defaults to 'undef'.

#### `comment`

Determines a description of the user. Defaults to 'undef'.

#### `home`

Determines the home directory of the user. Defaults to "/home/${name}".

#### `shell`

Determines the user's login shell. Defaults to '/bin/bash'.

#### `groups`

Determines the groups to which the user belongs. Defaults to 'undef'.

#### `managehome`

Determines whether to manage the home directory when managing the user. Valid values are 'true' and 'false'. Defaults to 'true'.

#### `password`

Determines the user's password. Defaults to 'undef'.

#### `purge_ssh_keys`

Determines whether to purge authorized SSH keys for this user if they are not managed with the ssh_authorized_key resource type. Valid values are 'true' and 'false'. Defaults to 'true'.

#### `ssh_key_options`

Determines the SSH key options; see sshd(8) for possible values. Defaults to 'undef'.

#### `ssh_key_type`

Determines the encryption type used. Valid values are 'ssh-dss', 'ssh-rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521' and 'ssh-ed25519'. Defaults to 'ssh-rsa'.

#### `ssh_key`

Determines the public key itself. Defaults to 'undef'.

## Limitations

This module has been tested on:

* Debian 6/7
* Ubuntu 12.04/14.04

## Development

### Bug Report

If you find a bug, have trouble following the documentation or have a question about this module - please create an issue.

### Pull Request

If you are able to patch the bug or add the feature yourself - please make a pull request.

### Contributors

The list of contributors can be found at: [https://github.com/dhoppe/puppet-common/graphs/contributors](https://github.com/dhoppe/puppet-common/graphs/contributors)
