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

my @lines;
open my $in,  '<',  $logname;
while(my $ln = <$in> ){
    my @arr = split " ", $ln;
    if( $from < $arr[0] and $arr[0] < $upto ){
	    push @lines, $ln;
    }
}
print "plane $from $upto\n";
if( @lines > 200 ){
    my $step = int( @lines/200 )+1;
    my @lnarr;
    my $i = 0;
    while( my $ln1 = shift( @lines ) ){
        my @arr = split " ", $ln1;
        $lnarr[0] = $arr[0];
        if( $i%$step == 0 ){
            if( $i!=0 ){ 
                for( my $ii = 1; $ii < @arr ; $ii++ ){ 
                   $lnarr[ 3*$ii-2 ] = &sigFigs( $lnarr[ 3*$ii-2 ]/$step, 4 ); }
                print join( " ", @lnarr )."\n"; 
            }
            $#lnarr=0;
            for( my $ii = 1; $ii < @arr ; $ii++ ){ 
               push @lnarr,  $arr[ $ii ];
               push @lnarr,  $arr[ $ii ]; #minimum
               push @lnarr,  $arr[ $ii ]; #maximum
            }
        }else{
            for( my $ii = 1; $ii < @arr ; $ii++ ){ 
                $lnarr[ 3*$ii-2 ] +=$arr[ $ii ]; 
                $lnarr[ 3*$ii-1 ] = $arr[ $ii ] if ( $lnarr[ 3*$ii-1 ] > $arr[ $ii ] ); 
                $lnarr[ 3*$ii ] = $arr[ $ii ] if ( $lnarr[ 3*$ii ] < $arr[ $ii ] ); 
            }
        }
        $i++;
    }
}else{ 
    print join('', @lines);
}


sub sigFigs {
my($N,$n)=@_;
return 0 if( $N+0 == 0 );
    my $znak = ( $N < 0 )? -1 : 1;
    $N = $znak*$N;
    my $pow = 1;
    if( int( $N ) < 10000 ){ #multiply and round
        while( int( $pow*$N ) < 1000 ){ $pow *= 10; }
    }else{ #devide and round
        while( int( $N*$pow/10 ) > 1000 ){ $pow /= 10; }
    }
    $N = $znak*int( $N*$pow )/$pow;
return $N;
}

