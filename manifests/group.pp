# == Define: common::group
#
define common::group (
  $ensure  = 'present',
  $gid     = undef,
  $members = undef,
) {
  if $ensure { validate_re($ensure, '^(absent|present)$') }
  if $members { validate_array($members) }

  group { "group_${name}":
    ensure          => $ensure,
    name            => $name,
    gid             => $gid,
    members         => $members,
    auth_membership => 'minimum',
  }
}
