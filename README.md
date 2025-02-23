# De Haan & He et al, Ectoderm barcoding reveals neural and cochlear compartmentalization  

This repository accompanies De Haan & He et al. publication, where we performed Next generation single cell lineage tracing of mouse ectoderm with in utero barcode delivery. 

The barcode lineage tracing ananlysis was adapted from [**TREX**](https://github.com/frisen-lab/TREX).

## Workflow
Following notebooks describe the steps of the analysis:
- Extract CellIDs from individual Seurat objects needed for CloneID extraction using the Trex algorithm: [notebook #1](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%231%20CellID%20extraction%20before%20Trex_git.Rmd)
- Integrate various scRNAseq datasets using SCTransform (including QC and clustering): [notebook #2](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%232%20Dataset%20integration_git.R)
- How to add the CloneIDs from the Trex output back to the Seurat object: [notebook #3](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%233%20Adding%20cloneIDs%20to%20Seurat%20object_git.Rmd)
- Visualisation including Upset plots, Circos plots (as in Fig4 paper, [notebook #4](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%234%20Upset%20and%20Circos%20plots%20Fig2.Rmd)) and ClonalCoupling/Lineage Trees (as in Fig5 paper, [notebook #5](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%235%20Clonal%20coupling%202024_git.ipynb))
- [Visualisation for Fig1 and Fig2](https://github.com/Emma-R-Andersson-Lab/E9.5-and-E10.5-embryo-lineage-tracing)
- Jaccard threshold sweep to determine the treshold: [notebook #6](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%236%20Jaccard%20Threshold%20Sweep.ipynb) (see section [Jaccard Threshold Parameter Sweep](#jaccard-threshold-paramater-sweep) for installing instructions)


**Overview** of required files and flow of CloneID extraction and addition to Seurat object.  
CloneIDs are added back to Seurat object as described in notebook #3  
  

  
![Flow CloneID extraction_git](https://github.com/user-attachments/assets/330d53ce-868d-4dbb-9e72-bf41b6681594)

## Additional analyses

### Barcode library characterization 
To flag barcodes that are over-represented in a 30N barcode library and could potentially confound clonal analysis, we sequenced and analysed barcode libraries either from  
- [viral prep](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/tree/main/Barcode_library_sequencing)  
- or [plasmid prep](https://github.com/Emma-R-Andersson-Lab/He_et_al_Lineage_tracing/tree/main/Barcode_library_sequencing).

## Tonotopy analysis
To classify inner ear cells according to their anatomical region of origin, we performed a tonotopy analysis (Fig. 5).  
See the dedicated [repository](https://github.com/Emma-R-Andersson-Lab/deHaan_Apex_vs_Base_2024).

## Jaccard Threshold Parameter Sweep
You can look into the [#6 Jaccard Threshold Sweep](https://github.com/Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea/blob/301fc95f8645f4abe64464952f432263ee3e66bb/%236%20Jaccard%20Threshold%20Sweep.ipynb) notebook to see how we chose the threshold or you can follow the instructions below to run it.

To run it, you will need to download and install conda (preferably from [MINIFORGE](https://github.com/conda-forge/miniforge#download)). 
Then clone this repository and install it.

```
git clone git@github.com:Emma-R-Andersson-Lab/DeHaan-et-al-Trex_Cochlea.git
cd DeHaan-et-al-Trex_Cochlea
conda env create -f environment.yml
```

Once it is installed, activate it and install TREX as we will need its helper functions.
Finally run jupyter lab to open the notebook and run the cells.

*Note: the `--no-deps` parameter is only needed in Windows.*

```
conda activate trex_cochlea
pip install git+https://github.com/frisen-lab/TREX.git --no-deps
jupyter lab
```


## License

[GNU GPL 3.0](LICENSE)

## Contact

Open an issue in this repository.
