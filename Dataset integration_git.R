

library(Seurat)
library(dplyr)
library(ggplot2)
library(patchwork)
library(sctransform)
library(scDblFinder)
library(SingleCellExperiment)
library(glmGamPoi)



T1_P25552_1001_SCT<- readRDS("T1_P25552_1001_SCT.RDS")
T2_P28155_1001_SCT<- readRDS("T2_P28155_1001_SCT.RDS")
T2_P28155_1002_SCT<- readRDS("T2_P28155_1002_SCT.RDS")
T2_P28155_1003_SCT<- readRDS("T2_P28155_1003_SCT.RDS")
T2_P28155_1004_SCT<- readRDS("T2_P28155_1004_SCT.RDS")


T1_P25552_1001_SCT_10 <- subset(T1_P25552_1001_SCT, subset = percent.mt < 10)
T2_P28155_1001_SCT_10 <- subset(T2_P28155_1001_SCT, subset = percent.mt < 10)
T2_P28155_1002_SCT_10 <- subset(T2_P28155_1002_SCT, subset = percent.mt < 10)
T2_P28155_1003_SCT_10 <- subset(T2_P28155_1003_SCT, subset = percent.mt < 10)
T2_P28155_1004_SCT_10 <- subset(T2_P28155_1004_SCT, subset = percent.mt < 10)

T1_P25552_1001_SCT_10<- SCTransform(T1_P25552_1001_SCT_10, vst.flavor = "v2", vars.to.regress = "percent.mt", verbose = FALSE)
T2_P28155_1001_SCT_10 <- SCTransform(T2_P28155_1001_SCT_10, vst.flavor = "v2", vars.to.regress = "percent.mt", verbose = FALSE)
T2_P28155_1002_SCT_10 <- SCTransform(T2_P28155_1002_SCT_10, vst.flavor = "v2", vars.to.regress = "percent.mt", verbose = FALSE)
T2_P28155_1003_SCT_10 <- SCTransform(T2_P28155_1003_SCT_10, vst.flavor = "v2", vars.to.regress = "percent.mt", verbose = FALSE)
T2_P28155_1004_SCT_10 <- SCTransform(T2_P28155_1004_SCT_10, vst.flavor = "v2", vars.to.regress = "percent.mt", verbose = FALSE)

T1_P25552_1001_SCT_10$sampleID <- "P25552_1001"
T2_P28155_1001_SCT_10$sampleID <- "P28155_1001"
T2_P28155_1002_SCT_10$sampleID <- "P28155_1002"
T2_P28155_1003_SCT_10$sampleID <- "P28155_1003"
T2_P28155_1004_SCT_10$sampleID <- "P28155_1004"

Dataset.list <- list("T1_P25552_1001_SCT_10"=T1_P25552_1001_SCT_10, "T2_P28155_1001_SCT_10"=T2_P28155_1001_SCT_10, "T2_P28155_1002_SCT_10"=T2_P28155_1002_SCT_10, "T2_P28155_1003_SCT_10" = T2_P28155_1003_SCT_10, "T2_P28155_1004_SCT_10" =T2_P28155_1004_SCT_10)

features <- SelectIntegrationFeatures(object.list = Dataset.list, nfeatures = 3000)
Dataset.list <- PrepSCTIntegration(object.list = Dataset.list, anchor.features = features)

dataset.anchors <- FindIntegrationAnchors(object.list = Dataset.list, normalization.method = "SCT",
    anchor.features = features)

Trex_mt10 <- IntegrateData(anchorset = dataset.anchors, normalization.method = "SCT")

Trex_mt10 <- RunPCA(Trex_mt10, verbose = FALSE)
Trex_mt10 <- RunUMAP(Trex_mt10, reduction = "pca", dims = 1:50, verbose = FALSE)
Trex_mt10 <- FindNeighbors(Trex_mt10, reduction = "pca", dims = 1:50)
Trex_mt10 <- FindClusters(Trex_mt10, resolution = 0.5)

saveRDS(Trex_mt10, file = "Trex_mt10.RDS")
saveRDS(T1_P25552_1001_SCT_10, file ="T1_P25552_1001_SCT_10.RDS") 
saveRDS(T2_P28155_1001_SCT_10, file ="T2_P28155_1001_SCT_10.RDS")
saveRDS(T2_P28155_1002_SCT_10, file ="T2_P28155_1002_SCT_10.RDS")
saveRDS(T2_P28155_1003_SCT_10, file ="T2_P28155_1003_SCT_10.RDS")
saveRDS(T2_P28155_1004_SCT_10, file ="T2_P28155_1004_SCT_10.RDS")

