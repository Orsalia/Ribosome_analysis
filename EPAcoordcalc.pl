#!/bin/perl
#use warnings;
#use strict;

my $inputfile=$ARGV[0];
my $inputfile2=$ARGV[1];

open (INPUT_FILE,$inputfile);

open (file2,">$inputfile2.E.bed") or die "$!\n";
open (file2c,">$inputfile2.P.bed") or die "$!\n";
open (file2b,">$inputfile2.A.bed") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;

my @matrix1;
my @matrix2;
my @matrix3;

my $temp1=0;
my $temp2=0;
my $temp3=0;
my $var1=0;
my $var2=0;
my $var3=0;
my $var4=0;
my $var5=0;


while(my $line1=<INPUT_FILE>)  
 {   chomp $line1;
     @{$matrix1{$temp1}}=split(/\t/,$line1);
          
     if (${$matrix1{$temp1}}[6]=~/\+/)
     {
   $var5=${$matrix1{$temp1}}[1]-1;$var5b=${$matrix1{$temp1}}[2]+1;
 print file2c "${$matrix1{$temp1}}[0]\t$var5\t$var5b\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";
        
     $var1=$var5-3;
     $var2=$var5+3;$var2b=$var5b+3;
     
     print file2b "${$matrix1{$temp1}}[0]\t$var5b\t$var2b\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";
     print file2 "${$matrix1{$temp1}}[0]\t$var1\t$var5\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";
     
      
     } 
     
     elsif (${$matrix1{$temp1}}[6]=~/\-/)
     {
     
$var5=${$matrix1{$temp1}}[1]-1;$var5b=${$matrix1{$temp1}}[2]+1;
  print file2c "${$matrix1{$temp1}}[0]\t$var5\t$var5b\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";     
    $var1=$var5-3;
     $var2=$var5+3;$var2b=$var5b+3;
     
     print file2b "${$matrix1{$temp1}}[0]\t$var1\t$var5\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";
     print file2 "${$matrix1{$temp1}}[0]\t$var5b\t$var2b\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[5]\t${$matrix1{$temp1}}[6]\n";
     
     } 
  }   
