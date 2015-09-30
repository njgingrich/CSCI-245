use strict;

# test input
my $numberOfSeats = $ARGV[0];
my @initialSeatAssignments;
my @seatsTaken;

for (my $i = 1; $i <= $numberOfSeats; $i++) {
  push @initialSeatAssignments, $i;
}

print "@initialSeatAssignments";