# De Haan et al, Otic placode and neural crest barcoding reveals cochlear compartmentalization 

This repository contains instructions to 
- extract CellIDs from individual Seurat objects needed for CloneID extraction using the Trex algorithm (notebook #1)
- Integrate various scRNAseq datasets using SCTransform (including QC and clustering) (notebook #2)
- how to add the CloneIDs from the Trex output back to the Seurat object (notebook #3)
- visualisation including Upset plots, Circos plots (as in Fig2 paper, notebook #4)  and ClonalCoupling/Lineage Trees (as in Fig3 paper, notebook #5)


Overview of required files and flow of CloneID extraction and addition to Seurat object. CloneIDs are added back to Seurat object as described in notebook #3
  
![Flow CloneID extraction_git](https://github.com/user-attachments/assets/330d53ce-868d-4dbb-9e72-bf41b6681594)
