package DateTime::Event::MultiCron;

use strict;
use warnings;

require Exporter;

use base 'DateTime::Event::Cron';

our $VERSION = '0.01.1';

sub from_multicron {
	my $class=shift;
	my $dts=undef;

	while (my $cron=shift) {
		my $dtc=$class->new($cron);
		my $tdts=$dtc->as_set();

		if ($dts) {
			$dts=$dts->union($tdts);
		} else {
			$dts=$tdts;
		}
	}
	return $dts;
}

1;
__END__
=head1 NAME

DateTime::Event::MultiCron - Extension for DateTime::Event::Cron that allows
multiple cron schedules for the same event.

=head1 SYNOPSIS

  use DateTime::Event::MultiCron;
  
	my $dts=DateTime::Event::MultiCron->from_multicron('*/5 * * * *','*/2 * * * 6');
	my $iter=$dts->iterator(after=>DateTime->now());
	while (1) {
		my $next = $iter->next;
		print $next->datetime,"\n";
	}

=head1 DESCRIPTION

This module is an extension to DateTime::Event::Cron. It only adds the method
L<from_multicron>.

=over 4

=item from_multicron

From multicron gets several schedule definition on the cron format, and 
returns a DateTime::Set for all that schedules. See example in the
L<SYNOPSIS>.

=back

=head1 SEE ALSO

  L<DateTime::Event::Cron>

=head1 AUTHOR

  Marco Neves, E<lt>neves@cpan.orgE<gt>
  http://www.magick-source.net/


=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Marco Neves

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
