#!/usr/bin/perl -w

use strict;
use Cwd;
use Env;

my $cwd;
my $line;
my @args;
my $execPath;

my @path = split/:/,"./:/bin/:/usr/bin/:/usr/local/bin/";
# print "@path\n";

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

  my $commandName = $args[0];

  # Check for exit
  if ($commandName eq "exit"){
    if (defined $args[1]){ exit($args[1]); }
    else{ exit(0); }
    next;
  }

  # Check for cd
  elsif ($commandName eq "cd"){
    if (defined $args[1]){ chdir($args[1]); }
    else{ chdir("$ENV{'HOME'}"); }
    next;
  }


  # Check for exact path given
  elsif($commandName =~ /.*\/.*/){
    if(-e $commandName){
      if(-d $commandName){
        chdir($commandName);
        next;
      } elsif(-X $commandName){
        $execPath = $commandName;
      } else{
        print STDERR "psh: permission denied: $commandName\n";
        next;
      }
    } else{
      print STDERR "psh: no such file or directory: $commandName\n";
      next;
    }
  }

  else{ # Check path
    my $check;
    my $whole;
    for $check (@path){
      $whole = $check.$commandName;
      if(-X $whole){
        $execPath = $whole;
        last;
      }
    }
  }
  next unless length $execPath;

  # Start running stuff
  my $pid = fork();
  unless(length $pid){ # failed to fork
    print STDERR "Failed to fork\n";
    next;
  }
  if ($pid == 0){ # child
    exec { $execPath } @args or die "Couldn't exec $execPath\n";
    exit(0);
  } else { # parent
    wait;
#     print "child <$pid> returned with $?\n";
  }
}

