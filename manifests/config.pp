# == Class: common::config
#
class common::config {
  if $::common::config_dir_source {
    file { 'common.dir':
      ensure  => $::common::config_dir_ensure,
      path    => $::common::config_dir_path,
      force   => $::common::config_dir_purge,
      purge   => $::common::config_dir_purge,
      recurse => $::common::config_dir_recurse,
      source  => $::common::config_dir_source,
      require => $::common::config_file_require,
    }
  }

  if $::common::config_file_path {
    file { 'common.conf':
      ensure  => $::common::config_file_ensure,
      path    => $::common::config_file_path,
      owner   => $::common::config_file_owner,
      group   => $::common::config_file_group,
      mode    => $::common::config_file_mode,
      source  => $::common::config_file_source,
      content => $::common::config_file_content,
      require => $::common::config_file_require,
    }
  }
}
