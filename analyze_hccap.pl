#!/usr/bin/env perl

# Author: philsmd
# License: public domain
# First released: January 2015

use strict;
use warnings;

# CONSTANTS

my $HCCAP_STRUCT_SIZE = 392;

if (scalar (@ARGV) < 1)
{
  print ("ERROR: Please specify the .hccap file\n");

  exit (1);
}

my $hccap_file = $ARGV[0];


my @filter = ();

if (scalar (@ARGV) > 1)
{
  my $filter_line = $ARGV[1];

  if ($filter_line !~ /^[0-9,]*$/ )
  {
    print ("ERROR: format of filter is incorrect, it must be a comma-separated list of numbers\n");

    exit (1);
  }

  @filter = split (',', $filter_line);
}

if (! open (HCCAP_FILE, $hccap_file))
{
  print ("ERROR: Could not open the .hccap file '$hccap_file'\n");

  exit (1);
}

binmode (HCCAP_FILE);

my $stop = 0;

my $struct_content = "";

my $count_printed  = 0;
my $count_total    = 1;

while (read (HCCAP_FILE, $struct_content, $HCCAP_STRUCT_SIZE))
{
  if (scalar (@filter) > 0)
  {
    my $found = 0;

    foreach my $num (@filter)
    {
      if ($num eq $count_total)
      {
        $found = 1;

        last;
      }
    }

    if (!$found)
    {
      $count_total++;

      next;
    }
  }

  print "\n" if ($count_printed > 0);

  my $essid  = substr ($struct_content,   0,  36);
  my $bssid  = substr ($struct_content,  36,   6);
  my $stmac  = substr ($struct_content,  42,   6);
  my $snonce = substr ($struct_content,  48,  32);
  my $anonce = substr ($struct_content,  80,  32);
  my $eapol  = substr ($struct_content, 112, 256);
  my $e_size = substr ($struct_content, 368,   4);
  my $keyver = substr ($struct_content, 372,   4);
  my $keymic = substr ($struct_content, 376,  16);

  print "HCCAP {\n";
  print "  essid: " . $essid . " (" . unpack ("H*", $essid) . ")\n";
  print "  MACS:\n";
  print "    bssid: "  . unpack ("H*", $bssid)  . "\n";
  print "    stmac: "  . unpack ("H*", $stmac)  . "\n";
  print "  NONCES:\n";
  print "    snonce: " . unpack ("H*", $snonce) . "\n";
  print "    anonce: " . unpack ("H*", $anonce) . "\n";
  print "  EAPOL:\n";
  print "    size: "   . unpack ("L*", $e_size) . "\n";
  print "    eapol: "  . unpack ("H*", $eapol)  . "\n";
  print "  keyver: "   . unpack ("L*", $keyver) . "\n";
  print "  keymic: "   . unpack ("H*", $keymic) . "\n";

  print "}\n";

  $count_total++;
  $count_printed++;
}

close (HCCAP_FILE);

exit (0);
