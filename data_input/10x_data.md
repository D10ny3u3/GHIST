


https://www.10xgenomics.com/datasets?sort=publishedAt+DESC&tag%5BplatformName%5D=Xenium&tag%5BanatomicalEntities%5D=Lung

目前能够明确核实的几个重要数据集如下。

## 5 个肺组织 Xenium 数据集

### 1. Xenium Human Lung Preview Data

[官方数据集页面](https://www.10xgenomics.com/datasets/xenium-human-lung-preview-data-1-standard?utm_source=chatgpt.com)

[Xenium <500-gene panels | 10x Genomics](https://images.openai.com/static-rsc-4/f6wA46GiFQIa2xfzoEa0H6a7I0CdJJs8UtijD__-sOo-hxteCLMAQSyOS1UDJ-lxNw7nbCWxsO_tQkb-bC32eYKKGx7jb2tXLs34TS1oE4ZRCTTDu8mmeK37MgjkmmD7iLbH5kKkRQxBdKrKdP18urRpCRqBIjJqKJ4OUtffyFA?purpose=inline)

[10xgenomics.com](https://www.10xgenomics.com/products/xenium-v1-panel?utm_source=chatgpt.com)

这是五个数据集中比较有价值的一个，因为同时包含正常肺和肺癌组织。

- 样本： 2 份成人肺组织，分别为健康肺和浸润性肺腺癌。
- 组织： FFPE。
- Panel： Human Lung Gene Expression Panel（开发版）+ 100 个肺组织定制基因。
- 分析软件： Xenium Onboard Analysis 1.3.0。
- 细胞数量：
  - 正常肺：295,883 cells。
  - 肺癌：531,165 cells。
- Median transcripts/cell： 正常肺 71，癌组织 105。

Panel 覆盖肺泡上皮、内皮、基质、分泌细胞、免疫细胞及肿瘤细胞。

研究价值： 适合研究正常肺与肺癌之间的细胞组成及空间分布差异，尤其是肺泡上皮、血管内皮和间质细胞。

[image](https://www.google.com/s2/favicons?domain=https://www.10xgenomics.com\&sz=32)

10x Genomics



### 2. Human Lung Cancer Preview Data（Multi-Tissue and Cancer Panel）

[官方数据集页面](https://www.10xgenomics.com/datasets/human-lung-cancer-preview-data-xenium-human-multi-tissue-and-cancer-panel-1-standard?utm_source=chatgpt.com)



肺癌组织

2023-07-17



[Optimizing your spatial transcriptomics research with Visium HD and Xenium Prime 5K | 10x Genomics](https://images.openai.com/static-rsc-4/AJz-uaztn2oljOgxuuAHh_hM73W5tMyIcbIpd_0-4F_DXF_A1SC8XK3dbl90i8QZUOdu9TiSxYpWYeiwjJG8vVVhhMd-nkkj4KvkDdZcYqE8ZDj2T2XUFMUbTDf3H1AHuEIG3kmB7qu6qCsmRrdYxvNyWgT1myIm_kCUszzNsQU?purpose=inline)

[10xgenomics.com](https://www.10xgenomics.com/blog/optimizing-your-spatial-transcriptomics-research-with-visium-hd-and-xenium-in-situ?utm_source=chatgpt.com)

- 样本： 1 例肺癌组织。
- 组织： FFPE。
- Panel： Human Multi-Tissue and Cancer Panel，377 genes。
- 分析软件： Xenium Onboard Analysis 1.5.0。
- 细胞数量： 150,365。
- Median transcripts/cell： 132。

该 Panel 是多组织通用型设计，主要覆盖细胞类型识别、免疫标志物、增殖及肿瘤标志物。

研究价值： 可用于观察肿瘤上皮、免疫细胞及基质细胞的空间分布。不过，它不是专门针对肺组织设计的 Panel，肺特异性标志物覆盖相对有限。

[image](https://www.google.com/s2/favicons?domain=https://www.10xgenomics.com\&sz=32)

10x Genomics



### 3. Preview Data: FFPE Human Lung Cancer with Xenium Multimodal Cell Segmentation

[官方数据集页面](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard?utm_source=chatgpt.com)



H&E + 多模态细胞分割

2024-02-05



[Checking Xenium Data Quality | Official 10x Genomics Support](https://images.openai.com/static-rsc-4/xaRh7QbRXAw-XCuW3IUpEjDCJxjNFgEUG33dJt6Kq1vUAvwWvWlynB7wyf22qnFEz49EAaw66JfLCFO4MDaCz6OuPF1BvXWFSo3shQi2yqQ_9eo4PARR7FQwgTCQj9GBwqoOBRWCqhADJmUrdwZkUS22pW381IKuHqec_03VJdQ?purpose=inline)

[10xgenomics.com](https://www.10xgenomics.com/support/software/xenium-explorer/latest/tutorials/xe-checking-xenium-data-quality?utm_source=chatgpt.com)

- 样本： 1 例肺腺癌。
- 组织： FFPE。
- Panel： Human Multi-Tissue and Cancer Panel，377 genes。
- 分析软件： Xenium Onboard Analysis 2.0.0。
- 细胞数量： 162,254。
- Median transcripts/cell： 46。

这个数据集的特点不是基因数量增加，而是引入了 Multimodal Cell Segmentation，即利用细胞分割染色辅助细胞边界识别。

另外提供：

- Post-Xenium H&E 图像。
- 与 H&E 对应的病理区域 GeoJSON 注释。
- Xenium 空间表达及细胞分割结果。

研究价值： 对你的 H&E 数字病理和空间结构研究特别有意义。可以将病理区域与空间表达数据对应，研究不同组织形态区域的细胞组成。

需要注意：这是早期预览版本，细胞分割及实验流程使用的是开发版。

[image](https://www.google.com/s2/favicons?domain=https://www.10xgenomics.com\&sz=32)

10x Genomics



### 4. FFPE Human Lung Cancer Data with Human Immuno-Oncology Profiling Panel and Custom Add-on

[官方数据集页面](https://www.10xgenomics.com/datasets/ffpe-human-lung-cancer-data-with-human-immuno-oncology-profiling-panel-and-custom-add-on-1-standard?utm_source=chatgpt.com)



免疫微环境研究

2024-05-14



[Two platforms, one powerful spatial biology toolkit: When and how researchers are using Visium and Xenium | 10x Genomics](https://images.openai.com/static-rsc-4/_t8Fu4_mb4ovpGWtiRzbOJckF8hajpQSRcWbXfzETDnTJ9z1G0MW1d84MJw2sy0QzAhorPqm2MXi5PFpMS3g0c3z_bMohGif2_0xs_k73ILFJII9EOI-duOfhhcotIRXer4YdaOTO474Uo7XWW19vejjjpFYp-GMzEVrMYJhP40?purpose=inline)

[10xgenomics.com](https://www.10xgenomics.com/blog/two-platforms-one-powerful-spatial-biology-toolkit-when-and-how-researchers-are-using-visium-and-xenium?utm_source=chatgpt.com)

- 样本： 1 例 NSCLC，Stage IB，Grade 2。
- 来源： Discovery Life Sciences。
- 组织： FFPE。
- Panel： Human Immuno-Oncology Profiling Panel（380 genes）+ Custom Add-on。
- 分析软件： Xenium Onboard Analysis 2.0.0。
- 细胞数量： 161,000。
- Median transcripts/cell： 131。

这个数据集的优势在于免疫微环境相关基因。

主要覆盖：

- T 细胞及其亚群。
- B 细胞。
- 巨噬细胞及其他髓系细胞。
- 免疫检查点分子。
- 肿瘤细胞相关标志物。

此外，提供 Post-Xenium H&E 图像及图像配准文件。

研究价值： 如果研究 LUAD/NSCLC 中肿瘤细胞与免疫细胞之间的空间关系，例如 CD8 T 细胞浸润、免疫排斥和免疫检查点表达，这是很有价值的数据。

[image](https://www.google.com/s2/favicons?domain=https://www.10xgenomics.com\&sz=32)

10x Genomics



### 5. Post-Xenium Technical Note: Xenium v1 and Xenium Prime 5K for FFPE Human Lung Cancer

[官方数据集页面](https://www.10xgenomics.com/cn/datasets/xenium-human-lung-cancer-post-xenium-technote?utm_source=chatgpt.com)



5K 高通量空间转录组

2024-11-06



[How imaging- and sequencing-based spatial transcriptomics add new dimensions to your research | 10x Genomics](https://images.openai.com/static-rsc-4/XZxXwToV1Wo-StM3JB61VjctWiC2vWqG9cq4yTKG6n_renkssqEvDP8wUjiDxTBaJBDl2pwkbJYlOPBOvDw_45VRRtDuDrDZgVLAUkFBVfwkHqNeUQsmr5V6tbcUSPTEyF2Zst77YJgNG3FziXTL4Badssi5WjAZ8kwiFCkWHhk?purpose=inline)

[10xgenomics.com](https://www.10xgenomics.com/blog/high-plex-spatial-rna-adding-an-entire-new-dimension-to-your-imaging-studies?utm_source=chatgpt.com)

这个数据集比较特殊：它实际上包含同一肺腺癌组织的两种 Xenium 实验方案。

| 参数                      | Experiment 1               | Experiment 2                     |
| ----------------------- | -------------------------- | -------------------------------- |
| 平台                      | Xenium v1                  | Xenium Prime 5K                  |
| Panel                   | Human Lung Gene Expression | Human Pan Tissue and Pathways 5K |
| 细胞数                     | 278,659                    | 278,328                          |
| Median transcripts/cell | 58                         | 242                              |
| 高质量解码转录本                | 30.87 M                    | 149.37 M                         |
| 组织面积                    | 72.02 mm²                  | 71.09 mm²                        |

两组实验均为 FFPE 肺腺癌，使用 Xenium Onboard Analysis 3.0.0。

研究价值： 这是非常值得关注的一个数据集。

Prime 5K 相较于传统 Xenium v1，大幅增加了基因检测数量，可以更全面地分析：

- 肿瘤细胞异质性。
- 肿瘤相关成纤维细胞（CAF）。
- 血管及周细胞。
- 免疫细胞亚群。
- 肿瘤与间质之间的空间相互作用。

另外，这套技术说明还配套 Post-Xenium H&E、IF、Visium v2 和 Visium HD 的实验资料。

[image](https://www.google.com/s2/favicons?domain=https://www.10xgenomics.com\&sz=32)

10x Genomics+1



## 横向比较

| 数据集 | 样本数/实验数 | Panel                        | 主要特点        |
| --- | ------- | ---------------------------- | ----------- |
| 1   | 2       | Lung + 100 add-on            | 正常肺与肺癌对照    |
| 2   | 1       | Multi-Tissue 377             | 肿瘤细胞空间定位    |
| 3   | 1       | Multi-Tissue 377             | 多模态细胞分割、H&E |
| 4   | 1       | Immuno-Oncology 380 + add-on | 免疫微环境       |
| 5   | 2 个实验   | Lung / Prime 5K              | 高通量基因检测     |

## 对你的 LUAD 空间病理研究，我的建议

结合你正在研究的血管–纤维–上皮空间组织结构，以及 WNT2 Alv_Fib、CTHRC1/POSTN Myo_Fib 等成纤维细胞亚群，我会这样排序：

优先级 1

数据集 5：Xenium Prime 5K

基因覆盖最广，适合重新识别 CAF、血管细胞、周细胞及肿瘤细胞，并分析它们的空间关系。

优先级 2

数据集 3：Multimodal Cell Segmentation

对你的 H&E 病理图像分割、细胞边界识别及组织区域注释研究最有帮助。

优先级 3

数据集 1：正常肺 + 肺癌

可用于观察正常肺组织向肿瘤组织转变时，肺泡上皮、血管和间质的空间组织变化。

优先级 4

数据集 4：Immuno-Oncology

适合研究免疫细胞与肿瘤、间质之间的空间关系。

还有一个重要提醒： 这五个数据集绝大多数只有一个供体，不能把细胞数量当作独立生物学重复数。它们更适合作为细胞空间定位、组织结构分析和算法验证的数据，而不是直接开展具有统计推断意义的患者队列比较。

另外，我建议你重点下载第 3 和第 5 个数据集，检查是否有可用的 H&E 原图、细胞分割结果、转录本坐标及 GeoJSON 病理注释。这些资料可能直接用于验证你目前的 Kludt H&E 分割与后续三维组织建模方案。
