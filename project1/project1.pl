open(PROTEINFILE, 'NM_021964.fasta');

@bases = qw/A C G T/;

# Take the input from the protein file and put each character
# into an list of bases.

while ( $line = <PROTEINFILE> ) {
	next if ($line =~ /^>/);
	chomp $line;
	push(@string, split("", $line));
}

# Iterate over the list and count occurences of G or C.
$baseNum = 0;
foreach $base (@string) {
	if (($base eq "G") || ($base eq "C")) {
		$baseNum++;
	}
}

print "The percentage of G's or C's is $baseNum out of ", 
	   scalar @string, ": ", ($baseNum/@string)*100, "%\n";