#!/usr/bin/perl
   use IPC::Cmd qw[can_run run run_forked];
    my $full_path = can_run('wget') or warn 'wget is not installed!';
    ### commands can be arrayrefs or strings ###
    my $cmd = "$full_path -b theregister.co.uk";
    my $cmd = [$full_path, '-b', 'theregister.co.uk'];
    ### in scalar context ###
    my $buffer;
    if( scalar run( command => $cmd,
                    verbose => 0,
                    buffer  => \$buffer,
                    timeout => 20 )
    ) {
        print "fetched webpage successfully: $buffer\n";
    }
