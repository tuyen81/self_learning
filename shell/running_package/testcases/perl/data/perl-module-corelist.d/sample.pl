#!/usr/bin/perl
use Module::CoreList;
 print join ', ',Module::CoreList->find_modules(qr/test::h.*::.*s/i) ;
