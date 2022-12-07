Part 1:

perl -lne 'if(/\[/){ @s=split(//,$_,-1);@c=map 4*$_+1, 0..8;print @s; map {$h{$_}.=$s[$_]} @c;} elsif(/^m[^\d]*(\d+).*(\d).*(\d)/){ print "----"; unshift(@{$m{$3}},reverse splice(@{$m{$2}},0,$1)); map { print "$_=",@{$m{$_}}} sort {$a<=>$b} keys %m; print "--------";  } elsif(/^ 1/) {print "----"; %m=map{$h{$_}=~s/ //g;++$z=>[split(//,$h{$_})]} sort {$a<=>$b} keys %h; map { print "$_=",@{$m{$_}}} sort {$a<=>$b} keys %m; } }{ map { print "$_=",@{$m{$_}}} sort {$a<=>$b} keys %m; ' input.txt

# shorter:
perl -lne 'if(/\[/){ @s=split(//,$_,-1);@c=map 4*$_+1, 0..8; map {$h{$_}.=$s[$_]} @c;} elsif(/^m[^\d]*(\d+).*(\d).*(\d)/){ unshift(@{$m{$3}},reverse splice(@{$m{$2}},0,$1)); } elsif(/^ 1/){ %m=map{$h{$_}=~s/ //g;++$z=>[split(//,$h{$_})]} sort {$a<=>$b} keys %h; } }{ map { print "$_=",@{$m{$_}}} sort keys %m;' input.txt

# --------------------------------------------------------------------------

Part 2:

# just without reversing the array slice:

perl -lne 'if(/\[/){ @s=split(//,$_,-1);@c=map 4*$_+1, 0..8; map {$h{$_}.=$s[$_]} @c;} elsif(/^m[^\d]*(\d+).*(\d).*(\d)/){ unshift(@{$m{$3}},splice(@{$m{$2}},0,$1)); } elsif(/^ 1/){ %m=map{$h{$_}=~s/ //g;++$z=>[split(//,$h{$_})]} sort {$a<=>$b} keys %h; } }{ map { print "$_=",@{$m{$_}}} sort keys %m;' input.txt

# other version without intermediate string containing the stack and directly pushing to arrays:
perl -lne 'if(/\[/){ @s=split(//,$_,-1);@c=map 4*$_+1, 0..8; map { push(@{$z{$_}},$s[$_]) if $s[$_] =~ /\w/ } @c ; map {$h{$_}.=$s[$_]} @c;} elsif(/^m[^\d]*(\d+).*(\d).*(\d)/){ unshift(@{$m{$3}},splice(@{$m{$2}},0,$1)); } elsif(/^ 1/){ %m=map{++$z=>$z{$_}} sort {$a<=>$b} keys %h; }  }{ map { print "$_=",@{$m{$_}}} sort keys %m;' input.txt

