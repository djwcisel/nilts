open(ALN, "ls /home/dustin/software/smart_01_06_2016/aln/ |");

while (<ALN>) {
    chomp;
    $name = $_;
    $name =~ s/aln/hmm/g;
    $command = "hmmbuild $name /home/dustin/software/smart_01_06_2016/aln/$_";
    system("$command");
}

close(ALN);
