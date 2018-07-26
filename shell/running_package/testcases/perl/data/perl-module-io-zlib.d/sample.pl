#!/usr/bin/perl
 use IO::Zlib;
    $fh = new IO::Zlib;
    if ($fh->open("file.gz", "rb")) {
        print <$fh>;
        $fh->close;
    }
