#!/usr/bin/env perl -w
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
  s/^\s+|\s+$//g;          # trim
  my @F = split /\s+/;
  next unless @F;
  push @m, \@F;
}

# remove last row with operators
my $lastrow = pop @m;        # $lastrow is an arrayref
# print join(" ", @$lastrow), "\n";

my @m2 = @{ transpose(\@m) };

my @joined_rows;
for my $i (0 .. $#m2) {
  my $sep = $lastrow->[$i];
  push @joined_rows, join($sep, @{ $m2[$i] });
}

# now @joined_rows has one string per row
my $sum;
for my $i (@joined_rows) {
	my $res = eval($i);
	$sum += $res;
}
print "sum=$sum";

