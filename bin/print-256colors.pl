#!/usr/bin/perl

print "256 colors\n";
$fgbg=48;
for ($color = 0; $color < 256;) {
  if ($color < 16) {
    $n = 8;
  } elsif ($color < 232) {
    $n = 6;
  } elsif ($color < 256) {
    $n = 8;
  }
  for ($i = 0; $i < $n; $i++, $color++) {
    printf("\x1b[${fgbg};5;${color}m  %03d  \x1b[0m ",$color);
  }
  printf("\n");
}

