#!/usr/bin/env perl

while(<>) {
  print STDERR "-----------------\n$_";
  /(\w) (\d+)/;
  for $i (1..$2) {
    if($1 eq "R") {$Hx++};
    if($1 eq "L") {$Hx--};
    if($1 eq "U") {$Hy++};
    if($1 eq "D") {$Hy--};

       if($Tx < $Hx - 1 and $Ty == $Hy) { $Tx++ }    #  T.H
    elsif($Tx > $Hx + 1 and $Ty == $Hy) { $Tx-- }    #  H.T
                                                     #  T
    elsif($Ty > $Hy + 1 and $Tx == $Hx) { $Ty-- }    #  .
                                                     #  H
                                                     #  H
    elsif($Ty < $Hy - 1 and $Tx == $Hx) { $Ty++ }    #  .
                                                     #  T

                                                             #
    elsif($Ty < $Hy     and $Tx < $Hx -1)  { $Ty++;$Tx++ }   #  .H
                                                             # T

                                                             #
    elsif($Ty > $Hy     and $Tx > $Hx + 1) { $Ty--;$Tx-- }   #   T
                                                             # H.

                                                             #   T
    elsif($Ty > $Hy + 1 and $Tx > $Hx)     { $Ty--;$Tx-- }   #  .
                                                             #  H

                                                             # T
    elsif($Ty > $Hy + 1 and $Tx < $Hx)     { $Ty--;$Tx++ }   #  .
                                                             #  H

                                                             #
    elsif($Ty < $Hy     and $Tx > $Hx + 1) { $Ty++;$Tx-- }   # H.
                                                             #   T

                                                             #
    elsif($Ty > $Hy     and $Tx < $Hx - 1) { $Ty--;$Tx++ }   # T
                                                             #  .H

                                                             #  H
    elsif($Ty < $Hy - 1 and $Tx < $Hx)     { $Ty++;$Tx++ }   #  .
                                                             # T

                                                             #   T
    elsif($Ty > $Hy + 1 and $Tx > $Hx)     { $Ty--;$Tx-- }   #  .
                                                             #  H

                                                             # T
    elsif($Ty > $Hy     and $Tx < $Hx - 1) { $Ty--;$Tx++ }   #  .H
                                                             #

                                                             #  H
    elsif($Ty < $Hy - 1 and $Tx > $Hx)     { $Ty++;$Tx-- }   #  .
                                                             #   T

    print STDERR "H x=$Hx y=$Hy T x=$Tx y=$Ty\n";
    $h{"$Tx $Ty"}=1;
  }
}
print scalar keys %h
