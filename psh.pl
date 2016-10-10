#!/usr/bin/perl -w

use strict;
use Cwd;
use Env;

my $cwd;
my $line;
my @args;

while(1){
  # Get working directory and prints
  $cwd = cwd();
  print "$cwd\$ ";

  # Get user command and echo back
  $line = <>;
  chomp $line;

  # Split line into command arguments
  @args = split/\s+/,$line;

  # Check for nothing entered
  next unless @args;

  # Check for exit
  if ($args[0] eq "exit"){
    if (defined $args[1]){ exit($args[1]); }
    else{ exit(0); }
  }

  # Check for cd
  if ($args[0] eq "cd"){
    if (defined $args[1]){ chdir($args[1]); }
    else{ chdir("$ENV{'HOME'}"); }
  }

}

