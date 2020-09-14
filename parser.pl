#!/usr/bin/perl -w

#Written by Dustin Wcisel on 9/7/2020
#currently has a bug in the code if an exon is used multiple times for
#different transcripts, only returns on transcript/protein

my $gffFile = "Danio_rerio.GRCz11.101.chromosome.1.gff3";
my $igcoords = "GRCz11_Ig_positions.txt";

open (IN, $gffFile);
my (%trans_gene_hash, %trans_protein_hash);

while (<IN>){
    chomp;
    my ($exon_id, $transcript);
    next if ($_ =~ /^#/); #skip comment lines
    next if ($_ =~ /rRNA/); #skip rRNA
    next if ($_ =~ /miRNA/); #skip miRNA
    next if ($_ =~ /lnc_RNA/); #skip lnc_RNA
    next if ($_ =~ /snoRNA/); #skip snoRNA
    next if ($_ =~ /snRNA/); #skip snRNA
    next if ($_ =~ /pseudogenic_transcript/); #skip pseudogenic_transcript
    if ($_ =~ /(ENSDARE\w+)/){ #if it's an exon row, save this data
        $exon_id = $1;
        $_ =~ /(transcript:)(ENSDART\w+)/;
        $transcript = $2;
        my ($chr, $source, $type, $start, $end, $useless, $strand, $useless2, $comments) = split("\t", $_);
        push ( @{$final{$exon_id}}, $start );
        push ( @{$final{$exon_id}}, $end );
        push ( @{$final{$exon_id}}, $transcript );
        #Exon, Start, End, Transcript
    }
    if ($_ =~ /(ENSDART\w+);Parent=gene:(ENSDARG\w+)/){
        $trans_gene_hash{$1} = $2;
#        print "$1\t$2\n"
    }
    if ($_ =~ /(ENSDART\w+);protein_id=(ENSDARP\w+)/){      
        $trans_protein_hash{$1} = $2;
#        print "$1\t$2\n"
    }
}

close (IN);

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
        my $transcript = @{$final{$key}}[2];
        my $start = @{$final{$key}}[0];
        my $end   = @{$final{$key}}[1];
        if ($end - $start > 0) { #forward direction
            unless ( $ig_end <= $start or $ig_start >= $end) {
                print "$ig_name is contained in $trans_gene_hash{$transcript}, $transcript, $trans_protein_hash{$transcript}\n";
            }
        }
        if ($end - $start < 0) { #reverse direction
            unless ( $ig_end <= $end or $ig_start >= $start) {
                print "$ig_name is contained in $trans_gene_hash{$transcript}, $transcript, $trans_protein_hash{$transcript}\n";
            }
        }
    }
}


#foreach (@coords){
#    my ($ig_name, $ig_start, $ig_end) = split ("\t", $_);
#    foreach my $key (sort keys %final) {
#        my $start = @{$final{$key}}[0];
#        my $end   = @{$final{$key}}[1];
#        if ($end - $start > 0) { #forward direction
#            unless ( $ig_end <= $start or $ig_start >= $end) {
#                print "$ig_name is contained in $key\n";
#            }
#        }
#        if ($end - $start < 0) { #reverse direction
#            unless ( $ig_end <= $end or $ig_start >= $start) {
#                print "$ig_name is contained in $key\n";
#            }
#        }
#    }
#}

