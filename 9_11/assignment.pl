#!/usr/bin/perl

print "What is your first name? ";
chomp ($first_name = <STDIN>);

print "What is your last name? ";
chomp ($last_name = <STDIN>);

print "Please enter your favorite foods, one per line.\n";
chomp(@foods=<STDIN>);

#  Insert the word "and" into the list of foods, so the user doesn't have 
#  to type it
push @foods, $foods[-1];
$foods[-2] = "and";

#  Assume that we won't include the Oxford comma
$include_oxford_comma = 0;

#  If there is 1 command line argument, check to see if it's the word true
if (@ARGV == 1) {
	$include_oxford_comma = ($ARGV[1] == "true");
}

#  Using the oxford comma means that we should have a comma after each word in the list
if ($include_oxford_comma) {
	$foods = join (", ", @foods[0..(@foods-2)]);
	$foods .= " $foods[-1]";
}
else {
	$foods = join (", ", (@foods[0..(@foods-3)]));
	$foods .= " and $foods[-1]";
}

print "You are $first_name $last_name, and you like to eat $foods!\n";
