use strict;
use warnings;
use Data::Dumper;

my $grandlogfile = $ARGV[0];

    if ( -e $grandlogfile ){ # edit existing
	my $max = `wc -l $grandlogfile`;
	$max =~ s/\s+.*//;
	exit if ( $max < 3 );
        local $^I = "";       # Enable in-place editing.
        local @ARGV = ( $grandlogfile ); # Set files to operate on.
	$.=0;
	my $remembered;
	while (<>) {
	   if ( $. == $max-1 ){
		$remembered = $_;
	   }elsif( $. == $max ){ 
		print evenOut( $remembered, $_ );
		print; 
	   }else{ print; }
	}
    }

sub evenOut{
my( $d1str, $d2str ) = @_;
my @d1 = split /\s/, $d1str;
my $t1 = shift @d1;
my @d2 = split /\s/, $d2str;
shift @d2;
    for( my $i=0; $i<@d1; $i++){
	$d1[$i] = ( $d1[$i] + $d2[$i] )/2;
    }
return "$t1 ".join(" ", @d1)."\n";
}
