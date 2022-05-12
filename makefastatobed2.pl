#!/bin/perl
#use warnings;
#use strict;

my $inputfile=$ARGV[0]; #transcript
my $inputfile2=$ARGV[1];

open (file2,">$inputfile2.bed") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;
my @matrixtest1;
my @matrixtest2;
my @matrixtest3;
my $var1=0;my $var=0;my $var1b=0;
my $var1b=0;
my $var2=0;my $var3=0;$var4=0;

open (INPUT_FILE,$inputfile);
while(my $line1=<INPUT_FILE>)
{     
      @{$matrix1{$var1}}=split(/\s/,$line1);

     if ((${$matrix1{$var1}}[0] =~/(chr\d{1,2})\:(\d{1,10})\-(\d{1,10})\((\+)\)/)||(${$matrix1{$var1}}[0] =~/(chr\d{1,2})\:(\d{1,10})\-(\d{1,10})\((\-)\)/)||(${$matrix1{$var1}}[0] =~/(chrX)\:(\d{1,10})\-(\d{1,10})\((\+)\)/)||(${$matrix1{$var1}}[0] =~/(chrX)\:(\d{1,10})\-(\d{1,10})\((\-)\)/)||(${$matrix1{$var1}}[0] =~/(chrY)\:(\d{1,10})\-(\d{1,10})\((\+)\)/)||(${$matrix1{$var1}}[0] =~/(chrY)\:(\d{1,10})\-(\d{1,10})\((\-)\)/)||(${$matrix1{$var1}}[0] =~/(chrM)\:(\d{1,10})\-(\d{1,10})\((\+)\)/)||(${$matrix1{$var1}}[0] =~/(chrM)\:(\d{1,10})\-(\d{1,10})\((\-)\)/))
     { $var1b=$1; $var2=$2; $var3=$3; $var4=$4; }

   print file2 "$var1b\t$var2\t$var3\t${$matrix1{$var1}}[1]\t0\t$var4\n";
} 
