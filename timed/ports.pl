use strict;
use warnings;
use Data::Dumper;
            
my%data;
my $absPath = '/home/olgat/boxik/packets/';
my @devices = ( 'p1p1', 'p2p1', 'p4p1', 'p4p2', 'p4p3');

my $currentTime = time();

for my $dvc ( @devices ){
    if ( -e $absPath.$dvc ){
	    my ( $t, $v ) = split " ", `cat $absPath$dvc`;
	    $data{ $dvc } = int($v);
        $data{ $dvc } = 0 if( $currentTime-$t> 300 );
    }else{
	    $data{ $dvc } = 0;
    }
}

print time()." $data{ p1p1 } $data{ p2p1 } $data{ p4p1 }"
		." $data{ p4p2 } $data{ p4p3 }\n";

