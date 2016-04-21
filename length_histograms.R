lengthfiles<-list.files() #create list of all files in the working directory

x0<-1 #set start of breakpoint sequence
breakpoints<-seq(x0, 250, 1) #create 1 bp bins for histogram

for (i in lengthfiles) {
  
  t<-read.table(i,header=FALSE) #read file
  hist(t$V4,main=i,breaks=breakpoints) #create histogram
}
