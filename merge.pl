#!/bin/perl
#use warnings;
#use strict;

my $inputfile=$ARGV[0]; #transcript
my $inputfile2=$ARGV[1];

open (file2,">$inputfile2.bed") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;
my %matrix4;
my @matrix1;
my @matrix2;
my @matrix3;
my @matrix4;
my @matrix5;
my $var1=0;my $var=0;my $var1b=0;

my $var2=0;my $var2b=0;my $var2c=0;
my $var3=0;my $var3b=0;my $var3c=0;
my $var4=0;my $var4b=0;my $var4c=0;
my $var5=0;my $var5b=0;my $var5c=0;
my $var6=0;my $var6b=0;my $var6c=0;
my $var7=0;my $var7b=0;my $var7c=0;
my $var8=0;my $var8b=0;my $var8c=0;
my $var9=0;my $var9b=0;my $var9c=0;

my $var10=0;my $var10b=0;
my $var11=0;my $var11b=0;
my $var12=0;my $var12b=0;
my $var13=0;my $var13b=0;

my $score=0;
my $ncl1=0;my $ncl2=0;my $ncl3=0;
my $ncl1b=0;my $ncl2b=0;my $ncl3b=0;


open (INPUT_FILE,$inputfile);
while(my $line1=<INPUT_FILE>)
{     
      @{$matrix1{$var}}=split(/\t/,$line1);
      $var++;
}

 for (my $i=0; $i<=$var; $i++)
   {
     if (( ${$matrix1{$i-1}}[4] eq ${$matrix1{$i}}[4]))
       { 
       @{$matrix2{$var2}}=split(/\s+/,${$matrix1{$i-1}}[6]);
       $matrix1[$var2]=${$matrix1{$i-1}}[0];
       $matrix2[$var2]=${$matrix1{$i-1}}[1];
       $matrix3[$var2]=${$matrix1{$i-1}}[2];
       $matrix4[$var2]=${$matrix1{$i-1}}[4];
       $matrix5[$var2]=${$matrix1{$i-1}}[5];
       $signal=1;$var2++;
       }

    elsif ((${$matrix1{$i-1}}[4] ne ${$matrix1{$i}}[4])&&(${$matrix1{$i+1}}[4] eq ${$matrix1{$i}}[4])&&($signal==1))
       {
       @{$matrix2{$var2}}=split(/\s+/,${$matrix1{$i-1}}[6]);
       $matrix1[$var2]=${$matrix1{$i-1}}[0];
       $matrix2[$var2]=${$matrix1{$i-1}}[1];
       $matrix3[$var2]=${$matrix1{$i-1}}[2];
       $matrix4[$var2]=${$matrix1{$i-1}}[4];
       $matrix5[$var2]=${$matrix1{$i-1}}[5];
       print file2 "$matrix1[0]\t$matrix2[0]\t$matrix3[$var2]\t$matrix4[$var2]\t${$matrix1{$i-1}}[3]\t$matrix5[0]\t";
       for (my $j=0; $j<=$var2; $j++)
       {
        print file2 " @{$matrix2{$j}}";
       }
       #print file2 "\t";
       #for (my $j=0; $j<=$var2; $j++)
       #{
       # print file2 "@{$matrix3{$j}} ";
       #}
      print file2 "\n";  
      $signal=0; undef %matrix2;undef %matrix3;$var2=0;undef @matrix3;undef @matrix1;undef @matrix2;undef @matrix3;undef @matrix4;undef @matrix5;
      }  
    
    elsif ((${$matrix1{$i-1}}[4] ne ${$matrix1{$i}}[4])&&(${$matrix1{$i+1}}[4] ne ${$matrix1{$i}}[4])&&($signal==1))
     {
       @{$matrix2{$var2}}=split(/\s+/,${$matrix1{$i-1}}[6]);
       $matrix1[$var2]=${$matrix1{$i-1}}[0];
       $matrix2[$var2]=${$matrix1{$i-1}}[1];
       $matrix3[$var2]=${$matrix1{$i-1}}[2];
       $matrix4[$var2]=${$matrix1{$i-1}}[4];
       $matrix5[$var2]=${$matrix1{$i-1}}[5];
       print file2 "$matrix1[0]\t$matrix2[0]\t$matrix3[$var2]\t${$matrix1{$i-1}}[4]\t${$matrix1{$i-1}}[3]\t${$matrix1{$i-1}}[5]\t";
       for (my $j=0; $j<=$var2; $j++)
       {
        print file2 " @{$matrix2{$j}}";
       }
       #print file2 "\t";
       #for (my $j=0; $j<=$var2; $j++)
       #{
       # print file2 "@{$matrix3{$j}} ";
       #}
      print file2 "\n";  
      print file2 "${$matrix1{$i}}[0]\t${$matrix1{$i}}[1]\t${$matrix1{$i}}[2]\t${$matrix1{$i}}[4]\t${$matrix1{$i}}[3]\t${$matrix1{$i}}[5]\t${$matrix1{$i}}[6]\n";
      $signal=0; undef %matrix2;undef %matrix3;$var2=0;undef @matrix3;undef @matrix1;undef @matrix2;undef @matrix3;undef @matrix4;undef @matrix5;
      }  
      
      #else
      #{print file2 "${$matrix1{$i}}[0]\t${$matrix1{$i}}[1]\t${$matrix1{$i}}[2]\t${$matrix1{$i}}[4]\t${$matrix1{$i}}[3]\t${$matrix1{$i}}[5]\t${$matrix1{$i}}[6]\n";
      #$signal=0; undef %matrix2;undef %matrix3;$var2=0;undef @matrix3;undef @matrix1;undef @matrix2;undef @matrix3;undef @matrix4;undef @matrix5;}
   }

close(file2);

