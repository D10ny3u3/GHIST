# ref /media/D10ny3u3/EXOS/ST_LUNG_HUMAN/2025_Vannan_IPF/RAW_DATA/Control/THD0008/xenium.R

setwd("/media/D10ny3u3/EXOS/ST_LUNG_HUMAN/10x_lung_prev/luad/process")

library(Seurat)

packageVersion("Seurat")
packageVersion("SeuratObject")

args(Seurat::LoadXenium)

xenium_luad <- LoadXenium(
  data.dir = "/media/D10ny3u3/EXOS/ST_LUNG_HUMAN/10x_lung_prev/luad/outs",
  fov = "fov"
)

# data profile ----
dim(xenium_luad)
# [1]    377 162254

summary(xenium_luad$nCount_Xenium)

xenium_luad <- subset(xenium_luad, subset = nCount_Xenium > 0)

dim(xenium_luad)
# [1]    377 161894

# vis feature ----

ImageDimPlot(
  xenium_luad,
  fov = "fov",
  group.by = "orig.ident",
  molecules = "TNC",
  nmols = 20000,
)
# 
# ImageDimPlot(
#   xenium_luad,
#   fov = "fov",
#   group.by = "seurat_clusters",
#   border.color = "white",
#   border.size = 0.1
# )

# process ----
options(future.globals.maxSize = 1000 * 1024^2)
xenium_luad <- SCTransform(xenium_luad, assay = "Xenium")
xenium_luad <- RunPCA(xenium_luad, npcs = 30, features = rownames(xenium_luad))
xenium_luad <- RunUMAP(xenium_luad, dims = 1:30)
xenium_luad <- FindNeighbors(xenium_luad, reduction = "pca", dims = 1:30)
xenium_luad <- FindClusters(xenium_luad, resolution = 0.3)

# vis cluster ----

png("dimplot_xenium_luad.png", width = 1800, height = 1500, units = "px", res = 300)
DimPlot(xenium_luad, label = T, repel = T)
dev.off()
# DimPlot(subset(xenium_luad, idents = 2), reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()

# table(xenium_luad$seurat_clusters)
ImageDimPlot(xenium_luad, cols = "polychrome", size = 0.75)

# deg ----
markers <- FindAllMarkers(xenium_luad, only.pos = T)
library(openxlsx)
library(dplyr)
wb <- createWorkbook()
clusters <- unique(markers$cluster)
for (cluster in clusters) {
  cluster_xenium_luad <- markers %>% dplyr::filter(cluster == !!cluster)
  addWorksheet(wb, sheetName = paste0("C", cluster))
  writeData(wb, sheet = paste0("C", cluster), cluster_xenium_luad)
}
saveWorkbook(wb, "20261102_markers_clusters_xenium_luad_res_0.3.xlsx", overwrite = TRUE)
rm(wb, cluster, clusters, cluster_xenium_luad, markers)

# profiling ----

# DotPlot(xenium_luad, 
#         c(
#           "TIGIT", "SCGB3A2", "ACTA2", "PECAM1", "RGS5", 
#           "MZB1", "CD3E", "NAPSA", "COL1A1", "ITGBL1",
#           "SPP1"))
# 
FeaturePlot(xenium_luad, "nFeature_Xenium")
# DotPlot(xenium_luad, "nFeature_Xenium")
# VlnPlot(xenium_luad, "nFeature_Xenium")
# VlnPlot(xenium_luad, "nCount_Xenium", group.by = "seurat_clusters")
# 
# FeaturePlot(xenium_luad, "SFTPC")
DotPlot(xenium_luad, c("WNT2", "FGFR4", "PI16", "ACTA2"))
# FeaturePlot(xenium_luad, "TNC")
# FeaturePlot(xenium_luad, "SCGB3A2")
# FeaturePlot(xenium_luad, "CCL21")

# vis subset ----
library(pals)
n <- as.integer(as.character(unique(xenium_luad$seurat_clusters)))
polychrome_colors <- pals::polychrome(max(n) + 1)

# ImageDimPlot(subset(xenium_luad, idents = 0), cols = polychrome_colors[[1]], size = 0.75)

ids <- 0:max(n)
# polychrome_colors[[1]]

output_dir <- "/media/D10ny3u3/EXOS/ST_LUNG_HUMAN/10x_lung_prev/luad/process/plots"

dir.create(
  output_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

library(ggplot2)

for (i in ids) {
  color <- polychrome_colors[[i + 1]]
  p <- ImageDimPlot(subset(xenium_luad, idents = i), cols = color, size = 0.75)
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

xenium_luad@active.ident <- xenium_luad$seurat_clusters
new.cluster.ids <- c(
  "epi",
  "epi", "nkt", "fib", "epi", "mph",
  "endo", "plasma", "b", "fib", "mast",
  "epi", "cil", "normal_epi"
)

names(new.cluster.ids) <- levels(xenium_luad)
xenium_luad <- RenameIdents(xenium_luad, new.cluster.ids)
DimPlot(xenium_luad, reduction = "umap", label = TRUE, pt.size = 0.5)

ggsave(
  filename = "image_dim_plot_annotated_xenium_luad.png",
  plot = ImageDimPlot(
    xenium_luad,
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

xenium_luad$annotation <- Idents(xenium_luad)

# ImageDimPlot(subset(xenium_luad, idents = "epi"), cols = polychrome_colors[[2]], size = 0.75)
# ImageDimPlot(subset(xenium_luad, annotation %in% c("AT2_like", "club_like", "fib")), size = 0.75)
# ImageDimPlot(subset(xenium_luad, annotation %in% c("epi", "fib", "goblet_like", "endo")), size = 0.75)
ImageDimPlot(subset(xenium_luad, annotation %in% c("epi", "fib", "t")), size = 0.75)
# ImageDimPlot(subset(xenium_luad, annotation %in% c("Tfh_CXCL13_region", "mph_SPP1", "CXCL9_region", "mph")), size = 0.75)
# ImageDimPlot(subset(xenium_luad, annotation %in% c("mph_SPP1")), size = 0.75)

# zoom 1 ----

p_full <- ImageDimPlot(xenium_luad, fov = "fov", molecules = NULL, size = 0.5) +
  annotate("rect", 
           xmin = 1800, xmax = 2400,
           ymin = 3000, ymax = 3600,
           fill = NA, color = "red", linewidth = 1) +
  ggtitle("Selected (Red rectangle)")
p_full

cropped.coords <- Crop(xenium_luad[["fov"]], x = c(1800, 2400), y = c(3000, 3600), coords = "plot")
xenium_luad[["zoom"]] <- cropped.coords
DefaultBoundary(xenium_luad[["zoom"]]) <- "segmentation"
ImageDimPlot(xenium_luad, fov = "zoom", axes = TRUE, border.color = "white", border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "orig.ident",
             nmols = 50000)
ImageDimPlot(xenium_luad, fov = "zoom", axes = TRUE, border.color = "white", border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             molecules = c("GJA5"),
             group.by = "orig.ident",
             nmols = 50000)
ImageDimPlot(subset(xenium_luad, annotation %in% c("AT2_like", "club_like")), 
             fov = "zoom", axes = TRUE, border.color = "white", 
             border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "orig.ident",
             nmols = 50000)

ImageDimPlot(subset(xenium_luad, annotation %in% c("endo", "fib", "fib_SYNPO2", "fib_PI16", "endo_art")), 
             fov = "zoom", axes = TRUE, border.color = "white", 
             border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "orig.ident",
             nmols = 50000)


# zoom 2 ----

p_full <- ImageDimPlot(xenium_luad, fov = "fov", molecules = NULL, size = 0.5) +
  annotate("rect", 
           xmin = 1000, xmax = 1600,
           ymin = 2900, ymax = 3500,
           fill = NA, color = "red", linewidth = 1) +
  ggtitle("Selected (Red rectangle)")
p_full

cropped.coords <- Crop(xenium_luad[["fov"]], x = c(1000, 1600), y = c(2900, 3500), coords = "plot")
xenium_luad[["zoom"]] <- cropped.coords
DefaultBoundary(xenium_luad[["zoom"]]) <- "segmentation"
ImageDimPlot(xenium_luad, fov = "zoom", axes = TRUE, border.color = "white", border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "seurat_clusters",
             nmols = 50000)

ImageDimPlot(subset(xenium_luad, annotation %in% c("AT2_like", "club_like", "fib")), 
             fov = "zoom", axes = TRUE, border.color = "white", 
             border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "orig.ident",
             nmols = 50000)

ImageDimPlot(subset(xenium_luad, annotation %in% c("immune", "mph", "fib")), 
             fov = "zoom", axes = TRUE, border.color = "white", 
             border.size = 0.1, cols = "polychrome",
             coord.fixed = FALSE, 
             # molecules = c("CD173"),
             # group.by = "orig.ident",
             nmols = 50000)

saveRDS(xenium_luad, "xenium_luad.rds")


# csv anno ----

xenium_annotation <- data.frame(
  cell_id = colnames(xenium_luad),
  group = xenium_luad$annotation
)

celltypes <- unique(xenium_annotation$group)

library(pals)
n <- length(celltypes)
polychrome_colors <- pals::polychrome(max(n))

color_table <- data.frame(
  group = celltypes,
  color = polychrome_colors
)

library(dplyr)
xenium_annotation <- xenium_annotation %>%
  left_join(color_table, by = "group")

head(xenium_annotation)
write.csv(
  xenium_annotation,
  file = "xenium_luad_cell_annotation.csv",
  row.names = FALSE,
  quote = FALSE
)

create_xenium_annotation(
  seurat_obj = xenium_luad,
  annotation_col = "seurat_clusters",
  output_file = "xenium_luad_by_seu_clusters_res_0.3.csv"
)

create_xenium_annotation(
  seurat_obj = xenium_luad,
  annotation_col = "annotation",
  output_file = "xenium_luad_by_annotation.csv"
)
