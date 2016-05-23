#This is a program to assess MiSeq count tables from DANA for DIPLOID LOCI
#make sure the wd contains all of the count table files for the locus but remove all empty count tables

library(dplyr) #load dplyr 

out_table = NULL #initiate empty data frame

files<-list.files() #create list of all files in the working directory

for (i in files) {
  
  t<-read.table(i,header=FALSE) #read file
  t_sort<-arrange(t,desc(V3)) #sort table by total read counts, largest first
  #t_ratio1<-t_sort[2,2]/t_sort[1,2] #calculate ratio btwn first and second largest read counts (btwn 0 and 1)
  #t_ratio2<-t_sort[3,2]/t_sort[1,2] #calculate ratio btwn first and third largest read counts (btwn 0 and 1)
  t_totreads<-sum(t$V3) #calculate the total read number in this well
  y<-abbreviate(i,minlength=6) #truncate file name to get the well name
  
  out_table<-rbind(out_table, data.frame(t_sort[1,1],t_sort[2,1],t_sort[3,1],t_sort[4,1],t_sort[5,1],t_sort[6,1],t_sort[7,1],t_sort[8,1],t_sort[1,3],t_sort[2,3],t_sort[3,3],t_sort[4,3],t_sort[5,3],t_sort[6,3],t_sort[7,3],t_sort[8,3],t_totreads,i,y)) #create table for output and bind to empty frame
  
}


colnames(out_table)<-c("read1","read2","read3","read4","read5","read6","read7","read8","count1","count2","count3","count4","count5","count6","count7","count8","total","file","well") #rename columns for graph

z<-arrange(out_table,desc(total)) #sort output table by decreasing total
#head(z) #print first lines of sorted table


#Then use write.table function to output table as txt file for further use
write.table(z,"C:/Users/Abigail/Desktop/oln_1972_counts.csv")