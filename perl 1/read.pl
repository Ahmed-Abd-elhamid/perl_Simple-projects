#!/usr/bin/perl
### Script to generate numbers from 1 to 1000 and put them in a file
use strict;

my $sum;
my $file;

$sum = 0;

print ("Enter file name to read it: ");
$file = <STDIN>;

foreach(`cat $file`) {
  chomp $_;
	# print "Value = $_ \n";
  $sum = $sum + $_;
}
print "The Total = $sum \n";
`echo $sum >> $file`;
