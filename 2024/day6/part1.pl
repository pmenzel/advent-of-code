#!/usr/bin/perl -w

use strict;
my $obstacles = "";

my $guard_x;
my $guard_y;
my $max_x;
my %visited;

while(<>) {
	chomp;
	$max_x = length($_) - 1;
  while(/#/g) {
  	$obstacles .= "," . $-[0] . " " . ($.-1) . ",";
  }
  if(/\^/) {
		$guard_x = $-[0];
		$guard_y = $. - 1;
  }
}
#print $obstacles,"\n";;
#print $.,"\n";;

my $dir = 1;

while(1) {

	if($guard_y < 0 || $guard_y > $. - 1 || $guard_x < 0 || $guard_x  > $max_x) { last; }
	#print $guard_y . " " . $guard_x . "\n";
	$visited{$guard_y . " " . $guard_x} = 1;

	if($dir == 1) {  # ^
		my $field_above_y = $guard_y - 1;
		if($obstacles =~ /,$guard_x $field_above_y,/) { $dir = 2; }
		else { $guard_y--; };
	}
	elsif($dir == 2) { # >
		my $field_right_x = $guard_x + 1;
		if($obstacles =~ /,$field_right_x $guard_y,/) { $dir = 3; }
		else { $guard_x++; };
	}
	elsif($dir == 3) { # v
		my $field_below_y = $guard_y + 1;
		if($obstacles =~ /,$guard_x $field_below_y,/) { $dir = 4; }
		else { $guard_y++; };
	}
	elsif($dir == 4) { # <
		my $field_left_x = $guard_x - 1;
		if($obstacles =~ /,$field_left_x $guard_y,/) { $dir = 1; }
		else { $guard_x--; };
	}
}

print scalar keys %visited,"\n";
