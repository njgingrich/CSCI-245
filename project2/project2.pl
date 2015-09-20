if (!$ARGV[0]) {
    die "No file parameter.\n";
}

my($file) = $ARGV[0];
if (!open(FILE, $file)) {
    die "File doesn't exist.\n";
}

# Put each character of the protein sequence into an array
while ( $line = <FILE> ) {
	next if ($line =~ /^>/);
	chomp $line;
	push(@string, split("", $line));
}

my %chars = (
    "A" => 0,
    "C" => 0,
    "D" => 0,
    "E" => 0,
    "F" => 0,
    "G" => 0,
    "H" => 0,
    "I" => 0,
    "K" => 0,
    "L" => 0,
    "M" => 0,
    "N" => 0,
    "P" => 0,
    "Q" => 0,
    "R" => 0,
    "S" => 0,
    "T" => 0,
    "V" => 0,
    "W" => 0,
    "Y" => 0,);

# Count occurences
foreach $char (@string) {
    $chars{$char} += 1;
}

print "Alphabetical order of proteins:\n";
foreach $char (sort keys %chars) {
    print "$char ", $chars{$char}, "\n";
}

# Count different acids total
my $count = 0;
foreach my $char (sort keys %chars) {
    if ($chars{$char}) {
        $count += 1;
    } else {
        push @nonOccurance, $char;
    }
}

if (@nonOccurance < 2) {
    $non = @nonOccurance[0];
} else {
    $non = join(", ", @nonOccurance[0..(@nonOccurance-2)]) . " or " . $nonOccurance[@nonOccurance-1];
}

print "\nNumber of different amino acids: $count\n";
print "No occurences of ", $non ,"\n";

# Sort in order of count
print "\nAmino acids in order of count:\n";
foreach my $char (sort {$chars{$b} <=> $chars{$a}} keys %chars) {
    print "$char ", $chars{$char}, "\n";
}
