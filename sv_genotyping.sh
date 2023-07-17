#!/bin/bash


# SV genotyping on TBF trait in 155 tea accessions.


ncpus=36

for i in $(cat sample.list)
do

#Short reads from 155 tea accessions are mapped to graph genome with vg giraffe	
vg giraffe -p -t $ncpus -m graph.min -d graph.dist --gbwt-name graph.gbwt -x graph.gg -N sample -f $sample}_R1.fq.gz -f ${sample}_R2.fq.gz > sample.gam
vg pack -t $ncups -x graph.xg -o graph.pack -g sample.gam -Q 5 

#Genotypes of SVs for the 155 accessions were called by vg call

vg call graph.xg -k graph.pack -v var.vcf.gz --snarls graph.snarls -s sample -t $ncpus >sample.vcf

bcftools sort sample.vcf | bgzip > sample.vcf.gz && tabix -p vcf sample.vcf.gz
done
