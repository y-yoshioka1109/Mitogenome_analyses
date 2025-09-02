#Clinkerを使ったシンテニー解析
https://github.com/gamcil/clinker

#genbankファイルの作成
for i in `ls|grep .gff | awk -F"\.gff" '{print$1}'`;do perl gff2gbk.pl $i.gff > $i.gbk ;done
for i in `ls|grep .gff | awk -F"\.gff" '{print$1}'`;do cat $i.fa | seqkit replace -s -p '(\w{10})' -r '$1 ' -w 66   \
  | perl -ne 'if (/^>/) {print; $n=1} else {s/ \r?\n$/\n/; printf "%9d %s", $n, $_; $n+=60;}' | grep -v ">" >> $i.gbk ;done

#Clinkerの実行
clinker Coelastrea_aspera.gbk Astrea_annuligera.gbk Paramontastraea_salebrosa.gbk \
Blastomussa_merleti.gbk Blastomussa_wellsi.gbk Physogyra_lichtensteini.gbk Plerogyra_sinuosa.gbk \
 -p plot.html --use_file_order -i 0.3 --jobs ${SLURM_CPUS_PER_TASK}
