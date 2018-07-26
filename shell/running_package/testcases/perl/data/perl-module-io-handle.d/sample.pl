#!/usr/bin/perl
 use IO::Handle;
    $io = IO::Handle->new();
    if ($io->fdopen(fileno(STDOUT),"w")) {
        $io->print("Some text\n");
    }
$io = IO::Handle->new();
    if ($io->fdopen(fileno(STDIN),"r")) {
        print $io->getline;
        $io->close;
    }
