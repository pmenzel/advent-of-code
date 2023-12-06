
Part 1:

perl -le '%h=qw/40 277 82 1338 91 1349 66 1063/; $C=1; foreach(keys %h) { $c=0; for($i=1;$i<$_;$i++) { $c++ if $i*($_-$i) > $h{$_} } $C*=$c } print $C'


Part 2:

perl -le '%h=qw/40829166 277133813491063/; $C=1; foreach(keys %h) { $c=0; for($i=1;$i<$_;$i++) { $c++ if $i*($_-$i) > $h{$_} } $C*=$c } print $C '

computes just fine

