#!/usr/bin/perl
use Log::Message::Simple qw[msg error debug carp croak cluck confess];
use Log::Message::Simple qw[:STD :CARP];

### standard reporting functionality
msg("Function msg", 1);
