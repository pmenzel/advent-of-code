#!/usr/bin/env perl -w

# NB: input file needs padding whitespace in the last columns

use strict;
use warnings;

sub transpose {
  my ($m) = @_;            # $m is arrayref of rows
  my $rows = @$m;
  my $cols = @{$m->[0]};
  my @t;
  for my $c (0 .. $cols-1) {
    for my $r (0 .. $rows-1) {
        $t[$c][$r] = $m->[$r][$c];
    }
  }
  return \@t;              # arrayref
}

# read input into 2D array
my @m;
while (<>) {
  next unless length;
  chomp;
  my @F = split //;
  next unless @F;
  push @m, \@F;
}

my @m2 = @{ transpose(\@m) };

my @numbers;
my $sum;
for(my $i=$#m2; $i >=0; $i--) {
	my $n = join "", @{ $m2[$i] } ;
	if($n =~ m/(.*)([+*])$/) {
	  push @numbers, $1;
	  $sum += eval(join($2,@numbers));
	  @numbers = ();
	}
	else {
		next if $n =~ /^\s+$/;
	  push @numbers, $n;
	}
}
print "sum=$sum\n";

