use strict;
use warnings;
use Data::Dumper;

my%data;
my $absPath = '/home/olgat/boxik/packets/';
my @devices = ( 'br0', 'nflog', 'nfqueue', 'p1p1', 'p2p1', 'p4p1', 'p4p2', 'p4p3', 'any');

for my $dvc ( @devices ){
    if ( -e $absPath.$dvc ){
	my $v = `cat $absPath$dvc`;
	$v =~ s/.*?\s//;
	$data{ $dvc } = int($v);
    }else{
	$data{ $dvc } = 0;
    }
}

print time()." $data{ br0 } $data{ nflog } $data{ nfqueue }"
		." $data{ p1p1 } $data{ p2p1 } $data{ p4p1 }"
		." $data{ p4p2 } $data{ p4p3 } $data{ any }\n";

