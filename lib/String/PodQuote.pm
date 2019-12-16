package String::PodQuote;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict 'subs', 'vars';
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(pod_escape pod_quote);

our %transforms = (
    "<"  => "E<lt>",
    ">"  => "E<gt>",
    " "  => "E<32>",
    "\t" => "E<9>",
    "="  => "E<61>",
    "/"  => "E<sol>",
    "|"  => "E<verbar>",
);

sub pod_escape {
    my $opts = ref $_[0] eq 'HASH' ? shift : {};
    my $text = shift;

    $text =~ s{
                  ((?<=[A-Z])<|>|/|\||^[=\x09\x20])
          }{
              $transforms{$1}
    }egmx;
    $text;
}

*pod_quote = \&pod_escape;

1;

# ABSTRACT: Escape/quote special characters that might be interpreted by a POD parser

=head1 SYNOPSIS

 use String::PodQuote qw(pod_escape);

Putting a text as-is in an ordinary paragraph:

 print "=pod\n\n", pod_escape("First paragraph containing C<=>.\n\n   Second indented paragraph.\n\n"), "=cut\n\n";

will output:

 =pod

 First paragraph containing CE<lt>=E<gt>.

 E<32>  Second indented paragraph.

Putting text inside a POD link:

 print "L<", pod_escape("Some description containing <, >, |, /"), "|Some::Module>";

will output:

 L<Some description containing E<lt>, E<gt>, E<verbar>, E<sol>|Some::Module>


=head1 DESCRIPTION


=head1 FUNCTIONS

=head2 pod_escape

Usage:

 $escaped = pod_escape($text);

Quote special characters that might be interpreted by a POD parser.

The following characters are escaped:

 Character                                    Escaped into
 ---------                                    ------------
 < (only when preceded by a capital letter)   E<lt>
 >                                            E<gt>
 |                                            E<verbar>
 /                                            E<sol>
 (Space) (only at beginning of string/line)   E<32>
 (Tab) (only at beginning of string/line)     E<9>
 = (only at beginning of string/line)         E<61>

=head2 pod_quote

Alias for L<pod_escape>.


=head1 SEE ALSO

L<perlpod>

Tangentially related modules: L<HTML::Entities>, L<URI::Escape>,
L<String::ShellQuote>, L<String::Escape>, L<String::PerlQuote>.
