# Geese_Fatty_Liver

## Phenotypes
In our overfeeding analysis, 780 geese were initially selected and 488 of them matched our sampling protocol. These 488 geese were genotyped by 2bRAD method and raw data was uploaded to NCBI under the project of PRJNA631863. According to our methods in manuscript, one can finish variants calling based on these raw data.
In the excel file, people can also find samples (highlighted in yellow) selected for Rsb analysis as these samples had extremely low- and high-FLW/RLW/TG.
  
  - FLW: fatty liver weight
  - RLW: ratio of FLW in body weight with overfeeding
  - TG: triglyceride
  
If you cannot repeat the variants calling steps (it happends because versions or computing machine configurations vary a lot among people), please send an email to us for help or request for the genotype data (yang.yunzhou@imbim.uu.se).

## GWAS on Pstwt, Prewt and FLW
A standard GWAS on these three traits were carried out by following steps in GenABEL manual. We added sex, farm house/method and worker to our mixed model as fixed effects. These effects were encoded to 0, 1, 2, 3, 4 ... as a factor in model.

The [GenABEL](https://cran.r-project.org/web/packages/GenABEL/index.html) software was a R packge written for GWAS and related studies. As the authors now stopped the maintenance, one have to spend some time to download the old version and install it under R 3.2. The paper for GenABEL was published by [Yurii *et al* (2007)](https://academic.oup.com/bioinformatics/article/23/10/1294/198080).

## Explained variance by the most significant SNP on scaffold 2
In our phenotype file, there were 11 loci that were found to be related to Pstwt and Prewt on a genome-wide level. People can use the genotype info to calculate variance explained by these SNPs or each of them.
## Haplotype frequency
we have written a new R script to extract haplotypes from phased vcf files and calculate their frequency in each group. People just need input one genotype file (a vcf-like file without annotation lines starting with ##) with some essenctial info.
## Correlations among Phenotypes
One can use **pheno_abl2_488samples_sameorder_with_tped.RData** file to analyse correlations among phenotypes and the R function used in our pipeline is *correlate*.
