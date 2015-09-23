use strict;

# (?:(\w+)(\s?:\s?)){2}((\w+(\s\+\s)+)+)?\w+(\s(<)?=(>)?\s)((\w+(\s\+\s)+)+)?\w+
# (R\d+)\s*:\s*(\d+):\s*([^<]*)(<?=>?)\s*(.*)(")?

while (<>) {
    if (/(?<reaction>R\d+)\s*:\s*(?<map_id>\d+):\s*(?<in>[^<]*)(?<arrow><?=>?)\s*(?<out>.*)/) {
        my ($reaction, $map, $in, $arrow, $out) = ($+{reaction}, $+{map_id}, $+{in}, $+{arrow}, $+{out});
        my @substrates = getList($in);
        my @products = getList($out);

        print $_;
        print "\n";
        print "reaction is ",  $reaction, "\n";
        print "map is ",       $map, "\n";
        print "direction is ", $arrow, "\n";

        if ($arrow ne "<=") {
            printArray("substrate", @substrates);
            printArray("product", @products);
        }

        if ($arrow eq "<=" || $arrow eq "<=>") { # switch products and substrates
            printArray("substrate", @products);
            printArray("product", @substrates);
        }
        print "\n";
    }
}

sub getList {
    my ($str) = @_;
    my @array;
    if ($str !~ /\+/) {
        return ($str); # list of value
    }
    while ($str =~ /(?<i>C\w+)(?:\s*\+\s*)?/g) {
        my $i = $+{i};
        push @array, $i;
    }
    return @array;
}

sub printArray {
    my ($name, @array) = @_;
    foreach my $i (@array) {
        print "$name is $i\n";
    }
}