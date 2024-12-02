part 1:

paste <(cut -d" " -f1 input.txt | sort -n) <(awk '{print $2}' input.txt | sort -n) | perl -sane '$s+=abs($F[0]-$F[1]) }{ print $s'


