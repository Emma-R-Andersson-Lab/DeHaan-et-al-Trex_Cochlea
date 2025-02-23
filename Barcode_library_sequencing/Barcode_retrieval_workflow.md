## Barcode retrieval and analysis workflow

In order to flag barcodes that are over-represented in a 30N barcode library and could potentially confound clonal analysis, we amplified and DNA-sequenced the barcode region. 

### Library preparation
The barcode region with adjacent sequences was amplified to prepare an amplicon sequencing library (according to Ratz et al. Nature Neuroscience, 2022). The library was sequenced on Illumina NextSeq550 instrument. For further technical details, see https://doi.org/10.5281/zenodo.14223303 or the methods section in the publication.

### Fastq file pre-processing

Sequencing output **viral_R1.fastq.gz** was processed with Cutadapt (version 4.0) with Python 3.9.5 to selects reads that contain 30N barcode with 10 nt flanking conserved sequences on each side, reducing thus the length of the read to the most informative region.

Cutadapt command line parameters: -g GAGGAAAG...AATGACTT --max-expected-errors=1 --discard-untrimmed --minimum-length=50 --maximum-length=50

### Barcode extraction 

The resulting file *viral_lib_50nt.fq.gz* was processed in R with ```viral_library_barcode_retrieval.R``` script. 
In the script, the sequences are further filtered for high quality bases and barcodes are retrieved with GenBaRcode package function.
The script also contains preliminary QC plots. 
The used packages are recorded in the text file ```R_session_info.txt```.

The output file is saved as ```extracted_barcodes_viral.csv``` which contains a list of retrieved barcodes and their count.

### Barcode analysis

Extracted barcodes were further analyzed using the ```library_quality_control.py```.

### Files deposited at Zenodo

The raw sequencing file **viral_R1.fastq.gz** and extracted barcodes **extracted_barcodes_viral.csv** are available for download at [https://doi.org/10.5281/zenodo.14223303]
