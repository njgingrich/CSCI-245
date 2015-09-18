sub computeTaxAmount {
  my ($price, $taxRate) = @_;
  return $price * $taxRate;
}

sub shouldCollectTax {
  my ($stateAbbr) = @_;
  open(FILE, 'states-v4.txt');
  my (@states) = <FILE>;
  chomp(@states);
  
  foreach $line (@states) {
  	#($state, $rate) = split(' ', $line);
	$state = $line;
	
	$abbr = lc($stateAbbr);
	if ($state = $abbr) {
		#return (1, $rate);
		return 1;
	}
  	return 0;
  }
  
}
return 1;