package String::PodQuote;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(pod_quote);

sub pod_quote {
    my $opts = ref $_[0] eq 'HASH' ? shift : {};
    my $text = shift;

    $text =~ s{
                  (<|^[=\x09\x20])
          }{
              if ($1 eq '<') {
                  'E<lt>'
              } else {
                  'E<' . ord($1) . '>'
              }
    }egmx;
    $text;
}

1;

# ABSTRACT: Quote special characters that might be interpreted by a POD parser

=head1 SYNOPSIS

 use String::PodQuote qw(pod_quote);

 print pod_quote("Compare using Perl's <=> operator");

will output:

 Compare using Perl's E<lt>=> operator.

Another example:

 print pod_quote("=, an equal sign (=) at the beginning of string");

will output:

 E<61>, an equal sign (=) at the beginning of string


=head1 DESCRIPTION

If you want to put a piece of plaintext into a POD document to be displayed
as-is when rendered as POD, you will need to quote special characters that might
be interpreted by a POD parser. This module provides the L</pod_quote> routine
to do that.

(Alternatively, you can indent each line of the text so it will be rendered
verbatim in the POD).


=head1 FUNCTIONS

=head2 pod_quote

Usage:

 $quoted = pod_quote([ \%opts, ] $text);

Quote special characters that might be interpreted by a POD parser. Basically
the equivalent of L<HTML::Entities>'s C<encode_entities> when outputting to
HTML, or L<String::ShellQuote>'s C<shell_quote> when passing a string to shell.

Will do the following:

=over

=item * Escape "<" into EE<lt>ltE<gt>

=item * Escape "=" at the start of string or line into EE<lt>61<gt>

=item * Escape Space or Tab at the start of string or line into EE<lt>32E<gt> or EE<lt>9E<gt>, respectively.

=back

Caveats:

=over

=item * Newlines will not be rendered exactly; it will follow POD's rules

=back


=head1 SEE ALSO

L<perlpod>
