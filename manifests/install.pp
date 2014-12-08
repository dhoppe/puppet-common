# == Class: common::install
#
class common::install {
  if $::common::package_name {
    package { 'common':
      ensure => $::common::package_ensure,
      name   => $::common::package_name,
    }
  }

  if $::common::package_list {
    ensure_resource('package', $::common::package_list, { 'ensure' => $::common::package_ensure })
  }
}
