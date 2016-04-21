lengthfiles<-list.files() #create list of all files in the working directory

x0<-1
breakpoints<-seq(x0, 250, 1)

for (i in lengthfiles) {
  
  t<-read.table(i,header=FALSE) #read file
  hist(t$V4,main=i,breaks=breakpoints)
}
