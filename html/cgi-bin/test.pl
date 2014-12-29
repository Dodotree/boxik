#!/usr/bin/perl
print "Content-type: text/html\n\n";
open my $in,  '<',  "../logs/temperature";
while(my $ln = <$in> ){
	print "$ln\n";
}

print "There";
