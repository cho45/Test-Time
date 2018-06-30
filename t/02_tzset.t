use strict;
use warnings;
use Test::More;
use POSIX qw( tzset );
use Test::Time time => 1;

$ENV{TZ} = 'Europe/London';
eval { tzset(); };
plan skip_all => $@ if ( $@ =~ /not implemented on this architecture/ );

is scalar( localtime() ), "Thu Jan  1 01:00:01 1970",
    "localtime() in scalar context correct";

my @localtime = localtime();
is_deeply \@localtime, [ 1, 0, 1, 1, 0, 70, 4, 0, 0 ],
    "localtime() in list context correct";

is scalar( localtime(100) ), "Thu Jan  1 01:01:40 1970",
    "localtime() in scalar context with argument correct";

@localtime = localtime(100);
is_deeply \@localtime, [ 40, 1, 1, 1, 0, 70, 4, 0, 0 ],
    "localtime() in list context with argument correct";

Test::Time->unimport();

isnt time(), 1, "removed overwritten time()";
isnt scalar( localtime() ), "Thu Jan  1 01:00:01 1970", "removed overwritten localtime()";

done_testing;
