
setwd("/media/D10/EXOS/ST_LUNG_HUMAN/10x_lung_prev/malig/lung_cancer/process")

library(Seurat)

packageVersion("Seurat")
# [1] ‘5.1.0’
packageVersion("SeuratObject")
# [1] ‘5.0.2’

xenium_lc <- LoadXenium(
  data.dir = "../outs",,
  fov = "fov"
)

# Error in `CreateAssayObject()`:
#   ! No cell names (colnames) names present in the input matrix
# Run `rlang::last_trace()` to see where the error occurred.

# update seurat to 5.6.0
# install.packages("Seurat")

# data profile ----
dim(xenium_lc)

# [1]    480 162254

summary(xenium_lc$nCount_Xenium)

xenium_lc <- subset(xenium_lc, subset = nCount_Xenium > 0)

dim(xenium_lc)
# [1]    480 160448

# vis feature ----

ImageDimPlot(
  xenium_lc,
  fov = "fov",
  group.by = "orig.ident",
  molecules = "TNC",
  nmols = 20000,
)
# 
# ImageDimPlot(
#   xenium_lc,
#   fov = "fov",
#   group.by = "seurat_clusters",
#   border.color = "white",
#   border.size = 0.1
# )

# process ----
options(future.globals.maxSize = 1000 * 1024^2)
xenium_lc <- SCTransform(xenium_lc, assay = "Xenium")
xenium_lc <- RunPCA(xenium_lc, npcs = 30, features = rownames(xenium_lc))
xenium_lc <- RunUMAP(xenium_lc, dims = 1:30)
xenium_lc <- FindNeighbors(xenium_lc, reduction = "pca", dims = 1:30)
xenium_lc <- FindClusters(xenium_lc, resolution = 0.3)

# vis cluster ----

p <- DimPlot(
  xenium_lc,
  label = T, repel = T
)

library(ggplot2)

ggsave(
  filename = "dim_plot_sc.png",
  plot = p,
  width = 1800,
  height = 1500,
  units = "px",
  dpi = 300
)

# DimPlot(subset(xenium_lc, idents = 2), reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()

# table(xenium_lc$seurat_clusters)
p <- ImageDimPlot(xenium_lc, cols = "polychrome", size = 0.75)

ggsave(
  filename = "image_dim_plot_sc.png",
  plot = p,
  width = 1200,
  height = 2100,
  units = "px",
  dpi = 300
)

# deg ----

markers <- FindAllMarkers(xenium_lc, only.pos = T)
library(openxlsx)
library(dplyr)
wb <- createWorkbook()
clusters <- unique(markers$cluster)
for (cluster in clusters) {
  cluster_xenium_lc <- markers %>% dplyr::filter(cluster == !!cluster)
  addWorksheet(wb, sheetName = paste0("C", cluster))
  writeData(wb, sheet = paste0("C", cluster), cluster_xenium_lc)
}
saveWorkbook(wb, "20261103_markers_clusters_xenium_lc_res_0.3.xlsx", overwrite = TRUE)
rm(wb, cluster, clusters, cluster_xenium_lc, markers)

# profiling ----

# DotPlot(xenium_lc, 
#         c(
#           "TIGIT", "SCGB3A2", "ACTA2", "PECAM1", "RGS5", 
#           "MZB1", "CD3E", "NAPSA", "COL1A1", "ITGBL1",
#           "SPP1"))
# 
FeaturePlot(xenium_lc, "nFeature_Xenium")
# DotPlot(xenium_lc, "nFeature_Xenium")
# VlnPlot(xenium_lc, "nFeature_Xenium")
# VlnPlot(xenium_lc, "nCount_Xenium", group.by = "seurat_clusters")
# 
# FeaturePlot(xenium_lc, "SFTPC")
FeaturePlot(xenium_lc, "EPCAM")
FeaturePlot(xenium_lc, "MUC5AC")
FeaturePlot(xenium_lc, "MET")
# FeaturePlot(xenium_lc, "CCL21")

# vis subset ----

library(pals)
n <- as.integer(as.character(unique(xenium_lc$seurat_clusters)))
polychrome_colors <- pals::polychrome(max(n) + 1)

ImageDimPlot(subset(xenium_lc, idents = 0), cols = polychrome_colors[[1]], size = 0.75)

ids <- 0:max(n)
# polychrome_colors[[1]]

output_dir <- "./plots"

dir.create(
  output_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

library(ggplot2)

for (i in ids) {
  color <- polychrome_colors[[i + 1]]
  p <- ImageDimPlot(subset(xenium_lc, idents = i), cols = color, size = 0.75)
  filename <- file.path(
    output_dir,
    paste0("ImageDimPlot_cluster_", i, ".png")
  )
  ggsave(filename, plot = p, width = 10, height = 10, dpi = 300)
}

# annotation ----
new.cluster.ids <- c(
  "",
  "", "", "", "", "",
  "", "", "", "", "",
  "", "", "", "", "",
  "", ""
)

xenium_lc@active.ident <- xenium_lc$seurat_clusters
new.cluster.ids <- c(
  "epi",
  "nkt", "mph", "endo", "epi?", "epi?",
  "plasma", "fib", "low_feat_cell", "endo?", "fib?",
  "b", "Tfh_CXCL13_region", "plasma", "lymph_endo", "mast",
  "epi?"
)

names(new.cluster.ids) <- levels(xenium_lc)
xenium_lc <- RenameIdents(xenium_lc, new.cluster.ids)
DimPlot(xenium_lc, reduction = "umap", label = TRUE, pt.size = 0.5)

ggsave(
  filename = "image_dim_plot_annotated_xenium_lc.png",
  plot = ImageDimPlot(
    xenium_lc,
    fov = "fov",
    # group.by = "seurat_clusters",
    border.color = "white",
    border.size = 0.1
  ),
  width = 2400,
  height = 2400,
  units = "px",
  dpi = 300
)

xenium_lc$annotation <- Idents(xenium_lc)

# ImageDimPlot(subset(xenium_lc, idents = "epi"), cols = polychrome_colors[[2]], size = 0.75)
# ImageDimPlot(subset(xenium_lc, annotation %in% c("AT2_like", "club_like", "fib")), size = 0.75)
# ImageDimPlot(subset(xenium_lc, annotation %in% c("epi", "fib", "goblet_like", "endo")), size = 0.75)
ImageDimPlot(subset(xenium_lc, annotation %in% c("epi", "fib", "t")), size = 0.75)
# ImageDimPlot(subset(xenium_lc, annotation %in% c("Tfh_CXCL13_region", "mph_SPP1", "CXCL9_region", "mph")), size = 0.75)
# ImageDimPlot(subset(xenium_lc, annotation %in% c("mph_SPP1")), size = 0.75)

saveRDS(xenium_lc, "xenium_lc.rds")

# csv anno ----

create_xenium_annotation(
  seurat_obj = xenium_lc,
  annotation_col = "seurat_clusters",
  output_file = "xenium_lc_by_seu_clusters_res_0.3.csv"
)

create_xenium_annotation(
  seurat_obj = xenium_lc,
  annotation_col = "annotation",
  output_file = "xenium_lc_by_annotation.csv"
)
