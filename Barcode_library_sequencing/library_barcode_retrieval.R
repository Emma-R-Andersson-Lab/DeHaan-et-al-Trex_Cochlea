## Extraction of barcodes from viral barcode library sequencing ---

# The raw fastq file was filtered with cutadapt to extract 50 nt reads.
# 50 nt sequences contain 30nt barcode region and 10nt conserved sequences on each side of the barcode.

# Next, we filter the fastq file on base quality using seqTools:trimFastq function:
# Discard the sequences where more than 2 bases have quality < 15


seqTools::trimFastq("input_data/viral_lib_50nt.fq.gz",
  outfile = "output_data/filtered.fq.gz", 
  discard = "output_data/discarded.fq.gz",
  qualDiscard = 15)

# Next, we extract 30N barcodes using package genBaRcode

# load library
library(genBaRcode)

# define the backbone (10 bases before and after the 30N barcode)
backbone <- "TCTAAATGCANNNNNNNNNNNNNNNNNNNNNNNNNNNNNNCTTTAAGACC"

# define source and result directory:
source_dir 
result_dir 

# extracted barcodes will be saved into an S4 object

BC_data <- processingRawData(file_name = "filtered.fq.gz",
                             source_dir = source_dir,
                             results_dir = result_dir,
                             mismatch = 1, #to the backbone
                             min_score = 0,
                             min_reads = 0, #important, otherwise, automatic cutoff >2
                             label = "genBaRcode",
                             bc_backbone = backbone,
                             bc_backbone_label = "BC_1",
                             save_it = FALSE,
                             seqLogo = FALSE,
                             cpus = 1,
                             strategy = "sequential",
                             full_output = FALSE,
                             wobble_extraction = TRUE)

# get a glimpse on the data object
show(BC_data)

# save as R object
saveRDS(BC_data, file = "output_data/viral_lib_extracted_barcodes.RDS")

#extract barcodes and their counts:
bc_table <- BC_data@reads

# bc_table is saved as a .csv file *extracted_barcodes_viral.csv*

## QC plots ----

library(ggplot2)

# frequency plots

freq <- plotReadFrequencies(BC_dat = BC_data)
freq + ggplot2::theme_minimal()

kirchen <- generateKirchenplot(BC_dat = BC_data)
kirchen + ggplot2::theme_classic()


# Lorenz curve and Gini coefficient

library(ineq)

ineq(bc_table$read_count,type="Gini")
lc_v <- Lc(bc_table$read_count)
plot(lc_v) 

# Sequence logo

# generate a random sample of 100 000 barcodes and plot seqLogo plot

vector <- as.vector(sample(bc_table$barcode, 100000))
base_colors <- c("forestgreen", "darkred","royalblue", "orange","grey" )

plotSeqLogo(vector, colrs = base_colors)


# Hamming distance 

# Hamming distance where within a sample, all sequences are compared to each other

library(dplyr)

l <- 1000

set.seed(123)
col_hd <- sample(bc_table$barcode, l)
row_hd <- col_hd


hd <- data.frame(matrix(NA, nrow = length(row_hd),
                        ncol = length(col_hd), dimnames = list(row_hd, col_hd)))

for (i_row in 1:length(row_hd)){
  for (j_col in 1:length(col_hd)){ #place i_row+1 instead "1:length(col_hd, this way I never check the barcode against itself"
    hd[i_row, j_col] <- sum(strsplit(rownames(hd)[i_row], "")[[1]] != strsplit(colnames(hd)[j_col], "")[[1]]) 
  }
}

library(pheatmap)

pheatmap(hd, 
         show_rownames = FALSE,
         show_colnames = FALSE, 
         treeheight_col = 0,
         treeheight_row = 0)

# Plot a histogram of calculated hamming distances 

hd_df <- data.frame()

for (i in 1:1000){
  step_df <- data.frame(values = c(hd[, i]))
  hd_df <- rbind(hd_df, step_df)
}
  
# there is a line of zeros in the matrix becuase barcodes are compare to themselves
# if all the zero Hamming distances come from this, there will be 1000 zeros:

hd_df |>
  filter(values < 15) |>
  summarise(n = n())

# this is correct so we filter these out from the dataset:

hd_df |>
  filter(values > 0) |>
  ggplot(aes( x= values))+
  geom_histogram(bins = 15, color="darkgrey", fill="grey")+
  theme_minimal()+
  xlim(0, NA)+
  xlab("Hamming distance")



