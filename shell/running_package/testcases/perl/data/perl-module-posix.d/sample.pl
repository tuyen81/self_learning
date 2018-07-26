#!/usr/bin/perl
 use POSIX ();
$fd = POSIX::creat( "file", 0644 );
	POSIX::close( $fd );
$time_t = POSIX::mktime( 22, 30, 16, 45, 5, 116 );
	print "Date = ", POSIX::ctime($time_t);
