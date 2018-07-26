#!/usr/bin/perl
use Archive::Tar;
my $tar = Archive::Tar->new;

$tar->read('dir.tgz');
$tar->extract();
