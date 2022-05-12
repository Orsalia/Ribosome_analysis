#!/bin/perl
#use warnings;
#use strict;

use Math::NumberCruncher;


my $inputfile=$ARGV[0];
my $inputfile2=$ARGV[1];
my $inputfile2=$ARGV[2];
my $inputfile3=$ARGV[3]; #median
my $inputfile4=$ARGV[4]; #stdiv
open (INPUT_FILE,$inputfile);

open (file2,">$inputfile2.stall.bed") or die "$!\n";
#open (file2b,">$inputfile2.A.bed") or die "$!\n";
#open (file2c,">$inputfile2.E.bed") or die "$!\n";


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
   
   # for (my $i=0; $i<=$var1; $i=$i+3)
   #{  
     
   #} 
   

  #for (my $i=0; $i<=$var6; $i++)
   #{  
     # if ( $max<=$matrix2[$i] )
       #{ $max=$matrix2[$i]; $holdmax=$i;}
   #}

  #for (my $i=0; $i<=$var6; $i++)  
   #{  
     # if (( $max2<=$matrix2[$i] ) && ($matrix2!=$max))
      # { $max2=$matrix2[$i]; $holdmax2=$i;}
  # }

  #for (my $i=0; $i<=$var6; $i++)  
   #{  
      #if (( $max3<=$matrix2[$i] ) && ($matrix2!=$max2)&&($matrix2!=$max))
      # { $max3=$matrix2[$i]; $holdmax3=$i;}
   #}
      
     #print "@matrix2\n";  
   
     @sorted_words = sort { $a <=> $b }@matrix2;
     $var1b=$sorted_words[$var6-1]; 
     $var2b=$sorted_words[$var6-2];
     $var3b=$sorted_words[$var6-3];

     if ( $var6!=0)
      {$var3=$var2/$var6;}

     #my $std=Math::NumberCruncher::StandardDeviation(@matrix2);
     my $thres=2*$inputfile4+$inputfile3;
   
  for (my $i=0; $i<=$var1; $i++)
   {  
      if (( $matrix1[$i] == 0 )&&($var3==0))
       { }
      elsif (( $matrix1[$i] > 0 )&&($var3>0))
       { $var4=$matrix1[$i]/$var3;
          if (( $matrix1[$i] > $thres))
            {  $var5=(${$matrix1{$temp1}}[1]+($i));
               $var12b=$i;
               #####################################################################################################define stalling in an area 0f +-10 nts
               $var8=$matrix1[$i-1];$var9=$matrix1[$i+1]; $var8b=$matrix1[$i-2];$var9b=$matrix1[$i+2];
               $var13b=$matrix1[$i-3];$var14b=$matrix1[$i-4]; $var15b=$matrix1[$i-5];$var16b=$matrix1[$i-6];$var17b=$matrix1[$i-7];
               $var18b=$matrix1[$i+3];$var19b=$matrix1[$i+4]; $var20b=$matrix1[$i+5];$var21b=$matrix1[$i+6];$var22b=$matrix1[$i+7];$var23b=$matrix1[$i+8];
               #@codon=split(//,${$matrix1{$temp1}}[13]);
               $var14b=scalar(@codon);
                if ($var8>0)
                {$var10=$matrix1[$i]/$var8;} 
                elsif ($var8=0)
                {$var10=$matrix1[$i];} 
                
                 if ($var8b>0)
                {$var10b=$matrix1[$i]/$var8b;} 
                elsif ($var8b=0)
                {$var10b=$matrix1[$i];}  

               if ($var9>0)
               {$var11=$matrix1[$i]/$var9;}
               elsif ($var9=0)
                {$var11=$matrix1[$i];}   

                if ($var9b>0)
               {$var11b=$matrix1[$i]/$var9b;}
               elsif ($var9b=0)
                {$var11b=$matrix1[$i];} 
 
               if ($var1b>0)
               {$var4b=$matrix1[$i]/$var1b;}
               elsif ($var1b=0) 
               {$var4b=$matrix1[$i];}
 
               if ($var2b>0)
               {$var5b=$matrix1[$i]/$var2b;}
               elsif ($var2b=0) 
               {$var5b=$matrix1[$i];}

               if ($var3b>0) 
               {$var6b=$matrix1[$i]/$var3b;}
               elsif ($var3b=0) 
               {$var6b=$matrix1[$i];}

            if (( $var10>=2) && ($var11>=2) && (($var4b==1)||($var4b>=2)) && (($var5b==1)||($var4b>=2)) && (($var6b==1)||($var6b>=2)) && (($var8 ne $var1b )||($var8 ne $var2b )||($var8 ne $var3b )) && (($var9 ne $var1b )||($var9 ne $var2b )||($var9 ne $var3b )) )
              {
              
     $var13b=($var12b*2+($var12b-1));         
              
              print file2 "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var17b\t$var16b\t$var15b\t$var14b\t$var13b\t$var8b\t$var8\t$matrix1[$i]\t$var9\t$var9b\t$var18b\t$var19b\t$var20b\t$var21b\t$var22b\t$var23b\n";
              
              #print file2b "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b+1]\t$codon[$var12b+2]\t$codon[$var12b+3]\n";
              
              #print file2c "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b-5]\t$codon[$var12b-4]\t$codon[$var12b-3]\n";
              
              }
           elsif (( $var10>=1) && ($var11>=1) && ((($var8 eq $var1b)||($var8 eq $var2b)||($var8 eq $var3b))||(($var9 eq $var1b)||($var9 eq $var2b)||($var9 eq $var3b))) ) 
              {
  #$var13b=($var12b*2+($var12b-1));             
              print file2 "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var17b\t$var16b\t$var15b\t$var14b\t$var13b\t$var8b\t$var8\t$matrix1[$i]\t$var9\t$var9b\t$var18b\t$var19b\t$var20b\t$var21b\t$var22b\t$var23b\n";
              
             # print file2b "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b+1]\t$codon[$var12b+2]\t$codon[$var12b+3]\n";
              
              #print file2c "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b-5]\t$codon[$var12b-4]\t$codon[$var12b-3]\n";
              }

           elsif (( $var10>=1) && ($var10b>=1) && ((($var8 eq $var1b)||($var8 eq $var2b)||($var8 eq $var3b))||(($var8b eq $var1b)||($var8b eq $var2b)||($var8b eq $var3b))) ) 
              {
   #$var13b=($var12b*2+($var12b-1));            
              print file2 "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var17b\t$var16b\t$var15b\t$var14b\t$var13b\t$var8b\t$var8\t$matrix1[$i]\t$var9\t$var9b\t$var18b\t$var19b\t$var20b\t$var21b\t$var22b\t$var23b\n";
              
             # print file2b "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b+1]\t$codon[$var12b+2]\t$codon[$var12b+3]\n";
              
              #print file2c "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b-5]\t$codon[$var12b-4]\t$codon[$var12b-3]\n";
              }  
           elsif (( $var11>=1) && ($var11b>=1) && ((($var9 eq $var1b)||($var9 eq $var2b)||($var9 eq $var3b))||(($var9b eq $var1b)||($var9b eq $var2b)||($var9b eq $var3b))) ) 
              {
  #$var13b=($var12b*2+($var12b-1));             
              print file2 "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var17b\t$var16b\t$var15b\t$var14b\t$var13b\t$var8b\t$var8\t$matrix1[$i]\t$var9\t$var9b\t$var18b\t$var19b\t$var20b\t$var21b\t$var22b\t$var23b\n";
              
             # print file2b "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b+1]\t$codon[$var12b+2]\t$codon[$var12b+3]\n";
              
             # print file2c "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[3]\t${$matrix1{$temp1}}[4]\t${$matrix1{$temp1}}[5]\t$i\t$matrix1[$i]\t$var4\t$var3\t${$matrix1{$temp1}}[6]\t${$matrix1{$temp1}}[13]\t$var12b\t$codon[$var12b-5]\t$codon[$var12b-4]\t$codon[$var12b-3]\n";
              } 

            }
         }
     }
       $var2=0;$var3=0;$var4=0;$var5=0;$var6=0;$var7=0;$var8=1;$var9=1;$var10=0;$var11=0;$var4b=0;$var5b=0;$var1b=1;$var2b=1;$var3b=1;$var12b=0;undef @sorted_words;undef @matrix2;undef @codon;$var13b=0;$var17b=0;$var16b=0;$var15b=0;$var14b=0;$var13b=0;$var8b=0;$var8=0;$var9=0;$var9b=0;$var18b=0;$var19b=0;$var20b=0;$var21b=0;$var22b=0;$var23b=0;
  }


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
