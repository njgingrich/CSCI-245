use strict;

my $numberOfSeats = 0;
if ($ARGV[0]) {
    $numberOfSeats = $ARGV[0];
}
my @initialSeatAssignments;
$#initialSeatAssignments = $numberOfSeats;
my @seatsTaken;
$#seatsTaken = $numberOfSeats;

my $correct = 0;
my $repetitions = 5;
for (my $i = 0; $i < $repetitions; $i++) {
    @initialSeatAssignments = (1..$numberOfSeats);
   # @initialSeatAssignments = shuffle([1..$numberOfSeats]);
    shuffle(\@initialSeatAssignments);
    my $val = try_seating(\@initialSeatAssignments);
    print "correct: $correct\n";
}
print "Number correct: $correct/$repetitions \n";

sub try_seating {
    my $arrayRef = $_[0];
    for (my $passenger = 1; $passenger <= $numberOfSeats; $passenger++) {
        print "trying seating\n";
        choose_seat($passenger, $arrayRef);
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
    my $passenger = $_[0]; # 1 to arraySize
    my $arrayRef = $_[1];
    my $correctSeat = @$arrayRef[$passenger-1];

    # First passenger chooses a random seat
    if ($passenger == 1) {
        print "passenger $passenger is first passenger\n";
        my $takenSeat = choose_random_seat($arrayRef);
        $seatsTaken[$takenSeat-1] = $passenger;
        print "passenger 1 chose $takenSeat\n";
        return $takenSeat;

    # He goes to his correct seat
    } elsif ($seatsTaken[$correctSeat] == 0) {
        print "passenger $passenger is going to correct seat\n";
        $seatsTaken[$correctSeat] = $passenger;
        return $passenger; #index of seat

    # His seat is taken, choose a random available seat
    } else {
        print "passenger $passenger is going to random seat\n";
        my $takenSeat = choose_available_seat($passenger, \@seatsTaken);
        print "passenger $passenger chose seat $takenSeat\n";
        $seatsTaken[$takenSeat-1] = $passenger;
        return $takenSeat;
    }
}

sub choose_random_seat {
    my @array = @{$_[0]};
    my $randomSeat = @array[rand $numberOfSeats];
    return $randomSeat; # 1 to arraySize
}

sub choose_available_seat {
    my $passenger = $_[0]; # 1 to arraySize
    my $arrayRef = $_[1];
    my $randomSeat;

    do {
        $randomSeat = choose_random_seat($arrayRef);
    } until ($seatsTaken[$randomSeat-1] == 0);
    return $randomSeat;
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
