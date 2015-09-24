use strict;

if (!$ARGV[0]) {
    die "No file parameter.\n";
}

# Set the number of most common words to ignore
my $ignoreCount = 0;
if ($ARGV[1]) {
    $ignoreCount = $ARGV[1];
}

my($file) = $ARGV[0];
if (!open(FILE, $file)) {
    die "File doesn't exist.\n";
}

my @lines = <FILE>;
chomp(@lines);
my @wordsInLine;

foreach my $line (@lines) {
    # First, format the words
    $line =~ tr/[A-Z]/[a-z]/; #set everything to lowercase
    $line =~ tr/[a-z]/ /c; #anything non a-z becomes a space

    push @wordsInLine, split(' ', $line);
}

my %words;
foreach my $word (@wordsInLine) {
    if ($words{$word}) {
        $words{$word} += 1;
    } else {
        $words{$word} = 1;
    }
}

my %sortedWords;
# Loop over the words sorted by count
LOOP: foreach my $w (sort {$words{$b} <=> $words{$a}} keys %words) {
    # Ignore the specified amount of words (will gracefully fail if $ignoreCount is undef)
    while ($ignoreCount > 0) {
        $ignoreCount -= 1;
        next LOOP;
    }
    $sortedWords{$w} =$words{$w};
}

foreach my $w (sort keys %sortedWords) {
    print "$w: ", $sortedWords{$w}, "\n";
}

my $wordsSize = keys %words;
my $sortedSize = keys %sortedWords;
my $ignored;
if ($sortedSize < $wordsSize) {
    $ignored = "(ignored " . ($wordsSize-$sortedSize) . " words)";
}
print "Total unique words in $file: ", $sortedSize, " $ignored\n\n";

