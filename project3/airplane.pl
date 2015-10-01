use strict;

my $numberOfSeats = 5;
if ($ARGV[0]) {
    $numberOfSeats = $ARGV[0];
}
my $repetitions = 100;
if ($ARGV[1]) {
    $repetitions = $ARGV[1];
}

my @initialSeatAssignments;
$#initialSeatAssignments = $numberOfSeats;
my @seatsTaken;
$#seatsTaken = $numberOfSeats;
@initialSeatAssignments = (1..$numberOfSeats);
my $correct = 0;

for (my $i = 0; $i < $repetitions; $i++) {
    $correct += loop_seat_choosing(\@initialSeatAssignments);
}

print "The last passenger got their seat ", ($correct/$repetitions*100), "% of the time.\n";

sub loop_seat_choosing {
    my $initialSeatAssignmentsRef = $_[0];
    shuffle($initialSeatAssignmentsRef);
    @seatsTaken=();
    $#seatsTaken = $numberOfSeats;

    for (my $passenger = 1; $passenger <= $numberOfSeats; $passenger++) {
        choose_seat($passenger, $initialSeatAssignmentsRef);
    }
    my $lastCorrectSeat = @$initialSeatAssignmentsRef[$numberOfSeats-1];
    if ($seatsTaken[$lastCorrectSeat-1] == $numberOfSeats) {
        return 1;
    } else {
        return 0;
    }
}

sub choose_seat {
    my ($passenger, $initialSeatsRef) = ($_[0], $_[1]);
    my $correctSeat = @$initialSeatsRef[$passenger-1];

    # First passenger chooses a random seat
    if ($passenger == 1) {
        my $randomSeat = get_random_seat();
        $seatsTaken[$randomSeat] = $passenger;
    # Passenger's initial seat is unoccupied
    } elsif ($seatsTaken[$correctSeat-1] == 0) {
        $seatsTaken[$correctSeat-1] = $passenger;
    # Passenger's initial seat is occupied
    } else {
        my $freeSeat = find_free_seat();
        $seatsTaken[$freeSeat] = $passenger;
    }
}

sub get_random_seat {
    return int(rand $numberOfSeats); # 0 to last element
}

sub find_free_seat {
    # if seatsTaken[random] = 0 return, else find another
    my $rand;
    do {
        $rand = get_random_seat();
    } until ($seatsTaken[$rand] == 0);
    return $rand;
}

sub shuffle {
    my $array = $_[0];
    my $i;
    for ($i = @$array; --$i; ) {
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}