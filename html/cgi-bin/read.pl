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

#if each 5min, we have 288 records per day
# or 2016 per week, it will not fit to ~ 400px chart
#with 2px thickness lines

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

print "plane $from $upto\n";
while(my $ln = <$in> ){
    print "$ln";
    last if( --$count < 1 );
}

