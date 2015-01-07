#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
            
my%data;
my $absPath = '/home/olgat/boxik/packets/';
my @devices = ( 'any' );

my $currentTime = time();

for my $dvc ( @devices ){
    if ( -e $absPath.$dvc and -s $absPath.$dvc > 0 ){
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

print time()." $data{ any }\n";
