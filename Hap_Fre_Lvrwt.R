GT_file = "High_Low_Lvrwt_GeneGABRE_Chr61_from_4647533_to_4700148_GT.txt";
region = "Chr61";parts = "GABRE";left = 4647533;right = 4700148
out_dir = "./"
Hap_Fre_Lvrwt<-function(GT_file,region,parts,left,right,LL=TRUE,HL=TRUE,FRE=TRUE,ymax=1,out_dir) {
  library(ggplot2);library(ggpubr);library(reshape2)
  
  hapchr6<-read.csv2(GT_file,header = T,sep = "\t",stringsAsFactors = F)
  hapchr6<-hapchr6[,-c(1,3,6:9)]
  print("Extract geotypes......")
  for (r in 1:nrow(hapchr6)) {
    for (c in 4:ncol(hapchr6)) {
      hapchr6[r,c]<-unlist(strsplit(as.character(hapchr6[r,c]),":"))[1]
    }
  }
  
  #print("replace number genos with AGCT......")
  for (r in 1:nrow(hapchr6)) {
    print(r)
    for (c in 4:ncol(hapchr6)) {
      if (hapchr6[r,c]=="0|1" | hapchr6[r,c]=="1|0") {
        hapchr6[r,c]<-paste0(hapchr6[r,2]," ",hapchr6[r,3])
      } else if (hapchr6[r,c]=="0|0") {
        hapchr6[r,c]<-paste0(hapchr6[r,2]," ",hapchr6[r,2])
      } else if (hapchr6[r,c]=="1|1") {
        hapchr6[r,c]<-paste0(hapchr6[r,3]," ",hapchr6[r,3])
      }
    }
  }
  
  #print("remove 2/3 columns")
  hapchr6<-hapchr6[,-c(2,3)]
  rownames(hapchr6)<-hapchr6$POS;hapchr6<-hapchr6[,-1]
  #
  hapchr6<-t(hapchr6)
  hapchr6<-as.matrix(hapchr6);hapchr6[1:5,1:5]
  
  ## freq
  genomatrix<-hapchr6
  hapL<-c()
  hapL_out<-c()
  for(i in 1:nrow(genomatrix)){
    geno<-unlist(strsplit(as.character(genomatrix[i,])," "))
    # get two hap together
    hapL<-c(hapL,paste(geno[seq(1,length(geno),2)],collapse=""))
    hapL<-c(hapL,paste(geno[seq(2,length(geno),2)],collapse=""))
    
    hapL_out<-rbind(hapL_out,t(paste(geno[seq(1,length(geno),2)],sep="\t")))
    hapL_out<-rbind(hapL_out,t(paste(geno[seq(2,length(geno),2)],sep="\t")))
  }
  ##name
  newrownames<-c()
  colnames(hapL_out)<-colnames(genomatrix)
  for ( r in 1:nrow(genomatrix)) {
    newrownames<-c(newrownames,paste0(rownames(genomatrix)[r],".1"),paste0(rownames(genomatrix)[r],".2"))
  }
  rownames(hapL_out)<-newrownames
  ##calculate haplotype frequecies in each pop
  hapL_out2<-as.data.frame(hapL_out)
  hapL_out3<-apply(format(hapL_out2), 1,paste, collapse="")
  hapL_out2$hap1<-hapL_out3
  # LWS40 pop
  hapL_out2$pop<-rownames(hapL_out2)
  dim(hapL_out2)
  a=dim(hapL_out2)[2]
  b=dim(hapL_out2)[2]-1
  c=dim(hapL_out2)[2]-2
  hapL_out2<-hapL_out2[,c(a,b,1:c)]
  ## Get pop names
  for (r in 1:nrow(hapL_out2)) {
    #r=1
    #hapL_out2$pop[r]<-unlist(strsplit(hapL_out2$pop[r],"_"))[1]
    hapL_out2$pop[r]<-paste0(unlist(strsplit(hapL_out2$pop[r],split = ""))[1:3],collapse = "")
    #hapL_out2$pop[r]<-unlist(strsplit(hapL_out2$pop[r],'\\.'))[1]
  }
  ## use hapL_out5 to create haplotype fasta file to do cluster and Plot Heatmap
  hapL_out5<-hapL_out2
  hapL_out5$sample_names<-row.names(hapL_out5)
  hapL_out5$hap_new_name<-NA
  ## rename those haplotypes in HW_LW
  hapL_out4<-hapL_out2[,1:2]
  table_hap<-table(hapL_out4$hap1)
  for (m in 1:length(names(table(hapL_out4$hap1)))) {
    new_hap_name<-paste0("Hap",m)
    #print(new_hap_name)
    pos<-which(hapL_out4$hap1==names(table_hap)[m])
    #print(pos)
    for (rr in pos) {
      #print(rr)
      hapL_out4$hap1[rr]<-new_hap_name
      hapL_out5$hap_new_name[rr]<-new_hap_name
    }
  }
  d=dim(hapL_out5)[2]-1
  e=dim(hapL_out5)[2]
  f=dim(hapL_out5)[2]-2
  hapL_out5<-hapL_out5[,c(1,2,d,e,3:f)]
  ##save hapl_out5 for heatmap(a little tricky to save new variable created by Paste0 function)
  #assign(paste0("Hap_Seq_on_",region,"_",parts,"_from_",left,"_to_",right,"_hapl_out5"),hapL_out5)
  #xx<-paste0("Hap_Seq_on_",region,"_",parts,"_from_",left,"_to_",right,"_hapl_out5")
  #save(list = xx,file = paste(out_dir,xx,".RData",sep = ""))
  ##calculate frequencies
  pop_hap_fre<-melt(t(table(hapL_out4)));pop_hap_fre$Hap_total<-NA
  pop1<-levels(as.factor(pop_hap_fre$pop))
  for (i in 1:length(pop1)) {
    #i=1
    #print(pop1[i])
    pos<-which(pop_hap_fre$pop==pop1[i])
    pop_hap_fre$Hap_total[pos]<-dim(hapL_out4[hapL_out4$pop==pop1[i],])[1]
  }
  ##Frequency of Haplotypes
  pop_hap_fre$Hap_fre=pop_hap_fre$value/pop_hap_fre$Hap_total
  ####################### Save pop_hap_fre #####################
  print("Save pop_hap_fre ......")
  assign(paste0("Hap_Fre_on_",region,"_",parts,"_from_",left,"_to_",right,"_pop_hap_fre"),pop_hap_fre)
  xz<-paste0("Hap_Fre_on_",region,"_",parts,"_from_",left,"_to_",right,"_pop_hap_fre")
  save(list = xz,file = paste(out_dir,xz,".RData",sep = ""))
  ###########################################################################
  
  ####################### Save Hap_Genotypes(Hap_Genos) #####################
  ##save which samples have which haplotypes,like 2132_LWS40.1 has two haplotypes and they are:
  #####2132_LWS40.1 Hap24
  #####2132_LWS40.2 Hap26
  hapL_out4$sample_names<-rownames(hapL_out4)
  print("Save samples with Hapltoype names ......")
  assign(paste0("Hap_Genos_on_",region,"_",parts,"_from_",left,"_to_",right,"_hapL_out4"),hapL_out4)
  xy<-paste0("Hap_Genos_on_",region,"_",parts,"_from_",left,"_to_",right,"_hapL_out4")
  save(list = xy,file = paste(out_dir,xy,".RData",sep = ""))
  ###########################################################################
  print("Plot Haplotype Frequency......")
  pop_hap_fre<-pop_hap_fre %>% filter(Hap_fre>=0.1)
  ggplot(pop_hap_fre,aes(x=pop,y=Hap_fre,group=factor(pop_hap_fre$hap1)))+scale_y_continuous(limits = c(0,0.5))+
    geom_line(aes(col=factor(pop_hap_fre$hap1)))+
    geom_point(aes(col=factor(pop_hap_fre$hap1)))+labs(x="GABRE",y="Haplotype Frequency")+
    annotate("text", x=2.1, y=0.33, label="Hap1[italic(S61)]", size=4,parse=T)+
    theme(plot.title = element_text(hjust = 0.5,size = 10),legend.position = "none",
          axis.title.x = element_text(size = 10),
          axis.title.y = element_text(size = 10),
          axis.text = element_text(size = 10))+scale_color_discrete(name="Haplotypes")
}
