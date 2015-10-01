use strict;

my $numberOfSeats = 0;
if ($ARGV[0]) {
    $numberOfSeats = $ARGV[0];
}
my @initialSeatAssignments;
$#initialSeatAssignments = $numberOfSeats;
my @seatsTaken;
$#seatsTaken = $numberOfSeats;

# initialize initial seats to 1...$numberOfSeats
# for (my $i = 1; $i <= $#initialSeatAssignments; $i++) {
#    $initialSeatAssignments[$i-1] = $i;
# }

my $correct = 0;
my $repetitions = 5;
for (my $i = 0; $i < 5; $i++) {
    @initialSeatAssignments = shuffle([1..$numberOfSeats]);
    $correct += try_seating(@initialSeatAssignments);
    print "correct: $correct\n";
}
print "Number correct: $correct/$repetitions \n";

sub try_seating {
    my @array = @_;
    for (my $passenger = 1; $passenger <= $numberOfSeats; $passenger++) {
        #print "passenger $passenger chose ",
        choose_seat($passenger, @array);#, "\n";
    }

    print "checking if ", $seatsTaken[$numberOfSeats-1], " equals $numberOfSeats\n";
    if ($seatsTaken[$numberOfSeats-1] == $numberOfSeats) {
        print "correct seat\n";
        return 1;
    } else {
        print "wrong seat\n";
        return 0;
    }
}

sub choose_seat {
    my ($passenger, @array) = @_; # 1 to arraySize
    # First passenger chooses a random seat
    if ($passenger == 1) {
        #print "passenger $passenger is first passenger\n";
        my $takenSeat = choose_random_seat(@array);
        $seatsTaken[$takenSeat-1] = $passenger;
        return $takenSeat;

    # He goes to his correct seat
    } elsif ($seatsTaken[$passenger-1] == 0) {
        #print "passenger $passenger is going to correct seat\n";
        $seatsTaken[$passenger-1] = $passenger;
        return $passenger; #index of seat

    # His seat is taken, choose a random available seat
    } else {
        #print "passenger $passenger is going to random seat\n";
        my $takenSeat = choose_available_seat($passenger, @array);
        $seatsTaken[$takenSeat-1] = $passenger;
        return $takenSeat;
    }
}

sub choose_random_seat {
    my @array = @_;
    my $randomSeat = $array[rand $#array];
    return $randomSeat; # 1 to arraySize
}

sub choose_available_seat {
    my ($passenger, @array) = @_; # number 1-arraySize
    my $randomSeat;
    do {
        $randomSeat = choose_random_seat(@array);
    } until ($seatsTaken[$randomSeat-1] == 0);
    return $randomSeat;
}

sub shuffle {
    my $array = shift;
    my $i;
    for ($i = @$array; --$i; ) {
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}
