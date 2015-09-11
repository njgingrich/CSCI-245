$DNA = 'ACTCTAGAGATATA';

print "Here is the starting DNA:\n";
print "$DNA\n\n";

$rev = $DNA;
$rev =~ tr/T/B/;
$rev =~ tr/A/T/;
$rev =~ tr/B/A/; # swap T with A
$rev =~ tr/G/B/;
$rev =~ tr/C/G/;
$rev =~ tr/B/C/; # swap T with A


print "Here is the result of transcribing the reverse complement:\n";
print "$rev\n\n";