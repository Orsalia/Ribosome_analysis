#!/bin/perl
#use warnings;
#use strict;

my $inputfile=$ARGV[0]; #transcript
my $inputfile2=$ARGV[1];

open (file2,">$inputfile2.bed") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;
my $var1=0;my $var2=0;my $var3=0;my $var=0;
my @matrix1;

open (INPUT_FILE,$inputfile);
while(my $line1=<INPUT_FILE>)
{     chomp $line1;
      @{$matrix1{$var}}=split(/\t/,$line1);
      @matrix1=split(/\s+/,${$matrix1{$var}}[6]);
      $var2=scalar(@matrix1);
      
      for (my $i=0; $i<=$var2; $i++)
      {
      $var3=$matrix1[$i]+$var3;
      }
      
      
 if ($var3>=10 )
     { 
      
    print file2 "${$matrix1{$var}}[0]\t${$matrix1{$var}}[1]\t${$matrix1{$var}}[2]\t${$matrix1{$var}}[3]\t${$matrix1{$var}}[4]\t${$matrix1{$var}}[5]\t${$matrix1{$var}}[6]\n";    
     }
     
     $var3=0; $var2=0;
 }    

