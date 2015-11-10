#This is a program that takes a list of read names and well names and creates a fasta file of the reads we want for a single locus.
#use for PARALOGOUS LOCI!!!
#input: text file with list of reads and well names associated (8 reads per well!!!)
#for now, header on text file needs to read "read1", "read2"..."read8", "well"
#also need working directory to contain all fasta files for a locus (.unique are best b/c smallest)
#NB: will break if the names of the wells are not represented in the file list
#goodreads table is based on the count_table code

library (seqinr) #load seqinr

goodreads<-read.table("C:/Users/Abigail/Desktop/Forward/goodreads/asqu_i50_goodreads.txt",header=TRUE) #read in list of names we need; to change each time the file changes
files<-list.files() #make a list of all files in the working directory
seq_out_table = NULL #initialize empty data frame


for (i in goodreads$well) {
  namelist<-grep(i,files, value=TRUE) #find file that matches the well (works b/c file names start w/ well names)
  namefasta<-read.fasta(namelist,as.string=TRUE,set.attributes=FALSE) #read the appropriate fasta
  r1<-cbind(namefasta[names(namefasta) %in% goodreads$read1],i) #extract the read in the fasta which matches the read name in the text file, bind with well name
  r2<-cbind(namefasta[names(namefasta) %in% goodreads$read2],i) #extract the second read for the well
  r3<-cbind(namefasta[names(namefasta) %in% goodreads$read3],i)
  r4<-cbind(namefasta[names(namefasta) %in% goodreads$read4],i)
  r5<-cbind(namefasta[names(namefasta) %in% goodreads$read5],i)
  r6<-cbind(namefasta[names(namefasta) %in% goodreads$read6],i)
  r7<-cbind(namefasta[names(namefasta) %in% goodreads$read7],i)
  r8<-cbind(namefasta[names(namefasta) %in% goodreads$read8],i)
  
  
  seq_out_table<-rbind(seq_out_table,r1,r2,r3,r4,r5,r6,r7,r8 ) #create output table of HETEROZTGOUS sequences and well names 
  
}

colnames(seq_out_table)<-c("read","well") #rename columns on output table; prob not needed

write.fasta(seq_out_table[,1],names=seq_out_table[,2],"C:/Users/Abigail/Desktop/Forward/out_fasta/asqu_i50_allout.fasta") 
#command to save to fasta with sequences and well names; change file name for each locus