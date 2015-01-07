#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $data = int(`ps ax|wc -l`);
$data = time()." $data\n";
print $data;
