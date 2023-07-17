#/bin/bash

ref=re.fa
vars=variants.vcf.gz

#constructing graph
vg construct -r $ref -v $var -a -f -S >graph.vg

#graph index
vg index -L -x graph.xg graph.vg
vg snarls graph.xg >graph.snarls
vg prune -M 32 --restore-paths graph.vg >graph.pruned.vg
vg index --temp-dir tmp -p -g graph.gcsa  graph.pruned.vg
vg gbwt -g graph.gg -o graph.gbwt -x graph.xg -P
vg index -j graph.dist -x graph.xg -s graph.snarls
vg minimizer -k 31 -w 15 -i graph.min -d graph.dist -g graph.gbwt graph.xg
