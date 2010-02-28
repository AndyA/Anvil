#!/usr/bin/env perl

# GOTO __DATA__ for schema revs

require 5.010;

use strict;
use warnings;

use lib qw( lib );

use DBI;
use Data::Dumper;
use Getopt::Long;
use List::Util qw( max );

use constant DBURI  => 'dbi:Pg:dbname=anvil';
use constant DBUSER => 'anvil';
use constant DBPASS => 'anvil';

GetOptions( 'version:i' => \my $version ) or die "Stopping\n";

my $revs = read_revs( *DATA );
$version //= max( keys %$revs );
die "Unknown version: $version\n"
 unless $version == 0 || exists $revs->{$version};

my $dbh = DBI->connect( DBURI, DBUSER, DBPASS,
  { RaiseError => 1, AutoCommit => 0 } );

my $curver = get_version();

if ( $curver == $version ) {
  print "Already at V$version, stopping\n";
  exit;
}

my ( $grading, $sel, $verb, @steps )
 = $version > $curver
 ? ( 'Up', 'do', 'Applying', $curver + 1 .. $version )
 : ( 'Down', 'undo', 'Reverting', reverse $version + 1 .. $curver );

my @missing = ();
for my $step ( @steps ) {
  push @missing, $step unless exists $revs->{$step}{$sel};
}

die "Changes for ", join( ', ', map "V$_", @missing ),
 " can not be ${sel}ne. Stopping.\n"
 if @missing;

print "${grading}grading from V$curver to V$version\n";

for my $step ( @steps ) {
  print "$verb step $step\n";
  for my $stmt ( split /;\s*(?:\n|$)/, $revs->{$step}{$sel} ) {
    $dbh->do( $stmt );
  }
}

set_version( $version );
$dbh->commit;
$dbh->disconnect;

sub get_version {
  local $dbh->{AutoCommit} = 1;
  my $ver = eval {
    $dbh->selectrow_array( 'SELECT value FROM meta WHERE name=?',
      {}, 'version' );
  } || 0;
  return $ver;
}

sub set_version {
  my $ver = shift;
  return if 0 == $ver;
  $dbh->do( 'UPDATE meta SET value=? WHERE name=?',
    {}, $ver, 'version' );
}

sub read_revs {
  my $fh     = shift;
  my %revs   = ();
  my $curkey = undef;
  my $rec    = {};

  my $stash = sub {
    return unless defined $curkey;
    $_ = join "\n", @$_ for values %$rec;
    my $rev = $rec->{revision} // die "No revision\n";
    exists $revs{$rev} and die "Revision $rev already defined\n";
    $revs{$rev} = $rec;
    $rec        = {};
    $curkey     = undef;
  };

  while ( defined( my $line = <$fh> ) ) {
    chomp $line;
    if ( $line =~ /^\s+(.*)/ ) {
      die "Continuation line outside field\n"
       unless defined $curkey;
      push @{ $rec->{$curkey} }, $1;
    }
    elsif ( $line =~ /^(\w+):\s*(.*)/ ) {
      $stash->() if $1 eq 'revision';
      $curkey = $1;
      exists $rec->{$curkey} and die "Field $curkey already exists\n";
      $rec->{$curkey} = length $2 ? [$2] : [];
    }
    elsif ( $line =~ /^\s*$/ ) {
    }
    else {
      die "Syntax error\n";
    }
  }
  $stash->();
  return \%revs;
}

__DATA__
revision: 1
do:
  CREATE TABLE meta (
    name TEXT NOT NULL,
    value TEXT NOT NULL
  );
  INSERT INTO meta VALUES ( 'version', '1' );
undo:
  DROP TABLE meta;

revision: 2
do:
  CREATE TABLE person (
    id            SERIAL PRIMARY KEY,
    name          TEXT NOT NULL,
    email         TEXT NOT NULL
  );

  CREATE TABLE video (
    id            SERIAL PRIMARY KEY,
    title         TEXT NOT NULL,
    description   TEXT NOT NULL,
    posted        TIMESTAMP,
    person_id       INTEGER REFERENCES person(id)
  );

  CREATE TABLE tag (
    id            SERIAL PRIMARY KEY,
    tag           TEXT NOT NULL
  );

  CREATE TABLE video_tag (
    video_id      INTEGER REFERENCES video(id),
    tag_id        INTEGER REFERENCES tag(id),
    PRIMARY KEY (video_id, tag_id)
  );

  CREATE TABLE series (
    id            SERIAL PRIMARY KEY,
    name          TEXT NOT NULL,
    person_id       INTEGER REFERENCES person(id)
  );

  CREATE TABLE video_series (
    video_id      INTEGER REFERENCES video(id),
    series_id     INTEGER REFERENCES series(id),
    PRIMARY KEY (video_id, series_id)
  );

undo:
  DROP TABLE video;
  DROP TABLE tag;
  DROP TABLE video_tag;
  DROP TABLE person;
  DROP TABLE series;
  DROP TABLE video_series;


