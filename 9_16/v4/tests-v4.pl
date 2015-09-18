use Test::More tests => 6;

require 'computeTax-v4.pl';

ok computeTaxAmount(100, 0.1) == 10, 'Tax of 10% on $100 is $10';
ok computeTaxAmount(0.1, 100) == 10, 'Order of parameters does not matter';

ok shouldCollectTax("MI"), 'Tax should be collected in MI';
ok shouldCollectTax("OH"), 'Tax should be collected in OH';
ok shouldCollectTax("mi"), 'State abbreviation is not case sensitive';
ok !shouldCollectTax("IL"), 'Tax should not be collected in IL';