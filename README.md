<h2><p align="center">Exploring the genetic basis of fatty liver development in geese</p></h2>


<h5><p align="center">Yunzhou Yang<sup>1,2<code>&ast;</code></sup>, Huiying Wang<sup>1</sup>, Guangquan Li<sup>1</sup>, Yi Liu<sup>1</sup>, Cui Wang<sup>1</sup>, Daqian He<sup>1<code>&ast;</code></sup></p></h5>

<h5><sup>1</sup>Institute of Animal Husbandry & Veterinary Science, Shanghai Academy of Agricultural Sciences, Shanghai, 201106, P.R. China</h5>

<h5><sup>2</sup>Department of Medical Biochemistry and Microbiology, Uppsala University, Uppsala, 75123, Sweden</h5>

<h5><sup><code>&ast;</code></sup>Corresponding author: daqianhe@aliyun.com, yang.yunzhou@imbim.uu.se </h5>


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

######################## **Remember to Phase your Genotypes** ####################

## GWAS on Pstwt, Prewt and FLW
A standard GWAS on these three traits were carried out by following steps in GenABEL manual. We added sex, farm house/method and worker to our mixed model as fixed effects. These effects were encoded to 0, 1, 2, 3, 4 ... as a factor in model.

<img src="https://render.githubusercontent.com/render/math?math=y = u %2B sex %2B worker %2B house %2Be ">

Where y is the phenotype to be tested (one of FLW, RLW, Prewt and Pstwt), u is the mean value, sex, worker and house were fixed effects encoded as 0, 1, 2, 3..., genotype refers to genotypes and e means residuals error.

The [GenABEL](https://cran.r-project.org/web/packages/GenABEL/index.html) software was a R packge written for GWAS and related studies. As the authors now stopped the maintenance, one have to spend some time to download the old version and install it under R 3.2. The paper for GenABEL was published by [Yurii *et al* (2007)](https://academic.oup.com/bioinformatics/article/23/10/1294/198080).

## How to get the scaffold names when GWAS are done
We renamed the scaffold names by sorting in decreasing order which made the Manhattan Plot more readable. The full chart including new and original scaffold names were stored in the file **GCF_000971095.1_AnsCyg_PRJNA183603_v1.0_assembly_report_scallfold_size_Chartr2Numbr.txt**.

## Explained variance by the most significant SNP on scaffold 2
In our phenotype file, there were 11 loci that were found to be related to Pstwt and Prewt on a genome-wide level. People can use the genotype info to calculate variance explained by these SNPs or each of them by following the model:

<img src="https://render.githubusercontent.com/render/math?math=y = u %2B sex %2B worker %2B house %2B%11loci 2Be ">

Where y, u, sex, house, worker and e were same as in formula (1), 11 loci were depostied in gentoype file and encoded as 0, 1 and 2 (see the file: **pheno_abl4_488_Github.xlsx**). The following figure was obtained from our R script:

[Exp.Var](https://www.dropbox.com/s/3v4tmx16dom87dj/Explained_Variance_and_bodplot_11846729.jpg?dl=0)


## Haplotype frequency
We have written a new R script to extract haplotypes from phased vcf files and calculate their frequency in each group. People just need input one genotype file (a vcf-like file without annotation lines starting with ##) with some essential info.
  - GT file: the vcf-like file by removing lines starting with ##.
  - region: scaffold name.
  - parts: locations or genes.
  -left & right: locations (integer).
  - out_dir: folder to store results.
  
This function will produce:
  - Haplotype frequency file: startingwith *HapFre...*
  - Genotype files including copies of haplotype for each individual: *HapGenos...*
  - Haplotype sequences: *HapSeq...*
  - The figure showing haplotype frequency in both low and high FLW/RLW/TG groups.

## Correlations among Phenotypes
One can use **pheno_abl2_488samples_sameorder_with_tped.RData** file to analyse correlations among phenotypes and the R function used in our pipeline is *correlate*. Main steps were:
  - Load our RData file.
  - install and load the package *corrr* and *lsr*.
  - Prepare the raw data according to the formats in *lsr* package.
  - Use *correlate* function in *lsr* package to produce correlationships matrix.
  - The function *network_plot* in package *corrr* was used to produce figures here.
  
[Corr.Curves](https://www.dropbox.com/s/h5qeyvelhz6zjjj/Figure%201%20Correlations_among_BCIs_WIs_and_GeneticCorrelationships_600dpi.pdf?dl=0)
