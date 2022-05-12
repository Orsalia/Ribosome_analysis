#!/bin/perl
#use warnings;
#use strict;

use Math::NumberCruncher;


my $inputfile=$ARGV[0];
#my $inputfile2=$ARGV[1];
#my $inputfile2=$ARGV[2];

open (INPUT_FILE,$inputfile);

#open (file2,">$inputfile2.mean.bed") or die "$!\n";
#open (file2,">$inputfile2.stdev.bed") or die "$!\n";


my %matrix1;
my %matrix2;
my %matrix3;

my @matrix1;
my @matrix2;
my @matrix3;

my @std;my @average;

my $temp1=0;
my $temp2=0;
my $temp3=0;

my $var1=0;
my $var2=0;
my $var3=0;
my $var4=0;
my $var5=0;
my $var6=0;
my $var7=1;
my $var8=1;
my $var9=1;
my $var10=0;my $var11=0;

my $var1b=1;
my $var2b=1;
my $var3b=1;
my $var4b=0;
my $var5b=0;
my $var6b=0;
my $var7b=0;
my $var8b=0;
my $var9b=0;
my $var10b=0;my $var11b=0;my $var12b=0;
my @sorted_words=0;my @codon=0;

my $max=0; 
my $max2=0;
my $Max3=0;

while(my $line1=<INPUT_FILE>)  
 {   chomp $line1;
     @{$matrix1{$temp1}}=split(/\t/,$line1);
     @matrix1=split(/\s/,${$matrix1{$temp1}}[6]);
     $var1=scalar(@matrix1);

  for (my $i=0; $i<=$var1; $i++)
   {  
     if ( $matrix1[$i] != 0 )
      {$matrix2[$var6]=$matrix1[$i];$var6++;
       $var2=$matrix1[$i]+$var2;}
   }
   
$std[$temp1]=Math::NumberCruncher::StandardDeviation(@matrix2);
$average[$temp1]=$var2/$var6;

}
#overal mean
$totalsmean=Math::NumberCruncher::Mean(@average);
$totalstdev=Math::NumberCruncher::StandardDeviation(@std);

print "$totalsmean\t$totalstdev\n";

###########################################OR alternative #####################################################
sub average{
        my($data) = @_;
        if (not @$data) {
                die("Empty arrayn");
        }
        my $total = 0;
        foreach (@$data) {
                $total += $_;
        }
        my $average = $total / @$data;
        return $average;
}
sub stdev{
        my($data) = @_;
        if(@$data == 1){
                return 0;
        }
        my $average = &average($data);
        my $sqtotal = 0;
        foreach(@$data) {
                $sqtotal += ($average-$_) ** 2;
        }
        my $std = ($sqtotal / (@$data-1)) ** 0.5;
        return $std;
}

