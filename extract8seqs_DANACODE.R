#This is a program that takes a list of read names and well names and creates a fasta file of the reads we want for a single locus.
#Results coming from DANA
#use for DIPLOID LOCI!!!
#input: text file with list of reads and well names associated (8 reads per well!!!)
#for now, header on text file needs to read "read1", "read2"..."read8", "well"
#also need working directory to contain all fasta files for a locus 
#NB: will break if the names of the wells are not represented in the file list
#goodreads table is based on the counttables_8reads_DANA code

library (seqinr) #load seqinr

goodreads<-read.table("C:/Users/Abigail/Desktop/olon1972_goodreads2.txt",header=TRUE) #read in list of names we need; to change each time the file changes
files<-list.files() #make a list of all files in the working directory
seq_out_table = NULL #initialize empty data frame


for (i in goodreads$well) {
  namelist<-grep(i,files, value=TRUE) #find file that matches the well (works b/c file names start w/ well names)
  namefasta<-read.fasta(namelist,as.string=TRUE,set.attributes=FALSE) #read the appropriate fasta
  posi<-which(goodreads$well==i)
  
  r1<-cbind(namefasta[names(namefasta) %in% goodreads$read1],i, goodreads[posi,9]) #extract the read in the fasta which matches the read name in the text file, bind with well name
  r2<-cbind(namefasta[names(namefasta) %in% goodreads$read2],i, goodreads[posi,10]) #extract the second read for the well
  r3<-cbind(namefasta[names(namefasta) %in% goodreads$read3],i, goodreads[posi,11])
  r4<-cbind(namefasta[names(namefasta) %in% goodreads$read4],i, goodreads[posi,12])
  r5<-cbind(namefasta[names(namefasta) %in% goodreads$read5],i, goodreads[posi,13])
  r6<-cbind(namefasta[names(namefasta) %in% goodreads$read6],i, goodreads[posi,14])
  r7<-cbind(namefasta[names(namefasta) %in% goodreads$read7],i, goodreads[posi,15])
  r8<-cbind(namefasta[names(namefasta) %in% goodreads$read8],i, goodreads[posi,16])
  
  y<-rbind(r1,r2,r3,r4,r5,r6,r7,r8 )
  
  seq_out_table<-rbind(seq_out_table,y) #create output table of sequences and well names 
  
}

#dim(seq_out_table)

seqread<-as.vector(seq_out_table[,1])
seqwell<-as.vector(seq_out_table[,2])
seqcount<-as.vector(seq_out_table[,3])

seq3<-cbind(seqread,seqwell,seqcount)

colnames(seq3)<-c("read","well","count") #rename columns on output table

write.csv(seq3,"C:/Users/Abigail/Desktop/olon_1972_allout.txt")

