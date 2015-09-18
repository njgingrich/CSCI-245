sub computeTaxAmount {
  my ($price, $taxRate) = @_;
  
  return $price * $taxRate;
}

sub shouldCollectTax {
  my ($stateAbbr) = @_;
  return $stateAbbr eq "MI" || $stateAbbr eq "OH";
}

return 1;