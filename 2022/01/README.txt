Part 1 and 2:

perl -M'List::Util qw/sum/' -00 -F'\n' -ane 'print sum(@F),"\n"' input.txt | sort -n

# shorter:
perl -00 -F'\n' -lane '$s=0; map {$s += $_} @F; print $s' input.txt | sort -n


# use last value for task 1 and the sum of the last 3 values for task 2

