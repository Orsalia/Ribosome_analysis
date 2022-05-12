
#library("multitaper", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.4")
#library("purrr", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.4")

library("multitaper")
library("purrr")


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
ftestvect<-function(psit,k,bw){
	psit <- as.vector(psit)
	if(sum(psit!=0) < 3) return(NA)
	if(sum(psit) < 10) return(NA)
		
	slepians_values<-dpss(n=length(psit)%>%ifelse(.<25,50,.),k=k,nw=bw)
	vals<-take_Fvals_spect(x = psit,n_tapers = k,time_bw = bw,slepians_values = slepians_values)
	pval <- pf(q=vals[1],df1=2,df2=(2*k)-2,lower.tail=F)
	return(c(pval))
}



get_mmt_spec<-function(psit,n_tapers,time_bw,slepians_values){
	psit <- as.vector(psit)
	if(sum(psit!=0) < 3) return(NA)
	if(sum(psit) < 10) return(NA)
		
	slepians_values<-dpss(n=length(psit)%>%ifelse(.<25,50,.),k=n_tapers,nw=time_bw)
	
     if(length(psit)<25){
          remain<-50-length(psit)
          psit<-c(rep(0,as.integer(remain/2)),psit,rep(0,remain%%2+as.integer(remain/2)))
     }

     if(length(psit)<1024/2){padding<-1024}
     if(length(psit)>=1024/2){padding<-"default"}

     resSpec1 <- spec.mtm(as.ts(psit), k=n_tapers, nw=time_bw, nFFT = padding, centreWithSlepians = TRUE, Ftest = TRUE, maxAdaptiveIterations = 100,returnZeroFreq=F,plot=F,dpssIN=slepians_values)
     
    
}

#x<-read.table("/media/sdc1/cancer/myalgorithms/test3ncl2.txt",sep="\t",header=FALSE)
#dat<-as.numeric(droplevels(x))
#dat <-as.numeric(x)


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
