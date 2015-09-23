use strict;

# (?:(\w+)(\s?:\s?)){2}((\w+(\s\+\s)+)+)?\w+(\s(<)?=(>)?\s)((\w+(\s\+\s)+)+)?\w+
# (R\d+)\s*:\s*(\d+):\s*([^<]*)(<?=>?)\s*(.*)(")?

while (<>) {
    if (/(?<reaction>R\d+)\s*:\s*(?<map_id>\d+):\s*(?<in>[^<]*)(?<arrow><?=>?)\s*(?<out>.*)/) {
        my ($reaction, $map, $in, $arrow, $out) = ($+{reaction}, $+{map_id}, $+{in}, $+{arrow}, $+{out});
        print $_;
        print "\n";
        print "reaction is ",  $reaction, "\n";
        print "map is ",       $map, "\n";
        print "direction is ", $arrow, "\n";
        print "substrate is ", $in, "\n";
        print "product is ",   $out, "\n";
        if ($in =~ /\+/) {
            
        }
    }

}