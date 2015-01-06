use strict;
use warnings;
use Data::Dumper;

my $data = `df /`;
my @arr = split /\s+/, $data;
#print Dumper( @arr );
$arr[11] =~ s/[%]//;
$data = time()." $arr[11]\n";
print $data;

