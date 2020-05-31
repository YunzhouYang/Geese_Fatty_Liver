# Geese_Fatty_Liver

## Phenotypes
In our overfeeding analysis, 780 geese were initially selected and 488 of them matched our sampling protocol. These 488 geese were genotyped by 2bRAD method and raw data was uploaded to NCBI with the project number of PRJNA631863. According to our method in manuscript, one can finish variants calling based on these raw data.
If you cannot make it and please send a email to us for help or request for the genotype data (yang.yunzhou@imbim.uu.se).
## GWAS on Pstwt, Prewt and FLW
A standard GWAS on these three traits were carried out following steps in GenABEL manual. We added sex, farm house/method and worker to our mixed model as fixed effects.

## Explained variance by the most significant SNP on scaffold 2
In our phenotype file, there were 11 loci that were found to be related to Pstwt and Prewt on a genome-wide level. People can use the genotype info to calculate variance explained by these SNPs or each of them.
## Haplotype frequency
we have written a new R script to extract haplotypes from phased vcf files and calculate their frequency in each group. People just need input one genotype file (a vcf-like file without annotation lines starting with ##) with some essenctial info.
## Correlations among Phenotypes
One can use **pheno_abl2_488samples_sameorder_with_tped.RData** file to analyse correlations among phenotypes and the R function used in our pipeline is *correlate*.
