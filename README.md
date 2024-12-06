# De Haan et al, Otic placode and neural crest barcoding reveals cochlear compartmentalization 

Pre-analysis library characterisation of barcodes can be found at https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/tree/main/Barcode_library_sequencing
General information on the Trex algorithm can be found at https://github.com/frisen-lab/TREX. 


This repository contains instructions to 
- extract CellIDs from individual Seurat objects needed for CloneID extraction using the Trex algorithm (notebook #1)
- Integrate various scRNAseq datasets using SCTransform (including QC and clustering) (notebook #2)
- how to add the CloneIDs from the Trex output back to the Seurat object (notebook #3)
- visualisation including Upset plots, Circos plots (as in Fig2 paper, notebook #4)  and ClonalCoupling/Lineage Trees (as in Fig3 paper, notebook #5)
- please see https://github.com/Emma-R-Andersson-Lab/deHaan_Apex_vs_Base_2024 for the tonotopy analysis as shown in Fig3D-H


Overview of required files and flow of CloneID extraction and addition to Seurat object. CloneIDs are added back to Seurat object as described in notebook #3
  
![Flow CloneID extraction_git](https://github.com/user-attachments/assets/330d53ce-868d-4dbb-9e72-bf41b6681594)

## Jaccard Threshold Parameter Sweep

You can look into the [#6 Jaccard Threshold Sweep](#6 Jaccard Threshold Sweep.ipynb) notebook to see how we chose the threshold or you can follow the instructions below to run it.

To run it, you will need to download and install conda (preferably from [MINIFORGE](https://github.com/conda-forge/miniforge#download)). 
Then clone this repository and install it.

```
git clone git@github.com:Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea.git
cd DeHaan-et-al-Trex_Cochlea
conda env create -f environment.yml
```

Once it is installed, activate it and install TREX as we will need its helper functions.
Finally run jupyter lab to open the notebook and run the cells.

```
conda activate trex_cochlea
pip install git+https://github.com/frisen-lab/TREX.git --no-deps
jupyter lab
```
