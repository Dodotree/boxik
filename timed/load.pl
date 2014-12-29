use strict;
use warnings;
use Data::Dumper;

my $data = `cat /proc/loadavg`;
my @arr = split /\s/, $data;
pop( @arr); pop( @arr);
$data = join " ", @arr;
$data = time()." $data\n";
print $data;

