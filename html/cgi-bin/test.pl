#!/usr/bin/perl
print "Content-type: text/html\n\n";

use strict;
use warnings;
use Data::Dumper;
use CGI qw(:standard Vars);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

my %FORM = Vars();
print Dumper( \%FORM );

open my $in,  '<',  "../logs/temperature";
while(my $ln = <$in> ){
	print "$ln\n";
}

