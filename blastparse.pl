#!/usr/bin/perl -w

use Bio::Seq;
use Bio::SearchIO; 
use List::MoreUtils qw(uniq);

#this script parses a blast file and returns only the names of the hits.
#use in combination with extract.pl to retrieve .fasta of blast hits.

$file = $ARGV[0];

my $in = new Bio::SearchIO(-format => 'blast', 
                           -file   => $file);
while( my $result = $in->next_result ) {
  ## $result is a Bio::Search::Result::ResultI compliant object
    while( my $hit = $result->next_hit ) {
    ## $hit is a Bio::Search::Hit::HitI compliant object
         while( my $hsp = $hit->next_hsp ) {
#            push @queries, $result->query_name;
            if ($hit->description =~ /CD300|NILT|polymeric|CMRF/i){ #this somehow matches everything
#                print $hit->description, "\n";
                $nilts{$result->query_name} = "NILTY";
                next;
                }elsif($hit->description =~ /CD22|sialic|B-cell/i){
                    $not_nilts{$result->query_name} = "NOT_NILTY";
                }
            }
        }
    }


foreach my $key (sort keys %nilts){
    print $key,"\t",$nilts{$key}, "\n";
}

#@uni_queries = uniq(@queries);

#foreach (@uni_queries){
#    if (exists($nilts{$_})){
#        next;
#    }else{
#        print $_, "\n";
#    }
#}


foreach my $key (sort keys %not_nilts){
    print $key,"\t",$not_nilts{$key}, "\n";
}



#CD300
#polymeric
#uncharacterized
#hypothetical
#CMRF
#NILT
#unnamed
#Polymeric

#need to ignore case



