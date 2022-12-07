Part 1:

perl -lne '$l=length;$c1=substr($_,0,$l/2); $c2=substr($_,$l/2); print; print "$c1  $c2"; $c1  =~ /([$c2])/; print $1; $i=ord($1); $s += $i > 96 ? $i-96 : $i-38 }{ print $s' input.txt

# shorter:
perl -lne '$l=length;$c1=substr($_,0,$l/2); substr($_,$l/2) =~ /([$c1])/; $i=ord($1); $s += $i>96 ? $i-96 : $i-38 }{ print $s' input.txt

# -----------------------------------------------------------------------------------------------

Part 2:

# the sed inserts a newline after every 3rd line, from:
# https://edoras.sdsu.edu/doc/sed-oneliners.html
# # add a blank line every 5 lines (after lines 5, 10, 15, 20, etc.)
# gsed '0~5G'                  # GNU sed only

# The \1 searches for the first matched \w at the beginning of the regex
# whereas [^\1]*\n[^\1]*  denotes the space inbetween the three to be matched identical characters (where the char is not allowed to appear again)

sed '0~3G' input.txt | perl -00 -ne 'print; /(\w)[^\1]*\n[^\1]*\1[^\1]*\n[^\1]*\1/; print "$1\n"; $i=ord($1); $s += $i > 96 ? $i-96 : $i-38 }{ print $s'

# shorter:
sed '0~3G' input.txt | perl -00 -ne '/(\w)[^\1]*\n[^\1]*\1[^\1]*\n[^\1]*\1/; $i=ord($1); $s += $i > 96 ? $i-96 : $i-38 }{ print $s'

# repeating the last part of the regex two times:
sed '0~3G' input.txt | perl -00 -ne '/(\w)[^\1]*\n([^\1]*\1[^\1]*\n){2}/; $i=ord($1); $s += $i > 96 ? $i-96 : $i-38 }{ print $s'

