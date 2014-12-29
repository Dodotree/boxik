use strict;
use warnings;
use Data::Dumper;

my $data = `sensors`; 
$data =~ s/[^0-9\+C\.\n]//g;
$data =~ s/C\+.*//g;
$data =~ s/(^|\n)[0]+\n//g;
$data =~ s/(^|\n).*\+/ /g;
$data =~ s/\s+/ /g;
$data = time().$data."\n";
print $data;
