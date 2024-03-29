[![Actions Status](https://github.com/cho45/Test-Time/actions/workflows/test.yml/badge.svg)](https://github.com/cho45/Test-Time/actions)
# NAME

Test::Time - Overrides the time() and sleep() core functions for testing

# SYNOPSIS

    use Test::Time;

    # Freeze time
    my $now = time();

    # Increment internal time (returns immediately)
    sleep 1;

    # Return internal time incremented by 1
    my $then = time();

# DESCRIPTION

Test::Time can be used to test modules that deal with time. Once you `use` this
module, all references to `time`, `localtime` and `sleep` will be internalized.
You can set custom time by passing time => number after the `use` statement:

    use Test::Time time => 1;

    my $now = time;    # $now is equal to 1
    sleep 300;         # returns immediately, displaying a note
    my $then = time;   # $then equals to 301

# AUTHOR

cho45 <cho45@lowreal.net>

# SEE ALSO

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
