use strict;
use Module::Build;

my $build = Module::Build->new
  (
   module_name => 'Probe::Perl',
   license     => 'perl',
   requires => {
		'Config' => 0,
	       },
   build_requires => {
		      'Test' => 0,
		     },
   create_makefile_pl => 'traditional',
  );

$build->create_build_script();
