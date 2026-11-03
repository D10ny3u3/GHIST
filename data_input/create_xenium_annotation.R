
create_xenium_annotation <- function(
    seurat_obj,
    annotation_col = "annotation",
    output_file = "xenium_cell_annotation.csv"
) {
  
  # 检查注释列
  if (!annotation_col %in% colnames(seurat_obj@meta.data)) {
    stop(paste0(
      "Column '", annotation_col,
      "' not found in Seurat metadata."
    ))
  }
  
  # 创建 annotation 表
  xenium_annotation <- data.frame(
    cell_id = colnames(seurat_obj),
    group = as.character(seurat_obj[[annotation_col]][, 1]),
    stringsAsFactors = FALSE
  )
  
  # 获取实际存在的 cluster
  celltypes <- unique(xenium_annotation$group)
  
  # 按数值顺序排列 cluster
  celltypes_num <- suppressWarnings(as.numeric(celltypes))
  
  if (all(!is.na(celltypes_num))) {
    
    # 数值型 cluster：按照 cluster ID 排序
    celltypes_ordered <- as.character(sort(unique(celltypes_num)))
    
    # 与第二段代码保持一致：cluster 0 对应第一个颜色
    n <- max(celltypes_num) + 1
    polychrome_colors <- pals::polychrome(n)
    
    color_table <- data.frame(
      group = celltypes_ordered,
      color = polychrome_colors[
        as.numeric(celltypes_ordered) + 1
      ],
      stringsAsFactors = FALSE
    )
    
  } else {
    
    # 非数值型 annotation：按照首次出现顺序分配
    n <- length(celltypes)
    polychrome_colors <- pals::polychrome(n)
    
    color_table <- data.frame(
      group = celltypes,
      color = polychrome_colors[seq_along(celltypes)],
      stringsAsFactors = FALSE
    )
  }
  
  # 添加颜色
  xenium_annotation <- dplyr::left_join(
    xenium_annotation,
    color_table,
    by = "group"
  )
  
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
