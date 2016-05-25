#This is a program that takes a list of read names and well names and fasta files from DANA.
#will then make MAJORITY COUNT TABLE
#use for DIPLOID LOCI!!!
#input: text file with list of reads and well names associated (8 reads per well!!!)
#header on text file needs to read "read1", "read2"..."read8", "count1", "count2", ... "count8", "total", "file", well"
#these headers are the column names coming from the counttables_8reads_DANA code
#also need working directory to contain all fasta files for a locus 
#NB: will break if the names of the wells are not represented in the file list
#NB: will currently break if wells do not have 8 reads represented (NAs in goodreads file)
#goodreads table is based on the counttables_8reads_DANA code

library (seqinr) #load seqinr

goodreads<-read.table("C:/Users/Abigail/Desktop/asqu_i50_goodreads.txt",header=TRUE) #read in list of names we need; to change each time the file changes
files<-list.files() #make a list of all files in the working directory
seq_out_table = NULL #initialize empty data frame


for (i in goodreads$well) {
  namelist<-grep(i,files, value=TRUE) #find file that matches the well (works b/c file names start w/ well names)
  namefasta<-read.fasta(namelist,as.string=TRUE,set.attributes=FALSE) #read the appropriate fasta
  posi<-which(goodreads$well==i) #identify the line we are working with (i)
  
  r1<-cbind(namefasta[names(namefasta) %in% goodreads$read1],i, goodreads[posi,9]) #extract the read in the fasta which matches the read name in the text file, bind with well name and the count, will also pull the read name
  r2<-cbind(namefasta[names(namefasta) %in% goodreads$read2],i, goodreads[posi,10]) #repeat for the rest of the reads
  r3<-cbind(namefasta[names(namefasta) %in% goodreads$read3],i, goodreads[posi,11])
  r4<-cbind(namefasta[names(namefasta) %in% goodreads$read4],i, goodreads[posi,12])
  r5<-cbind(namefasta[names(namefasta) %in% goodreads$read5],i, goodreads[posi,13])
  r6<-cbind(namefasta[names(namefasta) %in% goodreads$read6],i, goodreads[posi,14])
  r7<-cbind(namefasta[names(namefasta) %in% goodreads$read7],i, goodreads[posi,15])
  r8<-cbind(namefasta[names(namefasta) %in% goodreads$read8],i, goodreads[posi,16])
  
  y<-rbind(r1,r2,r3,r4,r5,r6,r7,r8 ) #bind all rows for an individual
  
  seq_out_table<-rbind(seq_out_table,y) # attach the rows for this individual to the output table
  
}

#dim(seq_out_table) #check on code

seqread<-as.vector(seq_out_table[,1]) #make vectors from output table
seqwell<-as.vector(seq_out_table[,2])
seqcount<-as.vector(seq_out_table[,3])

seq3<-cbind(seqread,seqwell,seqcount) #bind vectors back together into output table

colnames(seq3)<-c("read","well","count") #rename columns on output table

write.csv(seq3,"C:/Users/Abigail/Desktop/asqu_i50_allout.csv") #write output table

seq4<-read.csv("C:/Users/Abigail/Desktop/asqu_i50_allout.csv",header=TRUE) #read back in output table - NECESSARY bc of the way the read names are read by R

unique_reads<-unique(seq4$read) #make vector of unique sequences (=haplotype numbers)

out_table = NULL #initiate blank table

for (i in seq4$X) {    #for each read (should be 8 times the number of individuals)
  position_seq<-which(seq4$X==i)  #find the line number
  
  allele_num<-which(unique_reads==seq4$read[position_seq])  #find the haplotype number of the read
  
  allele_seq<-as.character(unique_reads[allele_num])  #find the sequence of the read; force to string
  
  well_num<-as.character(seq4$well[position_seq])  #find the well number of the read; force to string
  
  count_seq<-seq4$count[position_seq]  #find the count associated with the read
  
  read_name<-as.character(seq4$X[position_seq])  #find the name fo the read; force to string
  
  line_i<-cbind(well_num,allele_num,count_seq,read_name,allele_seq)  #put all these items together in a row
  
  out_table<-rbind(out_table,line_i)  #bind the row to the output table
  
  
}

out_table<-as.data.frame(out_table) #make into data.frame (not needed yet but may be later)

colnames(out_table)<-c("well","haplotype_number","number_reads","read_name","sequence") #rename columns

#dim(out_table) #dimensions of table; used as check to make sure the code is working

write.csv(out_table,"C:/Users/Abigail/Desktop/asqu_i50_majoritycounttable.csv") #write majority count table to desktop

