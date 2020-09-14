#!/usr/bin/perl -w

#Written by Dustin Wcisel on 9/7/2020
#currently has a bug in the code if an exon is used multiple times for
#different transcripts, only returns on transcript/protein

my $gffFile = "NC_007112.7.gff";
my $igcoords = "GRCz11_Ig_positions.txt";

open (IN, $gffFile);
my (%trans_gene_hash, %trans_protein_hash);

while (<IN>){
    chomp;
    my ($exon_id, $transcript);
    if ($_ =~ /ID=exon-(\w+.*?);/){ #if it's an exon row, save this data
        $exon_id = $1;
#        print $exon_id, "\n";
        $_ =~ /(GeneID:\w+)/;
        $GeneID = $1;
        my ($chr, $source, $type, $start, $end, $useless, $strand, $useless2, $comments) = split("\t", $_);
        push ( @{$final{$exon_id}}, $start );
        push ( @{$final{$exon_id}}, $end );
        push ( @{$final{$exon_id}}, $GeneID );
#        #Exon, Start, End, Transcript
    }
    if ($_ =~ /ID=exon/){
        $_ =~ /(GeneID:\w+),Genbank:(\w+.*?)[,;]/;
        $trans_protein_hash{$1} = $2;
#        print "$1\t$2\n"
    }
    if ($_ =~ /ID=cds/){
        $_ =~ /(GeneID:\w+),Genbank:(\w+.*?)[,;]/;
        $trans_gene_hash{$1} = $2;
#        print "$1\t$2\n"
    }
}

close (IN);

#foreach my $key (sort keys %final) {
#    print "$key\t$final{$key}[2]\n";
#}

#foreach my $key (sort keys %trans_gene_hash) {
#    print "$key\t$trans_gene_hash{$key}\n";
#}

#foreach my $key (sort keys %trans_gene_hash) {
#    print "$key\t$trans_protein_hash{$key}\n";
#}

#print "Gene/t/Protein/tExon/tStart/tEnd\n";

#foreach my $key (sort keys %final) {
#    my $transcript = @{$final{$key}}[2];
#    if (exists($trans_protein_hash{$transcript}) && exists($trans_gene_hash{$transcript})){
#        print "$trans_gene_hash{$transcript}\t$trans_protein_hash{$transcript}\t$key\t@{$final{$key}}[0]\t@{$final{$key}}[1]\n";
#    }
#}

open (COORDS, $igcoords);
@coords = <COORDS>;

foreach (@coords){
    my ($ig_name, $ig_start, $ig_end) = split ("\t", $_);
    foreach my $key (sort keys %final) {
        my $geneid = @{$final{$key}}[2];
        my $start  = @{$final{$key}}[0];
        my $end    = @{$final{$key}}[1];
        if ($end - $start > 0) { #forward direction
            unless ( $ig_end <= $start or $ig_start >= $end) {
                print "$ig_name	@{$final{$key}}[2]\t$trans_gene_hash{$geneid}\t$trans_protein_hash{$geneid}\n";
            }
        }
        if ($end - $start < 0) { #reverse direction
            unless ( $ig_end <= $end or $ig_start >= $start) {
                print "$ig_name	@{$final{$key}}[2]\t$trans_gene_hash{$geneid}\t$trans_protein_hash{$geneid}\n";
            }
        }
    }
}


