file { 'barfile':
  ensure	=> file,
  mode		=> '0644',
  path		=> "/tmp/$::bar",
  content	=> "$::foo",
}

