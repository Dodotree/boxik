#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
            
my%data;
my $absPath = '/home/olgat/boxik/packets/';
my @devices = ( 'p1p1', 'p2p1', 'p4p1', 'p4p2', 'p4p3');

my $currentTime = time();

for my $dvc ( @devices ){
    if ( -e $absPath.$dvc  and -s $absPath.$dvc ){
	    my ( $t, $span, $v ) = split " ", `cat $absPath$dvc`;
        `rm $absPath$dvc`;
	    $data{ $dvc } = int($v);
        $span = int($span);
        if ($span > 300){
            # go back to modify prev ticks if they exist
        }
    }else{
	    $data{ $dvc } = 0;
    }
}

print time()." $data{ p1p1 } $data{ p2p1 } $data{ p4p1 }"
		." $data{ p4p2 } $data{ p4p3 }\n";

