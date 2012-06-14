package Test::Time;
use strict;
use warnings;

use Test::More;

our $VERSION = '0.02';
our $time = CORE::time();

my $pkg = __PACKAGE__;
my $in_effect = 1;

sub in_effect {
	$in_effect;
}

sub import {
	my ($class, %opts) = @_;
	$time = $opts{time} if defined $opts{time};

	*CORE::GLOBAL::time = sub {
		if (in_effect) {
			$time;
		} else {
			CORE::time();
		}
	};

	*CORE::GLOBAL::sleep = sub {
		if (in_effect) {
			my $sleep = shift;
			$time += $sleep;
			note "sleep $sleep";
		} else {
			CORE::sleep(shift);
		}
	}
};

sub unimport {
	$in_effect = 0;
}

1;
__END__

=encoding utf8

=head1 NAME

Test::Time - Override time() and sleep() core function for tests.

=head1 SYNOPSIS

  use Test::Time; # just use

  time(); # fixed time

  sleep 1; # increment internal time (return immediately)
  time(); # incremented


=head1 DESCRIPTION

Test::Time is for tests around time. You just use this module and your tests are all "time safe".

=head1 AUTHOR

cho45 E<lt>cho45@lowreal.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
