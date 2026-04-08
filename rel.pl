# rel.pl
undef $/;
$_ = <>;

my $abs_path = "/home/adityadas/codingProjects/MATLAB_CodeScripts/Animations/";
my $rel_path = "../../../Animations/";

s/\Q$abs_path\E/$rel_path/g;

print $_;
