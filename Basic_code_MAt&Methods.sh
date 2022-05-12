#Basic Bioinformatics commands

#Example and removal of adapters for the RNA-seq data
/STAR-2.7.6a/bin/Linux_x86_64/STAR --readFilesIn SRR8392698.fastq --genomeDir /finalgenomes/Homo_sapiens_NCBI_GRCh38/Homo_sapiens/NCBI/GRCh38/Sequence/STARIndex --runThreadN 30 --outSAMtype BAM Unsorted --outFilterType BySJout --outFileNamePrefix "Young2_"

#Example 1 alignments and removal of adapter for the Ribosome profile data  

./fastqc SRR11869336.1.fastq

cutadapt -a AGATCGGAAGAGCACACGTCT -q 20 --minimum-length 21 -o output.SRR11869336.1.fastq SRR11869336.1.fastq

tophat2 -o SRR11869336 -p 20 -g 1 --bowtie1 --keep-fasta-order --library-type fr-unstranded --no-coverage-search -G /mnt/7B0A84BA65F51F49/finalgenomes/mm10/Annotation/Genes/genes.gtf /mnt/7B0A84BA65F51F49/finalgenomes/mm10/Sequence/Bowtie2Index/genome output.SRR11869336.1.fastq

# periodicity testing and P-site offset for the Ribosome profile data
###scripts are from RiboTaper_v1_3 pipeline : https://ohlerlab.mdc-berlin.de/software/RiboTaper_126/

/Desktop/Bioinformatics/RiboTaper_v1.3/Version_1.3/scripts/./create_annotations_files.bash ~/Desktop/bioinf_project/mm10.refGene.gtf ~/Desktop/bioinf_project/chrmallmm10.fa false false ~/Desktop/bioinf_project/ ~/Desktop/Bioinformatics/bedtools_dir/ ~/Desktop/Bioinformatics/RiboTaper_v1.3/Version_1.3/scripts/

#### Ribotaper runs
~/Desktop/Bioinformatics/RiboTaper_v1.3/Version_1.3/scripts/./Ribotaper.sh ~/Desktop/bioinf_project/SRR11869324_1/accepted_hitsRibo.bam ~/Desktop/bioinf_project/SRR11869324_1/accepted_hitsRNA.bam ~/Desktop/bioinf_project/annotation/ 21,28,29,30, 12,12,12,12 ~/Desktop/Bioinformatics/RiboTaper_v1.3/Version_1.3/scripts/ ~/Desktop/Bioinformatics/bedtools_dir/ 4

#####example for counting counts
~/Desktop/Bioinformatics/subread-2.0.1.0-Linux-x86_64/bin/./featureCounts -t exon -g gene_id --fracOverlap 0.2 -a ~/Desktop/bioinf_project/annotation/mm10.refGene.gtf -o SRR11869323AlignedcountsK20m1.txt SRR11869323Aligned.out.bam

########Translation efficiency calculations with Deseq2 basic commands in R #########################
library(DESeq2)
library(ggplot2)

merge <- read.table("/OIS/OIS_SEn_T/OISvswtRNARibocounts.txt", header=TRUE, sep="\t", row.names=1) 
head(merge)
#####################################################################
>output 
Gene	wt_a_rna	wt_b_rna	OIS_a_rna	OIS_b_rna	wt_a_ribo	wt_b_ribo	OIS_a_ribo	OIS_b_ribo
AAAS	10696	8074	7122	6035	187	140	654	469
AACS	5876	4449	9690	5174	41	91	529	105
AAGAB	39936	34731	47871	44120	1953	1401	1972	1422
AAK1	1905	2382	1031	1094	87	180	1229	147
AAMDC	905	442	255	381	62	309	490	284
AARS2	3346	3122	2339	4065	1308	7115	11	56
AARSD1	1008	738	1002	555	956	684	546	250
AASS	95	360	247	138	1114	51	16	64
ABCB6	1755	1421	388	767	93	102	162	220
ABCB7	750	1197	1310	986	231	89	183	36
######################################################################

sample_table <- read.table("/OIS/OIS_SEn_T/OISvswtRNARibometa.txt", header=TRUE, sep="\t")

dds <- DESeqDataSetFromMatrix(countData = merge, 
                                   colData = sample_table, 
                                   design = ~Batch+SeqType + Condition + SeqType:Condition)

dds$Condition <- factor(dds$Condition, levels=c("1","2"))

dds$SeqType <- factor(dds$SeqType, levels=c("RNA","RIBO"))

dds <- DESeq(dds)

res <- results(dds)

resOrdered <- res[order(res$padj),]

write.table(as.data.frame(resOrdered),file="OIS/OIS_SEn_T/OIS_RNARiboTE.txt",row.names = T)
############################################################################################################################3
#Run basic commands for calculating P sites and coverage per region. Investigation of Psites come from RiboTaper

export PATH="/home/orsalia/Desktop/Bioinformatics/bedtools_dir/:$PATH" ### point bedtools_dir

~/Desktop/Bioinformatics/RiboTaper_v1.3/Version_1.3/script/./P_sites_RNA_sites_calc.bash 29,30 12,12 /usr/bin 

############ coverage of the Psites per transcript 

coverageBed -s -d -a P_sites_all -b ~/Desktop/Bioinformatics/GRCh37/annotation_dir_human/transcr_exons_ccds.bed | awk '{ print $1 ";" $2 ";" $3 ";" $4 ";" $5";" $6 "\t" "_" $8}' | awk -F"\t" '{if(a[$1])a[$1]=a[$1]" "$NF; else a[$1]=$NF}END{for (i in a)print i "\t" a[i]}'| sed 's/_//g' | sed 's/;/\t/g' | sort -k1,1 -k4,4 -k2,2g > P_sites_all_exons_ccds.bed

coverageBed -s -d -a P_sites_all -b ~/Desktop/Bioinformatics/GRCh37/hg19UTR5fatobed.bed | awk '{ print $1 ";" $2 ";" $3 ";" $4 ";" $5";" $6 "\t" "_" $8}' | awk -F"\t" '{if(a[$1])a[$1]=a[$1]" "$NF; else a[$1]=$NF}END{for (i in a)print i "\t" a[i]}'| sed 's/_//g' | sed 's/;/\t/g' | sort -k1,1 -k4,4 -k2,2g > P_sites_all_exons_5UTR.bed

coverageBed -s -d -a P_sites_all -b ~/Desktop/Bioinformatics/GRCh37/hg19UTR3fatobednocds.bed | awk '{ print $1 ";" $2 ";" $3 ";" $4 ";" $5";" $6 "\t" "_" $8}' | awk -F"\t" '{if(a[$1])a[$1]=a[$1]" "$NF; else a[$1]=$NF}END{for (i in a)print i "\t" a[i]}'| sed 's/_//g' | sed 's/;/\t/g' | sort -k1,1 -k4,4 -k2,2g > P_sites_all_exons_3UTR.bed

sort -k4,4 P_sites_all_exons_ccds.bed > P_sites_all_exons_ccds_sort.bed

####file after coverageBed column 7= Psite coverages same will be for RNA-seq check RiboTaper scripts 
chr17	75855238	75855297	ENST00000254806.8cds70chr1775855239r	0	-	0 0 0 0 1 0 0 0 0 0 2 1 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 2 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 6 0 0 0 1 0 0 1 0 1 0 0 22
chr17	75778594	75778723	ENST00000254810.8cds00chr1775778595r	0	-	0 1 0 1 0 16 1 0 0 4 1 9 3 0 5 0 0 0 1 0 1 2 5 2 0 0 2 1 0 2 1 1 3 0 0 0 0 0 0 0 0 2 0 0 4 3 1 3 0 0 1 0 0 4 2 0 0 1 0 2 0 0 0 0 0 2 0 0 0 1 0 1 1 0 6 4 1 4 1 0 0 1 0 1 2 0 5 2 0 6 0 0 0 0 0 1 0 0 0 0 0 1 4 4 4 8 1 10 5 1 1 1 0 0 1 0 0 0 1 3 0 0 1 0 0 0 6 1 0
chr17	75778809	75778963	ENST00000254810.8cds10chr1775778810r	0	-	2 0 5 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 2 0 1 0 0 1 2 0 3 2 0 0 2 0 3 0 0 2 1 0 4 0 2 1 0 0 0 1 1 4 1 0 0 2 1 4 1 0 3 3 0 3 0 0 1 9 4 9 3 0 0 0 0 0 0 0 1 1 1 2 1 0 3 0 0 0 0 0 0 0 0 2 0 1 1 0 0 0 0 0 0 0 0 1 2 6 8 2 1 3 1 0 0 0 0 1 1 0 0 2 0 3 0 0 1 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 3 0 5 0 1 4 1 0 2 0 1 0 0 0 7 0
chr17	75779046	75779174	ENST00000254810.8cds20chr1775779047r	0	-	1 0 0 1 0 0 1 0 3 0 3 0 0 10 1 0 0 0 0 1 0 0 2 0 0 0 0 3 2 0 2 1 0 1 3 0 1 6 0 0 0 1 1 0 1 1 1 1 3 6 4 2 1 0 0 1 0 0 11 1 0 5 0 0 0 0 0 0 0 0 0 1 0 2 0 1 2 4 6 0 0 0 0 0 0 3 0 3 6 0 0 3 0 1 1 1 0 6 5 15 20 0 12 21 1 1 2 0 0 12 1 7 3 11 4 36 1 40 21 12 10 70 4 6 12 1 9 71

#merge Psites for ENST00000254810 exclude zeros calculate average Psite and pert transcript and overall per library
sort -k4,4 P_sites_all_exons_ccds.bed > P_sites_all_exons_ccds_sort.bed

perl ~/Desktop/Bioinformatics/RiboTaper_v1.3/merge.pl P_sites_all_exons_ccds_sort.bed stalling_exons_ccdsortmerge

perl ~/Desktop/Bioinformatics/RiboTaper_v1.3/calcavstdevperlibrary.pl stalling_exons_ccdsortmerge ## this will print total <average>   <stdev>
#### choose more than 2 stdeviations overal Psite coverage
perl ~/Desktop/Bioinformatics/RiboTaper_v1.3/stall.pl P_sites_all_exons_ccds_sort.bed stalling_exons_ccdsort  <average>   <stdev>  ## this extracts stall position and the coverage 
>chr19	58388139	58388142	282	0	+

##extract coordinates
perl ~/Desktop/Bioinformatics/RiboTaper_v1.3/EPAcoordcalc.pl stalling_exons_ccdsort.stall.bed stalling_exons_ccdsort.stall 

fastaFromBed -s -fi ~/annotation/hg38.fa -bed stalling_exons_ccdsort.stall.Pccds_u.bed -fo stalling_exons_ccdsort.stall.P3ccds_u.fa -tab
fastaFromBed -s -fi ~/annotation/hg38.fa -bed stalling_exons_ccdsort.stall.Eccds_u.bed -fo stalling_exons_ccdsort.stall.E3ccds_u.fa -tab
fastaFromBed -s -fi ~/annotation/hg38.fa -bed stalling_exons_ccdsort.stall.Accds_u.bed -fo stalling_exons_ccdsort.stall.A3ccds_u.fa -tab

######## codon usage
###makefastatobed from previous code to bed
perl ~/Desktop/Bioinformatics/RiboTaper_v1.3/makefastatobed2.pl stalling_exons_ccdsort.stall.Pccds_u.fa stalling_exons_ccdsort.stall.Plr2fatobed
intersectBed -a stalling_exons_ccdsort.stall.Plr2fatobed.bed -b stalling_exons_ccdsort.stall.Pccds_u.bed -s -wa -wb > stalling_exons_ccdsort.stall.Plr2fatobedcount.bed #have fasta codon and coverage  

### ORF finding These scripts are found in RiboTaperv1.3  CCDS_orf_finder.R
#main script to be sused in R
#this script uses the Psite coverage from example above i.e
#chr17	75779046	75779174	ENST00000254810.8cds20chr1775779047r	0	-	1 0 0 1 0 0 1 0 3 0 3 0 0 10 1 0 0 0 0 1 0 0 2 0 0 0 0 3 2 0 2 1 0 1 3 0 1 6 0 0 0 1 1 0 1 1 1 1 3 6 4 2 1 0 0 1 0 0 11 1 0 5 0 0 0 0 0 0 0 0 0 1 0 2 0 1 2 4 6 0 0 0 0 0 0 3 0 3 6 0 0 3 0 1 1 1 0 6 5 15 20 0 12 21 1 1 2 0 0 12 1 7 3 11 4 36 1 40 21 12 10 70 4 6 12 1 9 71
######################################################################################################ORF finding
############## filter 5UTR ORFs
perl 3nclfind_callR2ccc2.pl P_sites_all_exons_5UTRF.bed test3ncl 3nclperiodic 3nclmultiframes
mv 3nclperiodic.txt 3nclperiodic5UTR
mv 3nclmultiframes.txt 3nclmultiframes5UTR

################################################################################# R script for ORF finding
library("multitaper")
library("purrr")


dat<-c(1 0 0 1 0 0 1 0 3 0 3 0 0 10 1 0 0 0 0 1 0 0 2 0 0 0 0 3 2 0 2 1 0 1 3 0 1 6 0 0 0 1 1 0 1 1 1 1 3 6 4 2 1 0 0 1 0 0 11 1 0 5 0 0 0 0 0 0 0 0 0 1 0 2 0 1 2 4 6 0 0 0 0 0 0 3 0 3 6 0 0 3 0 1 1 1 0 6 5 15 20 0 12 21 1 1 2 0 0 12 1 7 3 11 4 36 1 40 21 12 10 70 4 6 12 1 9 71)
 

#this function takes in a numeric vector x (psites) 
#returns the maximum F value (for pvalue calcs)
#and the magnitudes of the FFT at the closest frequency to 0.33

take_Fvals_spect<-function(x,n_tapers,time_bw,slepians_values){
     if(length(x)<25){
          remain<-50-length(x)
          x<-c(rep(0,as.integer(remain/2)),x,rep(0,remain%%2+as.integer(remain/2)))
     }

     if(length(x)<1024/2){padding<-1024}
     if(length(x)>=1024/2){padding<-"default"}

     #slepians_values<-dpss(n=length(psit)%>%ifelse(.<25,50,.),k=n_tapers,nw=time_bw)

     resSpec1 <- spec.mtm(as.ts(x), k=n_tapers, nw=time_bw, nFFT = padding, centreWithSlepians = TRUE, Ftest = TRUE, maxAdaptiveIterations = 100,returnZeroFreq=F,plot=F,dpssIN=slepians_values)
          
     closestfreqind <- which(abs((resSpec1$freq-(1/3)))==min(abs((resSpec1$freq-(1/3)))))
     
     freq_max_3nt<-resSpec1$freq[closestfreqind]
     Fmax_3nt<-resSpec1$mtm$Ftest[closestfreqind]
     spect_3nt<-resSpec1$spec[closestfreqind]
     
     
     return(c(Fmax_3nt,spect_3nt))
     
}

dat2 <- as.data.frame(dat)
if(length(dat)<=100){

multitaperobject <- get_mmt_spec(dat,6,3)
pval<- ftestvect(dat,6,3)
#pdf('tmp.pdf');plot(multitaperobject$freq,multitaperobject$spec);dev.off()
#normalizePath('tmp.pdf')

               } else if ((length(dat)>=100) && (length(dat)<=128))
{

multitaperobject <- get_mmt_spec(dat,12,6)
pval<- ftestvect(dat,12,6)
#pdf('tmp.pdf');plot(multitaperobject$freq,multitaperobject$spec);dev.off()
#normalizePath('tmp.pdf')
               } else if ((length(dat)>=128))
{

multitaperobject <- get_mmt_spec(dat,24,12)
pval<- ftestvect(dat,24,12)
#pdf('tmp.pdf');plot(multitaperobject$freq,multitaperobject$spec);dev.off()
#normalizePath('tmp.pdf')
               }

#detach(package:purrr)
write.csv(multitaperobject$freq,file = "MyData1.csv") 
write.csv(multitaperobject$spec,file = "MyData2.csv")
############################################################################################################################################################################



