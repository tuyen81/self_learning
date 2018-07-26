#!/usr/bin/perl
       use Digest::SHA qw(sha256_hex);

        $data = "hello world";
        @frags = split(//, $data);

        # all-at-once (Functional style)
        $digest1 = sha256_hex($data);

        # in-stages (OOP style)
        $state = Digest::SHA->new(256);
        for (@frags) { $state->add($_) }
        $digest2 = $state->hexdigest;

        print $digest1 eq $digest2 ?
                "same!\n" : "oops!\n";
	print $digest1
