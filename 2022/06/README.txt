Part 1:

perl -lne '/(\w)((?!\1).)(?!\1)((?!\2).)(?!\1)(?!\2)((?!\3).)/; print "$1$2$3$4 $+[0]"' input.txt


Part 2:

perl -M'List::MoreUtils qw/uniq/' -lne 'print; $i=0; while(1) { if(14 eq uniq(split(//,substr($_,++$i,14)))) {print $i+14; last;} }' input.txt

