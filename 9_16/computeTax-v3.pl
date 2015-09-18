sub computeTaxAmount {
  my ($price, $taxRate) = @_;
  
  return $price * $taxRate;
}

sub shouldCollectTax {
  my ($stateAbbr) = @_;
  return lc($stateAbbr) eq "mi" || lc($stateAbbr) eq "oh";
}

return 1;