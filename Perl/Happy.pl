# Happy number project
use strict;
use warnings;
use diagnostics;
use List::Util qw(sum);
use Math::Complex;


# Check if a number is happy 
# Reference: "rosettacode.org"
sub ishappy {
  my $s = shift;
  while ($s > 6 && $s != 89) {
    $s = sum(map { $_**2 } split(//,$s));
  }
  return $s == 1;
}

# Get the norm of a happy number
sub getnorm {
  my $n = shift;
  my $norm = $n**2;
  while ($n != 1) {
    $n = (sum(map { $_**2 } split(//,$n)));
    $norm += $n**2;
  }
  $norm = sqrt($norm);
  return $norm;
}

# Find happy numbers in a given range (inclusive) and print them in descending order of norms 
sub happy_numbers_in_range {
  my ($n1, $n2) = (shift, shift);
  # Using a hash to store happy numbers and norms as key-value pairs
  my %numpairs;
  for (my $i = $n1; $i<=$n2; $i++) {
    if (ishappy($i)) {
      $numpairs{$i} = getnorm($i);
    }
  }
  my $size = keys %numpairs;
  if ($size == 0) {
    print "NOBODY'S HAPPY!\n";
  } else {   
    my $j = 1; 
    # Sort the keys of the hash according to the values (hash keys are strings)
    # Reference: "https://www.geeksforgeeks.org/sorting-hash-in-perl/"
    foreach my $num (reverse sort {$numpairs{$a} <=> $numpairs{$b}} keys %numpairs) {
      print "$num\n";
      $j++;
      if ($j>10) {
        last;
      }
    }
  }
  print "\n"; 
}

# Check validity of input arguments before passing them on 
sub checkargs {
  my ($n1, $n2) = (shift, shift);
  if ($n1==$n2 || $n1<0 || $n2<0) {
    print "\nInvalid range and/or arguments!\nExiting...\n\n";
    return;
  }
  print "\nFirst Argument: $n1";
  print "\nSecond Argument: $n2\n";
  if ($n1 > $n2){
    ($n1, $n2) = ($n2, $n1);
  }
  happy_numbers_in_range($n1, $n2);
}

# Get an input and return it if it is an integer
# Reference: "https://www.oreilly.com/library/view/perl-cookbook/1565922433/ch02s02.html"
sub getinp {
  my $inp = <>;
  chomp($inp);
  if ($inp =~ /^[+-]?\d+$/) { 
    if ($inp>0) {
      return abs($inp);
    } else {
      return $inp;
    }
  } else { 
    print "\nInvalid range and/or arguments!\nExiting...\n\n";
    exit;
  } 
}


print "\nEnter first argument (a whole number): ";
my $a1 = getinp();
print "Enter second argument (another whole number): ";
my $a2 = getinp();
checkargs($a1, $a2);







