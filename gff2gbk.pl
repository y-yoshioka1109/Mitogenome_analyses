#不完全であるため、一部マニュアルで修正する必要あり
$count=1;
#$num=1;
open(F,$ARGV[0]);
while($_=<F>){
	chomp;
	@b=split(/\t/,$_);
	$info=$len{$b[0]};
	@c=split(/\t/,$info);
	if($count==1){
		print "LOCUS       $b[0]   18508 bp  DNA  linear\n";
		print "DEFINITION Soft coral\n";
		print "FEATURES             Location/Qualifiers\n";
		$count=2;
		@a=split(/gene_id=/,$b[8]);
		print "     gene            $b[3]..$b[4]\n";
		print "                     /gene=\"$a[1]\"\n";
	}else{
		if ($b[2] eq ncRNA_gene || $b[2] eq gene){
			@a=split(/gene_id=/,$b[8]);
			print "     gene            $b[3]..$b[4]\n";
			print "                     /gene=\"$a[1]\"\n";
		}elsif ($b[2] eq exon || $b[2] eq rRNA){
				if($b[6] eq "+"){
					print "     CDS             $b[3]..$b[4]\n";
				}elsif($b[6] eq "-"){
					print "     CDS             complement($b[3]..$b[4])\n";
				}
		}
	}
}
	print"ORIGIN\n";
close(F);
