# == Define: common::user
#
define common::user (
  $ensure          = 'present',
  $uid             = undef,
  $gid             = undef,
  $comment         = undef,
  $home            = undef,
  $shell           = '/bin/bash',
  $groups          = undef,
  $managehome      = true,
  $password        = undef,
  $purge_ssh_keys  = true,
  $ssh_key_options = undef,
  $ssh_key_type    = 'ssh-rsa',
  $ssh_key         = undef,
) {
  if $ensure { validate_re($ensure, '^(absent|present)$') }
  if $comment { validate_string($comment) }
  if $home { validate_absolute_path($home) }
  if $shell { validate_string($shell) }
  if $groups { validate_array($groups) }
  if $managehome { validate_bool($managehome) }
  if $password { validate_string($password) }
  if $purge_ssh_keys { validate_bool($purge_ssh_keys) }
  if $ssh_key_options { validate_array($ssh_key_options) }
  if $ssh_key_type { validate_string($ssh_key_type) }
  if $ssh_key { validate_string($ssh_key) }

  if $home {
    $_home = $home
  } else {
    $_home = "/home/${name}"
  }

  user { "user_${name}":
    ensure          => $ensure,
    name            => $name,
    uid             => $uid,
    gid             => $gid,
    comment         => "${comment},,,",
    home            => $_home,
    shell           => $shell,
    auth_membership => 'minimum',
    groups          => $groups,
    managehome      => $managehome,
    password        => $password,
    purge_ssh_keys  => $purge_ssh_keys,
  }

  if $ssh_key {
    ssh_authorized_key { "ssh_key_${name}":
      ensure  => $ensure,
      options => $ssh_key_options,
      type    => $ssh_key_type,
      key     => $ssh_key,
      name    => $comment,
      user    => $name,
    }
  }
}
