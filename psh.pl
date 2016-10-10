#!/usr/bin/perl -w

use strict;
use Cwd;

my $cwd;
my $line;

do{
  # Get working directory and prints
  $cwd = cwd();
  print "$cwd\$ ";

  # Get user command and echo back
  $line = <>;
  chomp $line;
  print "$line\n";

} while($line ne "exit");
