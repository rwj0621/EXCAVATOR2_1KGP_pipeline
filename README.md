# 一、环境创建
## 创建环境
    conda create -n excavator
## 激活环境
    conda activate excavator
# 二、工具安装
* 安装R和相关依赖  R (版本 ≥ 2.14.0) & Hmisc 库

        #安装R和基本工具 
        conda install -c conda-forge r-base -y
        #安装R包Hmisc 
        conda install -c conda-forge r-hmisc -y 
        R -e 'library(Hmisc); print("Hmisc 工作正常！")'
        library(Hmisc) 加载/导入名为 Hmisc 的 R 包
* 安装Perl (版本 ≥ 5.8.8)

        conda install -c conda-forge perl -y
* 安装SAMtools (版本 ≥ 0.1.17)

        #通过conda安装SAMtools
        conda install -c bioconda samtools -y
        #验证安装
        samtools --version
        Using htslib 1.22.1
  
