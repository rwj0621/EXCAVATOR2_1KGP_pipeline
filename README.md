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
# 三、处理BAM文件
* 使用SAMtools进行处理、排序和过滤（丢弃MQ < 10的读段）
[process_1kg_bams.sh](https://github.com/rwj0621/EXCAVATOR2_1KGP_pipeline/blob/main/process_1kg_bams.sh)
# 四、EXVACATOR2 pipeline
## TargetPerla.pl
* 准备靶区定义文件
  * 格式要求 纯文本，制表符分隔，至少包含三列：染色体、起始位置、终止位置
  * bed文件带chr且只有3列 符合工具要求
  * bam文件不带chr
  * 对bed文件排序、去重、去除chr
    
          #使用awk处理BED文件：去除chr前缀、排序、去重
          awk '
          {
              #去除chr前缀
              chrom = $1
              sub(/^chr/, "", chrom)
    
              #输出处理后的行
              print chrom "\t" $2 "\t" $3
          }'  /data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/reference/exome_pull_down_targets_phases1_and_2/20120518.exome.consensus.bed | \
          sort -k1,1V -k2,2n -k3,3n | \
          uniq > /data/renweijie/1000GP/1000GP_prosecced/20120518.exome.consensus.processed.bed
* 准备SourceTarget.txt
  
        #创建分析目录
        mkdir -p /data/renweijie/1000GP/1000GP_prosecced_20k
        #创建SourceTarget.txt配置文件
        touch SourceTarget
        /data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2/data/ucsc.hg19.bw
        /data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/reference/hs37d5.fa
* 运行TargetPerla.pl
  
        cd /data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2
        perl TargetPerla.pl \
        /data/renweijie/1000GP/1000GP_prosecced_20k/SourceTarget.txt \
        /data/renweijie/1000GP/1000GP_prosecced/20120518.exome.consensus.processed.bed \
        1000GP_Target_20000 20000 hg19
  * 问题：libpng12.so.0缺失
  * 解决方案
    
          #进入临时目录 
          cd /tmp 
          #从UCSC官网下载最新版（无需libpng12依赖）
          wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/bigWigAverageOverBed 
          #添加执行权限 
          chmod +x bigWigAverageOverBed
          # 替换为新下载的版本
          cp /tmp/bigWigAverageOverBed /data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2/lib/OtherLibrary/
          #确保执行权限
          chmod +x /data/renweijie/1000GP/tools/EXCAVATOR2_Package_v1.1.2/lib/OtherLibrary/bigWigAverageOverBed
