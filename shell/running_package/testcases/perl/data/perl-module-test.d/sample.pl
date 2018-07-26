#!/usr/bin/perl
 use strict;
  use Test;
  # use a BEGIN block so we print our plan before MyModule is loaded
  BEGIN { plan tests => 10, todo => [3,4] }
  # load your module...
  use IO;
  # Helpful notes.  All note-lines must start with a "#".
  print "# I'm testing IO\n";
  ok(0); # failure
  ok(1); # success
  ok(0); # ok, expected failure (see todo list, above)
  ok(1); # surprise success!
  ok(0,1);             # failure: '0' ne '1'
  ok('broke','fixed'); # failure: 'broke' ne 'fixed'
  ok('fixed','fixed'); # success: 'fixed' eq 'fixed'
  ok('fixed',qr/x/);   # success: 'fixed' =~ qr/x/
  ok(sub { 1+1 }, 2);  # success: '2' eq '2'
  ok(sub { 1+1 }, 3);  # failure: '2' ne '3'
