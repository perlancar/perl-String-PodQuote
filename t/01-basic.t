#!perl

use 5.010001;
use strict;
use warnings;
use Test::More 0.98;

use String::PodQuote qw(pod_quote);

is(pod_quote("Perl's <=> and < operators"), "Perl's E<lt>=> and E<lt> operators");
is(pod_quote("E<lt> and C<< foo >>"), "EE<lt>lt> and CE<lt>E<lt> foo >>");

is(pod_quote("=foo"), "E<61>foo");
is(pod_quote("bar =foo"), "bar =foo");
is(pod_quote("\n=foo"), "\nE<61>foo");
is(pod_quote("\n\n=foo"), "\n\nE<61>foo");

is(pod_quote(" foo"), "E<32>foo");
is(pod_quote("\n foo"), "\nE<32>foo");
is(pod_quote("\n\n foo"), "\n\nE<32>foo");

is(pod_quote("\tfoo"), "E<9>foo");
is(pod_quote("\n\tfoo"), "\nE<9>foo");
is(pod_quote("\n\n\tfoo"), "\n\nE<9>foo");
is(pod_quote("bar\tfoo"), "bar\tfoo");

done_testing;
