#Script to run DAPC on fstat files
#will output scatter.dapcs using both clusters found in the analysis and sample location
#is different from dapc script because it is based on an fstat and not the sequences (fasta file)


library(adegenet)

species<-read.fstat("C:/Users/Abigail/Desktop/olon_147510mar.dat") #read in fasta file
pops<-read.table("C:/Users/Abigail/Desktop/olon147510marpops.txt") #read in list of sample populations

run_dapc<-function(species_name,pops){
  species_clust<-find.clusters(species) #find clusters in data
  scatter.dapc(dapc(species,pop=species_clust$grp)) #scatter.dapc of data with found clusters
  scatter.dapc(dapc(species,pop=pops$V1)) #scatter.dapc of data with collecting sites
  table(species_clust$grp,pops$V1) #creates frequency table of group membership
}