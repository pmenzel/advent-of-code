Part1:

Search for XMAS on every input line and its reverse for 4 input files:
1. for horizontal words: input.txt
2. for vertical words: the transposed input.txt
3. for diagonal words: input lines increasingly shifted to the left + transpose
4. for the other diagonal: input lines increasingly shifted to the right + transpose

NB: the 200 is just to make enough room around the input lines

perl -lne '$i = $_ . " " . reverse($_); while($i =~ /XMAS/g) {$c++;} }{ print $c'  \
  input.txt \
  <(sed -e 's/./& /g' input.txt | csvtk transpose -d" " | sed 's/,//g') \
  <(perl -F"" -lsane 'print "0" x (200 - $.) . join("",@F) . "1" x ($. - 1);' input.txt | sed -e 's/./& /g' | csvtk transpose -d" " | sed 's/,//g')
  <(perl -F"" -lsane 'print "0" x ($. - 1) . join("",@F) . "1" x (200 - $.);' input.txt | sed -e 's/./& /g' | csvtk transpose -d" " | sed 's/,//g')

