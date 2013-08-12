#!/usr/bin/perl

use utf8; 
use Encode;
use LWP::Simple;
# use warnings;
use open ":encoding(utf8)", ":std";
use Encode qw/encode/;

($input_file) = $ARGV[0];
($output_file) = $ARGV[1];

open URL, "<:utf8", $input_file or die $!;
open OUT, ">:utf8", $output_file or die $!;

while (<URL>)
{
  
  $a= &encode_utf_8;
  $a =~ s/_/|/g;
  $a =~ s/^.*?\|//g;
  $a =~ s/ .*?\|/ /g;
  
  print OUT $a;

}
close(URL);
close(URL);

sub encode_utf_8 {
    # my $string = @_;
  my $string = $_;
 
    my $utf8_encoded = '';
    eval {
        $utf8_encoded = Encode::encode('UTF-8', $string, Encode::FB_CROAK);
    };
    if ($@) {
        # sanitize malformed UTF-8
        $utf8_encoded = '';
        my @chars = split(//, $string);
        foreach my $char (@chars) {
            my $utf_8_char = eval { Encode::encode('UTF-8', $char, Encode::FB_CROAK) }
                or next;
            $utf8_encoded .= $utf_8_char;
        }
    }
    return $utf8_encoded;
}

print "Done!";
