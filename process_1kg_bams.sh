declare -A BAM_FILES=(
    ["NA19131"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19131.mapped.ILLUMINA.bwa.YRI.exome.20120522.bam"
    ["NA19138"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19138.mapped.ILLUMINA.bwa.YRI.exome.20121211.bam"
    ["NA19152"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19152.mapped.ILLUMINA.bwa.YRI.exome.20120522.bam"
    ["NA19159"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19159.mapped.ILLUMINA.bwa.YRI.exome.20121211.bam"
    ["NA19200"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19200.mapped.ILLUMINA.bwa.YRI.exome.20120522.bam"
    ["NA19206"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19206.mapped.ILLUMINA.bwa.YRI.exome.20121211.bam"
    ["NA19223"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA19223.mapped.ILLUMINA.bwa.YRI.exome.20120522.bam"
    ["NA10847"]="/data/share/liuyuxin_tanrenjie/1KGP/EXCAVATOR2_8_data/sample_data/NA10847.mapped.ILLUMINA.bwa.CEU.exome.20121211.bam"
)

mkdir -p /data/renweijie/1000GP/processed_bams

for sample in "${!BAM_FILES[@]}"; do
    INPUT_BAM="${BAM_FILES[$sample]}"
    
    echo "Processing $sample..."
    
    # 1. 排序BAM文件
    echo "  Sorting BAM..."
    samtools sort -@ 8 -o /data/renweijie/1000GP/processed_bams/${sample}.sorted.bam "$INPUT_BAM"
    
    # 2. 过滤低质量比对 (MQ >= 10) 
    echo "  Filtering low quality reads (MQ >= 10)..."
    samtools view -b -q 10 /data/renweijie/1000GP/processed_bams/${sample}.sorted.bam > \
        /data/renweijie/1000GP/processed_bams/${sample}.filtered.bam
    
    # 3. 建立索引
    echo "  Indexing BAM..."
    samtools index /data/renweijie/1000GP/processed_bams/${sample}.filtered.bam
    
    # 清理中间文件
    rm /data/renweijie/1000GP/processed_bams/${sample}.sorted.bam
    
    echo "Completed $sample"
done
