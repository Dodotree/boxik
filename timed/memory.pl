#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $data = `cat /proc/meminfo`;
$data =~ s/\skB\n/\n/g;
my %hash = split /\:\s*|\n/, $data;
my $usage_percent = 
    100*($hash{ 'MemTotal' } - $hash{ 'MemFree' })/$hash{ 'MemTotal' };
    $usage_percent = int( $usage_percent );
my $swap_percent = 
    100*($hash{ 'SwapTotal' } - $hash{ 'SwapFree' })/$hash{ 'SwapTotal' };
    $swap_percent = int( $swap_percent );


my $disk = `df /`;
my @arr = split /\s+/, $disk;
#print Dumper( @arr );
$arr[11] =~ s/[%]//;


print time()." $usage_percent $swap_percent $arr[11]\n";

