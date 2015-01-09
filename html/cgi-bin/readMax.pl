#!/usr/bin/perl
print "Content-type: text/html\n\n";

use strict;
use warnings;
use Data::Dumper;
use CGI qw(:standard Vars);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my %FORM = Vars();
#print Dumper( \%FORM );
my $logname = "../logs/".$FORM{ 'file' };
my $upto = ( $FORM{ 'upto' } )? $FORM{ 'upto' } : time(); 
my $from = ( $FORM{ 'from' } )? $FORM{ 'from' } : $upto - 60*60*24*7;
my $width = ( $FORM{ 'width' } )? $FORM{ 'width' }/2 : 150;
# w/2 because lines are 2px thick

# if each 5min, we have 288 records per day
# or 2016 per week, it will not fit to ~ 400px chart

# so we need tileW/2 points maximum from given time span
# we can average temperatures, but other stuff spikes are important

open my $in,  '<',  $logname;
my $count=0;
my $dot = -1;
my $lastdot = -1;
while(my $ln = <$in> ){
    my @arr = split " ", $ln;
    if ( $dot == -1 and $from <= $arr[0] ){
        $dot = ( $lastdot>-1)? $lastdot:0;
    }
    $lastdot = tell( $in );
    if( $from <= $arr[0] and $arr[0] <= $upto ){
        $count++;
    }elsif( $arr[0] > $upto ){ last; }
}
if( $dot ){ seek $in, $dot-$lastdot, 1;
}else{      seek $in, 0 ,0; }

my $step = int( $count/$width )+1;
my @lnarr;
my $i = 0;

print "plane, time:".time()." Data:$from $upto $count $width $step\n";
while(my $ln = <$in> ){
    my @arr = split " ", $ln;
    if( $i%$step == 0 ){
        print join( " ", @lnarr )."\n" if $i!=0;
        @lnarr = @arr;
    }else{
        for( my $ii = 1; $ii < @arr ; $ii++ ){
            $lnarr[ $ii ] = $arr[ $ii ] if $lnarr[ $ii ] < $arr[ $ii ];
        }
    }

    last if( --$count < 1 );
    $i++;
}

