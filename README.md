<h2><p align="center">Exploring the genetic basis of fatty liver development in geese</p></h2>


<h3>Yunzhou Yang<sup>1,2\*</sup>, Huiying Wang<sup>1</sup>, Guangquan Li<sup>1</sup>, Yi Liu<sup>1</sup>, Cui Wang<sup>1</sup>, Daqian He<sup>1\*</sup></h3>

<h3><sup>1</sup>Institute of Animal Husbandry & Veterinary Science, Shanghai Academy of Agricultural Sciences, Shanghai, 201106, P.R. China</h3>

<h3><sup>2</sup>Department of Medical Biochemistry and Microbiology, Uppsala University, Uppsala, 75123, Sweden</h3>

<h3><sup>\*</sup>Corresponding author: daqianhe@aliyun.com, yang.yunzhou@imbim.uu.se </h3>


## Introduction
Migratory birds are physiologically adapted to accumulating large amounts of lipids (more than 50% of their body weight) and efficiently utilising the stored fatty acids to endure flights of many days to arrive at their target habitats. The domestic goose was domesticated from the greylag goose (Anser Anser) or swan goose (Anser Cygnoides), both of which are migratory birds, and its retained ability to accumulate lipids has been the foundation for the establishment of the fatty liver (foie gras) industry.

Although many efforts made to estabalished the underlying mechnism of how geese accumulated such a high amount of lipids and resistance to hepatic steatosis, the underlying formation mechanism remained unclear. In this study, we used genetics, genomics, and transcriptomics to identify genetic variants likely to contribute to high and low fatty liver weights in French Landes geese, which are famous for high susceptibility to steatosis. Several candidate genes involved in lipid metabolism (GABRE and ESRRG), inflammation and fibrosis (IL6), blood lipid regulation (ZFP36L1 and IQCJ), and blood pressure (ARHGEF1) were identified. Genetic variants in candidate genes, for which birds with different liver weights displayed differences in allele frequencies, were tested for associations to blood lipid levels and fatty liver weights. Expression levels of candidate genes were explored. 

In this repositorty, we published our raw data for readers who are interested in our study to repeat them by following the methods in our manusctipt.

## Phenotypes
In our overfeeding analysis, 780 geese were initially selected and 488 of them matched our sampling protocol. These 488 geese were genotyped by 2bRAD method and raw data was uploaded to NCBI under the project of PRJNA631863. According to our methods in manuscript, one can finish variants calling based on these raw data.
In the excel file, people can also find samples (highlighted in yellow) selected for Rsb analysis as these samples had extremely low- and high-FLW/RLW/TG.
  
  - **FLW**: fatty liver weight
  - **RLW**: ratio of FLW in body weight with overfeeding
  - **TG**: triglyceride
  
If you cannot repeat the variants calling steps (it happends because versions or computing machine configurations vary a lot among people), please send an email to us for help or request for the genotype data (yang.yunzhou@imbim.uu.se or daqianhe@aliyun.com).

## GWAS on Pstwt, Prewt and FLW
A standard GWAS on these three traits were carried out by following steps in GenABEL manual. We added sex, farm house/method and worker to our mixed model as fixed effects. These effects were encoded to 0, 1, 2, 3, 4 ... as a factor in model.

 $y = u+sex+worker+house+genotype+e$

Where y is the phenotype to be tested (one of FLW, RLW, Prewt and Pstwt), u is the mean value, sex, worker and house were fixed effects encoded as 0, 1, 2, 3..., genotype refers to genotypes and e means residuals error.

The [GenABEL](https://cran.r-project.org/web/packages/GenABEL/index.html) software was a R packge written for GWAS and related studies. As the authors now stopped the maintenance, one have to spend some time to download the old version and install it under R 3.2. The paper for GenABEL was published by [Yurii *et al* (2007)](https://academic.oup.com/bioinformatics/article/23/10/1294/198080).



## Explained variance by the most significant SNP on scaffold 2
In our phenotype file, there were 11 loci that were found to be related to Pstwt and Prewt on a genome-wide level. People can use the genotype info to calculate variance explained by these SNPs or each of them.
## Haplotype frequency
we have written a new R script to extract haplotypes from phased vcf files and calculate their frequency in each group. People just need input one genotype file (a vcf-like file without annotation lines starting with ##) with some essenctial info.
## Correlations among Phenotypes
One can use **pheno_abl2_488samples_sameorder_with_tped.RData** file to analyse correlations among phenotypes and the R function used in our pipeline is *correlate*.
