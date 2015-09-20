if (!$ARGV[0]) {
    die "No file parameter.\n";
}

# Set the number of most common words to ignore
my $ignoreCount = 0;
if ($ARGV[1]) {
    # todo: check if ARGV[1] is a number
    $ignoreCount = $ARGV[1];
}

my($file) = $ARGV[0];
if (!open(FILE, $file)) {
    die "File doesn't exist.\n";
}

@lines = <FILE>;
chomp(@lines);

foreach $line (@lines) {
    # First, format the words
    $line =~ tr/[A-Z]/[a-z]/; #set everything to lowercase
    $line =~ tr/[a-z]/ /c; #anything non a-z becomes a space

    push @wordsInLine, split(' ', $line);
}

my %words;
foreach $word (@wordsInLine) {
    if ($words{$word}) {
        $words{$word} += 1;
    } else {
        $words{$word} = 1;
    }
}


foreach $w (sort {$words{$b} <=> $words{$a}} keys %words) {
    print "$w => ", $words{$w}, "\n";
}
