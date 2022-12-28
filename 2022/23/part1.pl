#!/usr/bin/env perl
#
use strict;
use warnings;
use List::Util qw(min max);

my %id2coords;
my %id2nextcoords;
my %coords2id;

sub print_grid {
	my $empty = 0;
	my $min_x = 100000;
	my $max_x = -100000;
	my $min_y = 100000;
	my $max_y = -100000;
	for my $k (keys %coords2id) {
		my ($x, $y) = split(/ /, $k);
		$min_x = min($min_x, $x);
		$max_x = max($max_x, $x);
		$min_y = min($min_y, $y);
		$max_y = max($max_y, $y);
	}
	for(my $iy = $min_y; $iy <= $max_y; $iy++) {
		for(my $ix = $min_x; $ix <= $max_x; $ix++) {
			if(defined $coords2id{$ix . " " . $iy}) {
				print "#";
			}
			else {
				print ".";
				$empty++;
			}
		}
		print "\n";
	}
	print "Empty ground = $empty\n";	
}

my @dirs = qw/N S W E/;

my $id = 1;
my $y = 0;
while(<>) {
	my $x = 0;
	for my $i (split(//,$_)) {
		if($i eq '#') {
			$id2coords{$id} =	"$x $y";
			$coords2id{"$x $y"} =$id;
			$id++;
		}
		$x++;
	}
	$y++;
}
undef $y;

my @ids = sort {$a<=>$b} keys %id2coords;


#for my $i (@ids) {
#	print "$i -> ", $id2coords{$i}, "\n";
#}

for(my $r = 1; $r <= 10; $r++) {
	print "------------------------------------\nRound $r\n";
	#print_grid();
	print "Order of valid directions: @dirs\n";

	foreach my $id (@ids) {
		print "$id -> ", $id2coords{$id}, "\n";

		my ($x, $y) = split(/ /, $id2coords{$id});
		if(defined $coords2id{($x - 1) . " " . ($y - 1)} or # NW
		   defined $coords2id{$x       . " " . ($y - 1)} or # N
		   defined $coords2id{($x + 1) . " " . ($y - 1)} or # NE
		   defined $coords2id{($x + 1) . " " . $y      } or # E
		   defined $coords2id{($x + 1) . " " . ($y + 1)} or # SE
		   defined $coords2id{$x       . " " . ($y + 1)} or # S
		   defined $coords2id{($x - 1) . " " . ($y + 1)} or # SW
		   defined $coords2id{($x - 1) . " " . $y      })   # W
			 # need to move
		{
			for my $dir (@dirs) { #check all four directions
				if($dir eq "N") {
					if(!(defined $coords2id{($x - 1) . " " . ($y - 1)} or defined $coords2id{$x       . " " . ($y - 1)} or defined $coords2id{($x + 1) . " " . ($y - 1)})) {
						# move north
						print "$id moving North to $x ", ($y - 1),"\n";
						$id2nextcoords{$id} = $x . " " . ($y - 1);
						last;
					}
				}
				elsif($dir eq "E") {
					if(!(defined $coords2id{($x + 1) . " " . ($y - 1)} or defined $coords2id{($x + 1) . " " . $y      } or defined $coords2id{($x + 1) . " " . ($y + 1)})) {
						# move east
						print "$id moving East to ", $x + 1, " ", $y,"\n";
						$id2nextcoords{$id} = ($x + 1) . " " . $y;
						last;
					}

				}
				elsif($dir eq "S") {
					if(!(defined $coords2id{($x + 1) . " " . ($y + 1)} or defined $coords2id{$x       . " " . ($y + 1)} or defined $coords2id{($x - 1) . " " . ($y + 1)})) {
						# move South
						print "$id moving South to ", $x, " ", $y + 1,"\n";
						$id2nextcoords{$id} = $x . " " . ($y + 1);
						last;
					}
				}
				elsif($dir eq "W") {
					if(!(defined $coords2id{($x - 1) . " " . ($y - 1)} or defined $coords2id{($x - 1) . " " . $y      }  or defined $coords2id{($x - 1) . " " . ($y + 1)})) {
						# move West
						print "$id moving West to ", $x - 1, " ", $y,"\n";
						$id2nextcoords{$id} = ($x - 1) . " " . $y;
						last;
					}
				}
			}
		}
		else {
			print "No need to move\n";
		}
	} # end for loop all IDs

	# loop all IDs again and actually move if there are no collisions
	foreach my $id (@ids) {
		my $old_coords = $id2coords{$id};
		if(defined($id2nextcoords{$id})) {
			my $new_coords = $id2nextcoords{$id};
			# second loop to check for collisions:
			my $collision_detected = 0;
			foreach my $id2 (@ids) {
				next if $id == $id2;
				if(defined($id2nextcoords{$id2})) {
					my $new_coords2 = $id2nextcoords{$id2};
					if($new_coords eq $new_coords2) {
						$collision_detected = 1;
						last;
					}
				}
			}
			if($collision_detected == 0) {
				#actually move ID to new_coords
				$id2coords{$id} = $new_coords;
				$coords2id{$new_coords} = $id;
				delete($coords2id{$old_coords});
			}
		}
	}
	undef(%id2nextcoords);


 # end of round
 push(@dirs,shift(@dirs));
}

print_grid();
