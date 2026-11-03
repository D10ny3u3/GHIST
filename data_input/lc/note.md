
数据来源：
https://www.10xgenomics.com/datasets/ffpe-human-lung-cancer-data-with-human-immuno-oncology-profiling-panel-and-custom-add-on-1-standard

病理诊断：低分化，具体亚型未知。

new.cluster.ids <- c(
  "epi",
  "nkt", "mph", "endo", "epi?", "epi?",
  "plasma", "fib", "low_feat_cell", "endo?", "fib?",
  "b", "Tfh_CXCL13_region", "plasma", "lymph_endo", "mast",
  "epi?"
)

对于epi?、endo?，经过图像对比，拟采用。

对于fib?，仍属可疑，不采用。