#!/usr/bin/perl -w

my $fastaFile = $ARGV[0];

open (IN, $fastaFile);
while (<IN>){
    chomp;
    next if ($_ !~ /^>/);
#        print "$_\n";
        $_ =~ /(ENSDARP\d+\.\d)/;
        my $protein_id = $1;
        $_ =~ /(chromosome:GRCz11:)(\d+):(\d+):(\d+)/;
        my $chromosome = $2;
        my $start = $3;
        my $end = $4;
        $_ =~ /(gene:)(\w+.\d+)/;
        my $gene_id = $2;
#        print "$gene_id\t$protein_id\t$start\t$end\n"
        next if (exists($hash{$gene_id})); #only first instance of gene will be recorded
        next if (not defined($protein_id));
        next if (not defined($chromosome));
        next if (not defined($start));
        next if (not defined($end));
        next if (not defined($gene_id));     
            push ( @{$hash{$gene_id}}, $protein_id );
            push ( @{$hash{$gene_id}}, $start );
            push ( @{$hash{$gene_id}}, $end );
            push ( @{$hash{$gene_id}}, $chromosome );
}

foreach $key (sort keys %hash) {
    if (@{$hash{$key}}[3] == 1){
        print "zf1\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 2){
        print "zf2\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 3){
        print "zf3\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 4){
        print "zf4\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 5){
        print "zf5\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 6){
        print "zf6\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 7){
        print "zf7\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 8){
        print "zf8\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 9){
        print "zf9\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 10){
        print "zf10\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 11){
        print "zf11\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 12){
        print "zf12\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 13){
        print "zf13\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 14){
        print "zf14\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 15){
        print "zf15\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 16){
        print "zf16\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 17){
        print "zf17\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 18){
        print "zf18\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 19){
        print "zf19\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 20){
        print "zf20\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 21){
        print "zf21\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 22){
        print "zf22\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 23){
        print "zf23\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 24){
        print "zf24\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
    if (@{$hash{$key}}[3] == 25){
        print "zf25\t@{$hash{$key}}[0]\t@{$hash{$key}}[1]\t@{$hash{$key}}[2]\n";
    }
}



