#This is a program that takes a list of read names and well names and creates a fasta file of the reads we want for a single locus.
#input: text file with list of reads and well names associated
#for now, header on text file needs to read "name" and "well"
#also need working directory to contain all fasta files for a locus (.unique are best b/c smallest)
#NB: will break if the names of the wells are not represented in the file list

library (seqinr) #load seqinr

goodreads<-read.table("F:/phred35/good_reads/olon_1972_het.txt",header=TRUE) #read in list of names we need; to change each time the file changes
files<-list.files() #make a list of all files in the working directory
seq_out_table = NULL #initialize empty data frame

for (i in goodreads$well) {
  namelist<-grep(i,files, value=TRUE) #find filethat matches the well (works b/c file names start w/ well names)
  namefasta<-read.fasta(namelist,as.string=TRUE,set.attributes=FALSE) #read the appropriate fasta
  y<-cbind(namefasta[names(namefasta) %in% goodreads$read1],i) #extract the read in the fasta which matches the read name in the text file, bind with well name
  z<-cbind(namefasta[names(namefasta) %in% goodreads$read2],i) #extract the second read for the well
  seq_out_table<-rbind(seq_out_table,y,z ) #create output table of sequences and well names 
  
}

colnames(seq_out_table)<-c("read","well") #rename columns on output table; prob not needed

write.fasta(seq_out_table[,1],names=seq_out_table[,2],"F:/phred35/out_fasta/olon_1972_hetout.fasta") 
#command to save to fasta with sequences and well names; change file name for each locus