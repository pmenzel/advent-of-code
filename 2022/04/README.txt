Part 1:

perl -lne '/(\d+)-(\d+),(\d+)-(\d+)/; @a1=$1..$2; @a2=$3..$4; %h1=map{$_=>1} @a1; %h2=map{$_=>1} @a2; @i1=grep($h1{$_},@a2); @i2=grep($h2{$_},@a1); print if("@i1" eq "@a2" or "@i2" eq "@a1")' input.txt | wc -l

just Perl:
perl -lne '/(\d+)-(\d+),(\d+)-(\d+)/; @a1=$1..$2; @a2=$3..$4; %h1=map{$_=>1} @a1; %h2=map{$_=>1} @a2; @i1=grep($h1{$_},@a2); @i2=grep($h2{$_},@a1); $c++ if("@i1" eq "@a2" or "@i2" eq "@a1") }{ print $c' input.txt

# alternative using just the interval bounds:
perl -lne '/(\d+)-(\d+),(\d+)-(\d+)/; $c++ if($1>=$3 && $2<=$4 || $3>=$1 && $4<=$2) }{ print $c' input.txt

# --------------------------------------------------------

Task 2:

perl -lne '/(\d+)-(\d+),(\d+)-(\d+)/; @a1=$1..$2; @a2=$3..$4; %h1=map{$_=>1} @a1; %h2=map{$_=>1} @a2; @i1=grep($h1{$_},@a2); @i2=grep($h2{$_},@a1); print if(@i1 + @i2)' input.txt | wc -l

# alternative using just the interval bounds:
perl -lne '/(\d+)-(\d+),(\d+)-(\d+)/; $c++ if($1>=$3 && $2<=$4 || $3>=$1 && $4<=$2 || $1<=$3 && $2>=$3 || $3<=$1 && $4>=$1 ) }{ print $c' input.txt

