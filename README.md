# nilts
Scripts used in the preparation of a manuscript on zebrafish NILTs

This is meant to detail how to the use the various scripts that went into analyzing data for the NILT 2020 manuscript. Many of these scripts are one-offs and therefore numerous variables are hard-coded in each perl script. Most of the perl scripts rely on having bioperl installed.

# Identification of NILT Ig domains in Zv9 and GRCz11

Published NILTs used in blast searches against the zebrafish genome revealed numerious hits to chromosome one. These hits are restricted to scaffolds which have changed names with each new version of the genome.

*GRCz11 - CTG111
*GRCz10 - CTG112
*Zv9 - Scaffold 100 and Scaffold 101

Tracing the history of these scaffolds, it became clear that Zv9 scaffold 100 was removed and Scaffold 101 was modified into CTG111. As we noted many differences in BLAST hits between 100 and 101 reminescent of gene-content haplotypes, we decided to include 100, 101, anc 111 in our analyses.

## Six Frame Translation of Scaffolds

Sequences belonging to all three scaffolds were downloaded as single fasta files from NCBI.

````
>> perl six_frame.pl scaffold_100.fa >> all_six_frames.fa 
>> perl six_frame.pl scaffold_101.fa >> all_six_frames.fa 
>> perl six_frame.pl CTG111.fa >> all_six_frames.fa
````

The *six_frame.pl* script was a one-off script, it was modified after running each scaffold to attach 100/101/111 to the beginning of each fasta header. An example header is *>101_2516-2598_Frame1* where the dashed identifiers refer to the amino acid start and stop positions of that frame's translation. Importantly, an ORF does not have to start with Methionine.

## HMMERSCAN the SMART Database Against All ORF

The SMART database was downloaded from https://software.embl-em.de/

As the .hmm profiles were made with an older version of hmmer, the aln files were used to generate new .hmm profiles and merged into one file:

````
>> perl hmmbuild.pl
>> cat *.hmm > SMART.hmm
>> hmmscan --cpu 12 SMART.hmm all_six_frames.fa > all_six_frames_smart.out
````

## Process HMMER Results

*smart_hmmer_parser.pl* searches the *all_six_frames.out* file for any ORFs that were significant for containing any variant of a SMART Immunoglobulin domain. Since many types of Ig domains are found with various lengths, the longest possible match to an Ig domain was selected by selecting the minimum and maximum hit start and stop (respectively) for any Ig-like match. 

Results are formatted as .tsv table. By including the scaffold fasta files *scaffold_100.fa, scaffold_101.fa and CTG111.fa* in the same folder, both the amino acid and nucleotide sequences are included in the table.

````
>> perl smart_hmmer_parser.pl > smart_parsed_hmmer_out.tsv
````

## Remove Non-NILTY Ig Domains From the Parsed HMMER Results

A total of 372 Ig domains were found among the three scaffolds. Particularily concerning, CTG111 contained 275 Ig domains and not all contain NILTY features. Therefore, these sequences were uploaded to the NCSU HPC and BLASTP against NCBI's nr database was performed.

````
>> blastp -query igs_to_blast.fa -db nr -num_threads 8 > igs_against_nr.bls
````

The BLAST results were searched for NILTY terms: *CD300|NILT|polymeric\CMRF*. Additionally CD22/B-Cell receptors and sialic acid-binding proteins were found in abundance. There was no overlap in Ig sequences between the NILTY and Non-NILTY search terms. Additioanlly, the Non-NILTY Ig domains were clustered together at the start of CTG111 and NILTY Ig domains were clustered at the end of CTG111. Only a few Igs between these clusters crossed over into the other's cluster. Non-NILTY Ig domains were removed from the *smart_parsed_hmmer_out.tsv* and not considered in additional analyses.

# Identification of Annotated Genes Containing NILT Igs

The currated table produced by *smart_hmmer_parser.pl* provides both scaffold and chromosomal nucleotide start and stop positions of NILT Ig domains. These can be placed in a tsv formated, for example 100_665\t58186270\t58186607. This list can be checked against Ensembl of RefSeq gff files for any exons that overlap. Short-coming of these scripts in that if the exon is used for multiple different transcripts, only one transcript is reported.

````
>> perl zf_parser.pl 
>> perl ncbi_parser.pl 
>> perl parser.pl
````
This data was manually combined with the smart_parsed_hmmer_out.tsv to generate Supplemental Table 2.








