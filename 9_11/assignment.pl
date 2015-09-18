#!/usr/bin/perl

print "What is your first name? ";
chomp ($first_name = <STDIN>);

print "What is your last name? ";
chomp ($last_name = <STDIN>);

print "Please enter your favorite foods, one per line.\n";
print "Ctrl-D to finish.\n";
chomp(@foods=<STDIN>);

#  Remove empty entries
foreach $food (@foods) {
  if ($food ne '') {
    push(@newfoods, $food);
  }
}

#  Insert the word "and" into the list of foods, so the user doesn't have
#  to type it
push @newfoods, $newfoods[-1];
$newfoods[-2] = "and";

#  Assume that we won't include the Oxford comma
$include_oxford_comma = 0;

#  If there is 1 command line argument, check to see if it's the word true
if (@ARGV == 1) {
	$include_oxford_comma = ($ARGV[1] == "true");
}

#  Using the oxford comma means that we should have a comma after each word in the list
if ($include_oxford_comma) {
	$foods = join (", ", @newfoods[0..(@newfoods-2)]);
	$foods .= " $foods[-1]";
}
else {
	$foods = join (", ", (@newfoods[0..(@newfoods-3)]));
	$foods .= " and $foods[-1]";
}

print "You are $first_name $last_name, and you like to eat $foods!\n";

