use strict;
use warnings;
use Data::Dumper;
            
my%data;
my $absPath = '/home/olgat/boxik/packets/';
my @devices = ( 'any', 'br0', 'nflog', 'nfqueue' );

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

print time()." $data{ any } $data{ br0 } $data{ nflog } $data{ nfqueue }\n";
