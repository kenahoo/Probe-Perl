
use strict;
use Test;
BEGIN { plan tests => 26 }

use Probe::MyPerl;
ok( 1 );

my $configurator = tie( my %config, 'Probe::MyPerl' );
ok( defined( $configurator ) );

# underlying $Config value is present thru both tied and method calls
use Config;
ok( $Config{version} eq $config{version} );
ok( $Config{version} eq $configurator->get('version') );

# returns undef for non-existent keys
ok( ! defined( $configurator->get( 'foobarbaz' ) ) );

# basic set, has, and get test
$configurator->set( foo => 'bar' );
ok( $configurator->has( 'foo' ) );
ok( $configurator->get( 'foo' ) eq 'bar' );

# override $Config value
my $perl = $configurator->get( 'perl' );
$configurator->set( perl => 'otherperl' );
ok( $configurator->get( 'perl' ) eq 'otherperl' );

# undo override
$configurator->unset( 'perl' );
ok( $configurator->get( 'perl' ) eq $perl );

# multiple set assignments
$configurator->set( a => 1, b => 2, c => 3 );
ok( "@{[$configurator->get( qw( a b c ) )]}" eq '1 2 3' );

# has returns if user value || Config value exists
ok( $configurator->has( 'version' ) );
ok( ! $configurator->has( 'foobarbaz' ) );
ok( Probe::MyPerl->has( 'version' ) );
ok( ! Probe::MyPerl->has( 'foobarbaz' ) );

ok( Probe::MyPerl->os_type( 'linux' ) eq 'Unix' );
ok( Probe::MyPerl->os_type( 'MSWin32' ) eq 'Windows' );


# both object and class method return same value
my $perl1 = $configurator->find_perl_interpreter();
ok( $perl1 );
my $perl2 = Probe::MyPerl->find_perl_interpreter();
ok( $perl2 );
ok( $perl1 eq $perl2 );

ok( $configurator->perl_is_same( $perl1 ) );


# both object and class method return same value
my $perl_vers1 = $configurator->perl_version();
ok( $perl_vers1 );
my $perl_vers2 = Probe::MyPerl->perl_version();
ok( $perl_vers2 );
ok( $perl_vers1 eq $perl_vers2 );


my @perl_inc1 = $configurator->perl_inc();
ok( @perl_inc1 );

my @perl_inc2 = Probe::MyPerl->perl_inc();
ok( @perl_inc2 );

sub compare_array {
  my( $a1, $a2 ) = @_;
  return 0 unless @$a1 == @$a2;
  foreach my $i ( 0..$#$a1 ) {
    return 0 unless $a1->[$i] eq $a2->[$i];
  }
  return 1;
}

ok( compare_array( \@perl_inc1, \@perl_inc2 ) );
