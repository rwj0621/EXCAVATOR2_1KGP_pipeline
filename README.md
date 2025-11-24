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

  
