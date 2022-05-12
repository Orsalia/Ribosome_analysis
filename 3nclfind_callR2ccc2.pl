#!/bin/perl
#use warnings;
#use strict;
#use Statistics::Basic::StdDev;

my $inputfile=$ARGV[0];
my $inputfile2=$ARGV[1];
my $inputfile3=$ARGV[2];
my $inputfile4=$ARGV[3];
#my $inputfile5=$ARGV[4];

open (file2,">$inputfile2.txt") or die "$!\n";
open (file2b,">$inputfile3.txt") or die "$!\n";
open (file2c,">$inputfile4.txt") or die "$!\n";
#open (file2d,">$inputfile5.txt") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;my %matrix3;

my $temp1=0;
my $temp2=0;
my $temp3=0;

my %matrix4;
my %matrix5;

my @matrix1=0;my @matrix2=0;

my $temp1=0;
my $temp2=0;
my $temp3=0;

my $temp4=0;my $temp5=0;my $temp4b=0;my $frequency=0; 
my @frequency=0;my $density=0;my @density=0;my @density2=0;my @density3=0;my @density4=0;my @density5=0;
my $cntf=0;my $highest=0;my $cntf2=0;my $cntf3=0;my $cntf4=0;
my $index1=0;my $var2=0;my $varmean=0;
my $index2=0;
my $iter=0;my $signal33=0;
my $sum=0;my $mean=0;my $multiframes=0;my $frequency3=0;my $sum=0;my $pvalue=0;

my $frequency1=0;my $frequency2=0;my $frequency3=0;
open (INPUT_FILE,$inputfile);
while(my $line1=<INPUT_FILE>)  
 {   

EXIT_IF: {
$temp5=0;undef %matrix2;undef @frequency; undef @density; undef @density2; undef @density3;undef @density4;undef @density5;$temp4b=0; $stddev=0; $temp4=0; $twostddev=0; $cntf=0; $highest=0; $frequency=0; $density=0; $sum=0;$twostddev=0;$std_dev=0;$average=0;undef %matrix4;undef %matrix5;$std_dev3=0;$average3=0;$cntf2=0;$std_dev4=0;$average4=0;$cntf3=0;$std_dev5=0;$average5=0;$cntf5=0;$cntf4=0;$multiframes=0;$pvalue=1;$sum=0;$multiframes=0;$var2=0;$varmean=0;
$frequency1=0;$frequency2=0;$frequency3=0;
################################################################
  #system("rm $inputfile2.txt"); 

#system("rm MyData1.csv"); system("rm MyData2.csv"); system("rm MyData1c.csv"); system("rm MyData2c.csv");

######parse the Psite tables 
     chomp $line1;
     @{$matrix1{$temp1}}=split(/\t/,$line1);
   
     @{$matrix2{$temp1}}=split(/\s/,${$matrix1{$temp1}}[6]);

     $temp2=scalar(@{$matrix2{$temp1}});

     for (my $i=0; $i<=$temp2; $i++)
   { if (${$matrix2{$temp1}}[$i]>=1)
      {$var2++;}
      } 
     
     $varmean=$temp2/3;#print "$temp2\n";

 if ($var2>=10) 
    {
#system ("tail -n +2 'test3ncl.txt' > 'test3ncl.tmp' && mv 'test3ncl.tmp' 'test3ncl.txt'");

print file2 "dat<-c(";
###create a file with the Psite so R can take
     for (my $i=0; $i<$temp2; $i++)
       { 
   print file2 "@{$matrix2{$temp1}}[$i]\,";
       }

   print file2 "0)\n";

#### call R 
#system ("sed 's/00/0/' test3ncl.txt > test3ncl2.txt");
#system ("mv test3ncl.txt test3ncl2.txt");

system ("cat test3ncl.txt multitaper_spec_functions2cc.R > multitaper_spec_functions2cd.R");

#system ("sed 's/00/0/' test3ncl.txt > test3ncl2.txt");

my $base = "/stress_OIS/Sen_S/";
chomp $base;
my $r_script= "multitaper_spec_functions2cd.R";
my $path="$base/$r_script";

save_R_env();

sub save_R_env {
    my $execute = `Rscript $path`;
    print $? if $?;
    print $execute,"\n";
               }
#die;#####################################################3
#@i will add here before i erase the files a subroutine that spots the frames shifts more than one signif peak of a certain mean and check if any are around 0.33

system ("sed 1d MyData1.csv > MyData1c.csv");
system ("sed 1d MyData2.csv > MyData2c.csv");

open (my $fh, '<MyData1c.csv')  or die "$!\n";
if ( $fh eq "" )
{
    last EXIT_IF; 
}

else

{

open (my $fh, '<MyData1c.csv')  or die "$!\n";
while(my $line2=<$fh>) 
 { 
   
   chomp $line2;
   @matrix1=split(/\,/,$line2);
   if ( $matrix1[0] =~/\"(\d{1,6})\"/)
      { $index1=$1;}
   @{$matrix4{$index1}}=split(/\,/,$line2); ###STORE IT IN A HASH 
   $temp5++; #SHOW SIZE OF MATRIX
 } 

open (my $fh2, '<MyData2c.csv')  or die "$!\n";
while(my $line3=<$fh2>) 
{ chomp $line3;
   @matrix2=split(/\,/,$line3);
  if ( $matrix2[0] =~/\"(\d{1,6})\"/)
      { $index2=$1;} 
   @{$matrix5{$index2}}=split(/\,/,$line3);###STORE IT IN A HASH id COLUMN 1 SAME FOR 
}

### find the maximum density
  $highest = max(%matrix5); 
  $temp4=${$matrix4{$highest}}[1]; ### store THE HIGHEST FREQ
  $temp4b=${$matrix5{$highest}}[1];### store THE HIGHEST density

for (my $i=0; $i<$temp5; $i++)
   { $density2[$i]=${$matrix5{$i}}[1]; 
    }

for (my $i=0; $i<$temp5; $i++)
 { $sum=${$matrix5{$i}}[1]+$sum; 
    }

 

#for (my $i=0; $i<$temp5; $i++)
  #{ $sum=$sum+$matrix5{$i}[1];}

#$mean=$sum/$temp5;

my $average = average(@density2);
my $std_dev = std_dev($average, @density2);


#my $stddev = average(@density2);
my $twostddev = 2*$std_dev;

for (my $i=0; $i<$temp5; $i++)
{
 if ($density2[$i]>=$twostddev)
 { $frequency[$cntf]=${$matrix4{$i}}[1]; $density[$cntf]=${$matrix5{$i}}[1]; $cntf++;}
  if ((${$matrix4{$i}}[1]>=0.3)&&(${$matrix4{$i}}[1]<=0.35))
    {   $density3[$cntf2]=${$matrix5{$i}}[1]; $cntf2++; $frequency1=${$matrix4{$i}}[1];} 
  elsif ((${$matrix4{$i}}[1]>=0.28)&&(${$matrix4{$i}}[1]<0.3))
    {   $density4[$cntf3]=${$matrix5{$i}}[1]; $cntf3++; $frequency2=${$matrix4{$i}}[1];} 
  elsif ((${$matrix4{$i}}[1]>=0.4)&&(${$matrix4{$i}}[1]<=0.6))
    {   $density5[$cntf4]=${$matrix5{$i}}[1]; $cntf4++; $frequency3=${$matrix4{$i}}[1];}      
 }



my $average3 = average(@density3);
my $std_dev3 = std_dev($average3, @density3);

my $average4 = average(@density4);
my $std_dev4 = std_dev($average4, @density4);

my $average5 = average(@density5);
my $std_dev5 = std_dev($average5, @density5);


$pvalue=($average3/$sum);

$iter++;
#print file2b "$iter\t${$matrix1{$temp1}}[3]\t$highest\tDensity\t$temp4b\t@density\tFreq\t$temp4\t@frequency\t3ncl\t$twostddev\t$average3\t$std_dev3\t@density3\n"; 

my $trinclperiodicity=$average3/$average4;
my $trinclperiodicity2=$average3/$average5;

if (($trinclperiodicity>=1.5)&&($trinclperiodicity2>=1.5))
 {
print file2b "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[5]\t$average3\t$pvalue\t$std_dev3\t$frequency1\n"; 
 }
elsif ((($trinclperiodicity<1.5)||($trinclperiodicity2<1.5))&&(($trinclperiodicity>=1)||($trinclperiodicity2>=1)))

 #for (my $i=0; $i<$cntf; $i++)
   #{
    # $multiframes1=$average3/$density[$i];

     #if ( $multiframes>=1)
       {
print file2c "${$matrix1{$temp1}}[0]\t${$matrix1{$temp1}}[1]\t${$matrix1{$temp1}}[2]\t${$matrix1{$temp1}}[5]\t$average3\t$average4\t$average5\t$pvalue\t$std_dev3\t$temp4\t$temp4b\t$frequency2\n"; #system("mv tmp.pdf ${$matrix1{$temp1}}[4].pdf"); 
       }
    #}

}
$temp5=0;undef %matrix2;undef @frequency; undef @density; undef @density2; undef @density3;undef @density4;undef @density5;$temp4b=0; $stddev=0; $temp4=0; $twostddev=0; $cntf=0; $highest=0; $frequency=0; $density=0; $sum=0;$twostddev=0;$std_dev=0;$average=0;undef %matrix4;undef %matrix5;$std_dev3=0;$average3=0;$cntf2=0;$std_dev4=0;$average4=0;$cntf3=0;$std_dev5=0;$average5=0;$cntf5=0;$cntf4=0;$multiframes=0;$pvalue=1;$sum=0;$multiframes=0;$var2=0;$varmean=0;
$frequency1=0;$frequency2=0;$frequency3=0;
################################################################
  #system("rm $inputfile2.txt"); 

system("rm MyData1.csv"); system("rm MyData2.csv"); system("rm MyData1c.csv"); system("rm MyData2c.csv");
 
} } }

system("rm $inputfile2.txt");

sub max {
    my (%data) = @_;
 
    my $max=0; 
    while (my ($key, $value) = each %data) {
        if (not defined $max) {
            $max = $key;
            next;
        }
        if ($data{$max} > $value) {
            $max = $key;
        }
    }
    return $max;
}


sub average {
        my (@values) = @_;

        my $count = scalar @values;
        my $total = 0; 
        $total += $_ for @values; 

        return $count ? $total / $count : 0;
}

sub std_dev {
        my ($average, @values) = @_;

        my $count = scalar @values;
        my $std_dev_sum = 0;
        $std_dev_sum += ($_ - $average) ** 2 for @values;

        return $count ? sqrt($std_dev_sum / $count) : 0;
}
