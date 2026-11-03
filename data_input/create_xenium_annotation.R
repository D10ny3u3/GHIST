create_xenium_annotation <- function(
    seurat_obj,
    annotation_col = "annotation",
    output_file = "xenium_cell_annotation.csv"
) {
  
  # 检查注释列是否存在
  if (!annotation_col %in% colnames(seurat_obj@meta.data)) {
    stop(paste0(
      "Column '", annotation_col, 
      "' not found in Seurat metadata."
    ))
  }
  
  # 创建 cell annotation 表
  xenium_annotation <- data.frame(
    cell_id = colnames(seurat_obj),
    group = seurat_obj[[annotation_col]][, 1],
    stringsAsFactors = FALSE
  )
  
  # 获取细胞类型
  celltypes <- unique(xenium_annotation$group)
  
  # 生成 Polychrome 颜色
  n <- length(celltypes)
  polychrome_colors <- pals::polychrome(max(n))
  
  # 建立颜色表
  color_table <- data.frame(
    group = celltypes,
    color = polychrome_colors[seq_along(celltypes)],
    stringsAsFactors = FALSE
  )
  
  # 添加颜色
  xenium_annotation <- xenium_annotation %>%
    dplyr::left_join(color_table, by = "group")
  
  # 保存
  write.csv(
    xenium_annotation,
    file = output_file,
    row.names = FALSE,
    quote = FALSE
  )
  
  message("Xenium annotation saved to: ", output_file)
  
  return(xenium_annotation)
}

# cell annotation ----
library(Seurat)
library(dplyr)

create_xenium_annotation(
  seurat_obj = xenium_2,
  annotation_col = "annotation",
  output_file = "xenium_2_cell_annotation.csv"
)

create_xenium_annotation(
  seurat_obj = xenium_3,
  annotation_col = "annotation",
  output_file = "xenium_3_cell_annotation.csv"
)
create_xenium_annotation(
  seurat_obj = xenium_14,
  annotation_col = "annotation",
  output_file = "xenium_14_cell_annotation.csv"
)
create_xenium_annotation(
  seurat_obj = xenium_16,
  annotation_col = "annotation",
  output_file = "xenium_16_cell_annotation.csv"
)
create_xenium_annotation(
  seurat_obj = xenium_17,
  annotation_col = "annotation",
  output_file = "xenium_17_cell_annotation.csv"
)
