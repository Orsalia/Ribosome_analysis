#!/bin/perl
#use warnings;
#use strict;
use POSIX;

my $inputfile=$ARGV[0]; #transcript
my $inputfile2=$ARGV[1];

open (file2,">$inputfile2.stalling.codon_distrib") or die "$!\n";

my %matrix1;
my %matrix2;
my %matrix3;
my @matrixtest1;
my @matrixtest2;
my @matrixtest3;
my $var1=0;my $var=0;my $var1b=0;

open (INPUT_FILE,$inputfile);
while(my $line1=<INPUT_FILE>)
{ @{$matrix1{$var}}=split(/\t/,$line1); #12
  
if (( ${$matrix1{$var}}[3] =~/TTT/ )||( ${$matrix1{$var}}[3] =~/ttt/ ))
    { $matrixTTT=${$matrix1{$var}}[9]+$matrixTTT; }
elsif (( ${$matrix1{$var}}[3] =~/TTC/ )||( ${$matrix1{$var}}[3] =~/ttc/ ))
    { $matrixTTC=${$matrix1{$var}}[9]+$matrixTTC; }    
elsif (( ${$matrix1{$var}}[3] =~/TTA/ )||( ${$matrix1{$var}}[3] =~/tta/ ))
    { $matrixTTA=${$matrix1{$var}}[9]+$matrixTTA; }        
elsif (( ${$matrix1{$var}}[3] =~/TTG/ )||( ${$matrix1{$var}}[3] =~/ttg/ ))
    { $matrixTTG=${$matrix1{$var}}[9]+$matrixTTG; }           
elsif (( ${$matrix1{$var}}[3] =~/TCT/ )||( ${$matrix1{$var}}[3] =~/tct/ ))
    { $matrixTCT=${$matrix1{$var}}[9]+$matrixTCT; }
elsif (( ${$matrix1{$var}}[3] =~/TCC/ )||( ${$matrix1{$var}}[3] =~/tcc/ ))
    { $matrixTCC=${$matrix1{$var}}[9]+$matrixTCC; } 
elsif (( ${$matrix1{$var}}[3] =~/TCA/ )||( ${$matrix1{$var}}[3] =~/tca/ ))
    { $matrixTCA=${$matrix1{$var}}[9]+$matrixTCA; }  
elsif (( ${$matrix1{$var}}[3] =~/TCG/ )||( ${$matrix1{$var}}[3] =~/tcg/ ))
    { $matrixTCG=${$matrix1{$var}}[9]+$matrixTCG; }   
elsif (( ${$matrix1{$var}}[3] =~/TAT/ )||( ${$matrix1{$var}}[3] =~/tat/ ))
    { $matrixTAT=${$matrix1{$var}}[9]+$matrixTAT; } 
elsif (( ${$matrix1{$var}}[3] =~/TAC/ )||( ${$matrix1{$var}}[3] =~/tac/ ))
    { $matrixTAC=${$matrix1{$var}}[9]+$matrixTAC; }
elsif (( ${$matrix1{$var}}[3] =~/TAA/ )||( ${$matrix1{$var}}[3] =~/taa/ ))
    { $matrixTAA=${$matrix1{$var}}[9]+$matrixTAA; }
elsif (( ${$matrix1{$var}}[3] =~/TAG/ )||( ${$matrix1{$var}}[3] =~/tag/ ))
    { $matrixTAG=${$matrix1{$var}}[9]+$matrixTAG; }  
elsif (( ${$matrix1{$var}}[3] =~/TGT/ )||( ${$matrix1{$var}}[3] =~/tgt/ ))
    { $matrixTGT=${$matrix1{$var}}[9]+$matrixTGT; } 
elsif (( ${$matrix1{$var}}[3] =~/TGC/ )||( ${$matrix1{$var}}[3] =~/tgc/ ))
    { $matrixTGC=${$matrix1{$var}}[9]+$matrixTGC; } 
elsif (( ${$matrix1{$var}}[3] =~/TGA/ )||( ${$matrix1{$var}}[3] =~/tga/ ))
    { $matrixTGA=${$matrix1{$var}}[9]+$matrixTGA; } 
elsif (( ${$matrix1{$var}}[3] =~/TGG/ )||( ${$matrix1{$var}}[3] =~/tgg/ ))
    { $matrixTGG=${$matrix1{$var}}[9]+$matrixTGG; }
elsif (( ${$matrix1{$var}}[3] =~/CTT/ )||( ${$matrix1{$var}}[3] =~/ctt/ ))
    { $matrixCTT=${$matrix1{$var}}[9]+$matrixCTT; }  
elsif (( ${$matrix1{$var}}[3] =~/CTC/ )||( ${$matrix1{$var}}[3] =~/ctc/ ))
    { $matrixCTC=${$matrix1{$var}}[9]+$matrixCTC; }   
elsif (( ${$matrix1{$var}}[3] =~/CTA/ )||( ${$matrix1{$var}}[3] =~/cta/ ))
    { $matrixCTA=${$matrix1{$var}}[9]+$matrixCTA; }   
elsif (( ${$matrix1{$var}}[3] =~/CTG/ )||( ${$matrix1{$var}}[3] =~/ctg/ ))
    { $matrixCTG=${$matrix1{$var}}[9]+$matrixCTG; } 
elsif (( ${$matrix1{$var}}[3] =~/CCT/ )||( ${$matrix1{$var}}[3] =~/cct/ ))
    { $matrixCCT=${$matrix1{$var}}[9]+$matrixCCT; } 
elsif (( ${$matrix1{$var}}[3] =~/CCC/ )||( ${$matrix1{$var}}[3] =~/ccc/ ))
    { $matrixCCC=${$matrix1{$var}}[9]+$matrixCCC; }  
elsif (( ${$matrix1{$var}}[3] =~/CCA/ )||( ${$matrix1{$var}}[3] =~/cca/ ))
    { $matrixCCA=${$matrix1{$var}}[9]+$matrixCCA; }
elsif (( ${$matrix1{$var}}[3] =~/CCG/ )||( ${$matrix1{$var}}[3] =~/ccg/ ))
    { $matrixCCG=${$matrix1{$var}}[9]+$matrixCCG; } 
elsif (( ${$matrix1{$var}}[3] =~/CAT/ )||( ${$matrix1{$var}}[3] =~/cat/ ))
    { $matrixCAT=${$matrix1{$var}}[9]+$matrixCAT; }  
elsif (( ${$matrix1{$var}}[3] =~/CAC/ )||( ${$matrix1{$var}}[3] =~/cac/ ))
    { $matrixCAC=${$matrix1{$var}}[9]+$matrixCAC; } 
elsif (( ${$matrix1{$var}}[3] =~/CAA/ )||( ${$matrix1{$var}}[3] =~/caa/ ))
    { $matrixCAA=${$matrix1{$var}}[9]+$matrixCAA; } 
elsif (( ${$matrix1{$var}}[3] =~/CAG/ )||( ${$matrix1{$var}}[3] =~/cag/ ))
    { $matrixCAG=${$matrix1{$var}}[9]+$matrixCAG; } 
elsif (( ${$matrix1{$var}}[3] =~/CGT/ )||( ${$matrix1{$var}}[3] =~/cgt/ ))
    { $matrixCGT=${$matrix1{$var}}[9]+$matrixCGT; } 
elsif (( ${$matrix1{$var}}[3] =~/CGC/ )||( ${$matrix1{$var}}[3] =~/cgc/ ))
    { $matrixCGC=${$matrix1{$var}}[9]+$matrixCGC; } 
elsif (( ${$matrix1{$var}}[3] =~/CGA/ )||( ${$matrix1{$var}}[3] =~/cga/ ))
    { $matrixCGA=${$matrix1{$var}}[9]+$matrixCGA; } 
elsif (( ${$matrix1{$var}}[3] =~/CGG/ )||( ${$matrix1{$var}}[3] =~/cgg/ ))
    { $matrixCGG=${$matrix1{$var}}[9]+$matrixCGG; }   
elsif (( ${$matrix1{$var}}[3] =~/ATT/ )||( ${$matrix1{$var}}[3] =~/att/ ))
    { $matrixATT=${$matrix1{$var}}[9]+$matrixATT; } 
elsif (( ${$matrix1{$var}}[3] =~/ATC/ )||( ${$matrix1{$var}}[3] =~/atc/ ))
    { $matrixATC=${$matrix1{$var}}[9]+$matrixATC; }   
elsif (( ${$matrix1{$var}}[3] =~/ATA/ )||( ${$matrix1{$var}}[3] =~/ata/ ))
    { $matrixATA=${$matrix1{$var}}[9]+$matrixATA; }  
elsif (( ${$matrix1{$var}}[3] =~/ATG/ )||( ${$matrix1{$var}}[3] =~/atg/ ))
    { $matrixATG=${$matrix1{$var}}[9]+$matrixATG; }  
elsif (( ${$matrix1{$var}}[3] =~/ACT/ )||( ${$matrix1{$var}}[3] =~/act/ ))
    { $matrixACT=${$matrix1{$var}}[9]+$matrixACT; } 
elsif (( ${$matrix1{$var}}[3] =~/ACC/ )||( ${$matrix1{$var}}[3] =~/acc/ ))
    { $matrixACC=${$matrix1{$var}}[9]+$matrixACC; } 
elsif (( ${$matrix1{$var}}[3] =~/ACA/ )||( ${$matrix1{$var}}[3] =~/aca/ ))
    { $matrixACA=${$matrix1{$var}}[9]+$matrixACA; }
elsif (( ${$matrix1{$var}}[3] =~/ACG/ )||( ${$matrix1{$var}}[3] =~/acg/ ))
    { $matrixACG=${$matrix1{$var}}[9]+$matrixACG; }
elsif (( ${$matrix1{$var}}[3] =~/AAT/ )||( ${$matrix1{$var}}[3] =~/aat/ ))
    { $matrixAAT=${$matrix1{$var}}[9]+$matrixAAT; }
elsif (( ${$matrix1{$var}}[3] =~/AAC/ )||( ${$matrix1{$var}}[3] =~/aac/ ))
    { $matrixAAC=${$matrix1{$var}}[9]+$matrixAAC; }
elsif (( ${$matrix1{$var}}[3] =~/AAA/ )||( ${$matrix1{$var}}[3] =~/aaa/ ))
    { $matrixAAA=${$matrix1{$var}}[9]+$matrixAAA; } 
elsif (( ${$matrix1{$var}}[3] =~/AAG/ )||( ${$matrix1{$var}}[3] =~/aag/ ))
    { $matrixAAG=${$matrix1{$var}}[9]+$matrixAAG; }  
elsif (( ${$matrix1{$var}}[3] =~/AGT/ )||( ${$matrix1{$var}}[3] =~/agt/ ))
    { $matrixAGT=${$matrix1{$var}}[9]+$matrixAGT; }  
elsif (( ${$matrix1{$var}}[3] =~/AGC/ )||( ${$matrix1{$var}}[3] =~/agc/ ))
    { $matrixAGC=${$matrix1{$var}}[9]+$matrixAGC; }   
elsif (( ${$matrix1{$var}}[3] =~/AGA/ )||( ${$matrix1{$var}}[3] =~/aga/ ))
    { $matrixAGA=${$matrix1{$var}}[9]+$matrixAGA; }  
elsif (( ${$matrix1{$var}}[3] =~/AGG/ )||( ${$matrix1{$var}}[3] =~/agg/ ))
    { $matrixAGG=${$matrix1{$var}}[9]+$matrixAGG; }  
elsif (( ${$matrix1{$var}}[3] =~/GTT/ )||( ${$matrix1{$var}}[3] =~/gtt/ ))
    { $matrixGTT=${$matrix1{$var}}[9]+$matrixGTT; }  
elsif (( ${$matrix1{$var}}[3] =~/GTC/ )||( ${$matrix1{$var}}[3] =~/gtc/ ))
    { $matrixGTC=${$matrix1{$var}}[9]+$matrixGTC; }  
elsif (( ${$matrix1{$var}}[3] =~/GTA/ )||( ${$matrix1{$var}}[3] =~/gta/ ))
    { $matrixGTA=${$matrix1{$var}}[9]+$matrixGTA; } 
elsif (( ${$matrix1{$var}}[3] =~/GTG/ )||( ${$matrix1{$var}}[3] =~/gtg/ ))
    { $matrixGTG=${$matrix1{$var}}[9]+$matrixGTG; } 
elsif (( ${$matrix1{$var}}[3] =~/GCT/ )||( ${$matrix1{$var}}[3] =~/gct/ ))
    { $matrixGCT=${$matrix1{$var}}[9]+$matrixGCT; }   
elsif (( ${$matrix1{$var}}[3] =~/GCC/ )||( ${$matrix1{$var}}[3] =~/gcc/ ))
    { $matrixGCC=${$matrix1{$var}}[9]+$matrixGCC; }  
elsif (( ${$matrix1{$var}}[3] =~/GCA/ )||( ${$matrix1{$var}}[3] =~/gca/ ))
    { $matrixGCA=${$matrix1{$var}}[9]+$matrixGCA; } 
elsif (( ${$matrix1{$var}}[3] =~/GCG/ )||( ${$matrix1{$var}}[3] =~/gcg/ ))
    { $matrixGCG=${$matrix1{$var}}[9]+$matrixGCG; }  
elsif (( ${$matrix1{$var}}[3] =~/GAT/ )||( ${$matrix1{$var}}[3] =~/gat/ ))
    { $matrixGAT=${$matrix1{$var}}[9]+$matrixGAT; }  
elsif (( ${$matrix1{$var}}[3] =~/GAC/ )||( ${$matrix1{$var}}[3] =~/gac/ ))
    { $matrixGAC=${$matrix1{$var}}[9]+$matrixGAC; }     
elsif (( ${$matrix1{$var}}[3] =~/GAA/ )||( ${$matrix1{$var}}[3] =~/gaa/ ))
    { $matrixGAA=${$matrix1{$var}}[9]+$matrixGAA; }  
elsif (( ${$matrix1{$var}}[3] =~/GAG/ )||( ${$matrix1{$var}}[3] =~/gag/ ))
    { $matrixGAG=${$matrix1{$var}}[9]+$matrixGAG; } 
elsif (( ${$matrix1{$var}}[3] =~/GGT/ )||( ${$matrix1{$var}}[3] =~/ggt/ ))
    { $matrixGGT=${$matrix1{$var}}[9]+$matrixGGT; } 
elsif (( ${$matrix1{$var}}[3] =~/GGC/ )||( ${$matrix1{$var}}[3] =~/ggc/ ))
    { $matrixGGC=${$matrix1{$var}}[9]+$matrixGGC; } 
elsif (( ${$matrix1{$var}}[3] =~/GGA/ )||( ${$matrix1{$var}}[3] =~/gga/ ))
    { $matrixGGA=${$matrix1{$var}}[9]+$matrixGGA; }  
elsif (( ${$matrix1{$var}}[3] =~/GGG/ )||( ${$matrix1{$var}}[3] =~/ggg/ ))
    { $matrixGGG=${$matrix1{$var}}[9]+$matrixGGG; }                                                                                    
    
 }
 
print file2 "$matrixTTT\t$matrixTTC\t$matrixTTA\t$matrixTTG\t$matrixTCT\t$matrixTCC\t$matrixTCA\t$matrixTCG\t$matrixTAT\t$matrixTAC\t$matrixTAA\t$matrixTAG\t$matrixTGT\t$matrixTGC\t$matrixTGA\t$matrixTGG\t$matrixCTT\t$matrixCTC\t$matrixCTA\t$matrixCTG\t$matrixCCT\t$matrixCCC\t$matrixCCA\t$matrixCCG\t$matrixCAT\t$matrixCAC\t$matrixCAA\t$matrixCAG\t$matrixCGT\t$matrixCGC\t$matrixCGA\t$matrixCGG\t$matrixATT\t$matrixATC\t$matrixATA\t$matrixATG\t$matrixACT\t$matrixACC\t$matrixACA\t$matrixACG\t$matrixAAT\t$matrixAAC\t$matrixAAA\t$matrixAAG\t$matrixAGT\t$matrixAGC\t$matrixAGA\t$matrixAGG\t$matrixGTT\t$matrixGTC\t$matrixGTA\t$matrixGTG\t$matrixGCT\t$matrixGCC\t$matrixGCA\t$matrixGCG\t$matrixGAT\t$matrixGAC\t$matrixGAA\t$matrixGAG\t$matrixGGT\t$matrixGGC\t$matrixGGA\t$matrixGGG\n";     
    
       
                  
    
    
    
    
    
    
    
    
                            
