use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME                => 'Probe::MyPerl',
  AUTHOR              => 'Randy W. Sims <randys@thepierianspring.org>',
  VERSION_FROM        => 'lib\ExtUtils\MyPerlConfig.pm',
  ABSTRACT_FROM       => 'lib\ExtUtils\MyPerlConfig.pm',
  PL_FILES            => {},
  PREREQ_PM => {
    'Config' => 0,
    'Test' => 0,
  },
  dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean               => { FILES => 'ExtUtils-MyPerlConfig-*' },
);
