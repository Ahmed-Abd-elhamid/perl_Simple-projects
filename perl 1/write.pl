#!/usr/bin/perl
### Script to generate numbers from 1 to 1000 and put them in a file
use strict;
my $count = 1;
my $max;
my $file;

$max = 1000;

print ("Enter file name to write on it: ");
$file = <STDIN>;

while ($count <= $max)
{
    `echo $count >> $file`;
    $count = $count+1;
}
