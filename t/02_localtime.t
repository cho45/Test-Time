use strict;
use warnings;
use Test::More;
use Test::Time time => 1;

use POSIX qw( tzset );

eval {
    # might die here with "POSIX::tzset not implemented on this architecture."
    POSIX::tzset;

    die q!tzset is implemented on this Cygwin. But Windows can't change tz inside script!
        if $^O eq 'cygwin';
    die q!tzset is implemented on this Windows. But Windows can't change tz inside script!
        if $^O eq 'MSWin32';
};
if ($@) {
    plan skip_all => $@;
}

$ENV{TZ} = 'Europe/London';
tzset();

is time(), 1, 'initial time taken from use line';

is scalar( localtime() ), "Thu Jan  1 01:00:01 1970",
    "localtime() in scalar context correct";

CORE::sleep(1);
is scalar( localtime() ), "Thu Jan  1 01:00:01 1970",
    "apparent localtime() unchanged after changes in real time";

sleep 1;
is scalar( localtime() ), "Thu Jan  1 01:00:02 1970",
    "apparent localtime() updated after sleep";

my @localtime = localtime();
is_deeply \@localtime, [ 2, 0, 1, 1, 0, 70, 4, 0, 0 ],
    "localtime() in list context correct";

is scalar( localtime(100) ), "Thu Jan  1 01:01:40 1970",
    "localtime() in scalar context with argument correct";

@localtime = localtime(100);
is_deeply \@localtime, [ 40, 1, 1, 1, 0, 70, 4, 0, 0 ],
    "localtime() in list context with argument correct";

Test::Time->unimport();

isnt scalar( localtime() ), "Thu Jan  1 01:00:02 1970", "removed overwritten localtime()";

done_testing;
