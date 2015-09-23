#(?:(\w+)(\s?:\s?)){2}((\w+(\s\+\s)+)+)?\w+(\s(<)?=(>)?\s)((\w+(\s\+\s)+)+)?\w+

if (!$ARGV[0]) {
    die "No file parameter.\n";
}

my($file) = $ARGV[0];
if (!open(FILE, $file)) {
    die "File doesn't exist.\n";
}

while (<>) {
    if ($_ =~ /(?:(\w+)(\s?:\s?)){2}((\w+(\s\+\s)+)+)?\w+(\s(<)?=>\s)\w+/) {
        print $_;
        print "\n";
        print "1: ", $1, "\n";
        print "2: ", $2, "\n";
        print "3: ", $3, "\n";
        print "4: ", $4, "\n";
        print "5: ", $5, "\n";
        print "6: ", $6, "\n";
    }

}