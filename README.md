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
* 安装EXCAVATOR2依赖的编译工具
  
        #安装编译工具 
        conda install -c conda-forge gcc gfortran make -y
* 编译Fortran子程序

        #进入lib/F77目录
        cd /data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2/lib/F77
        #编译两个Fortran文件
        R CMD SHLIB F4R.f
        R CMD SHLIB FastJointSLMLibraryI.f
* 设置环境变量

        #把EXCAVATOR2路径添加到配置文件
        echo 'export EXCAVATOR2_HOME="/data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2"' >> ~/.bashrc 
        #把路径加入到系统PATH中
        echo 'export PATH=$PATH:$EXCAVATOR2_HOME' >> ~/.bashrc
        #立即生效
        source ~/.bashrc

        #检查环境变量
        echo $EXCAVATOR2_HOME

        #检查文件是否存在
        ls $EXCAVATOR2_HOME

