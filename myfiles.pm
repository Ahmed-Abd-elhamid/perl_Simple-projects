#!/usr/bin/perl
package myfiles;

# exit 1 ..
#
sub insertData {

	if ( @_ != 3 ){
		exit 1;
	}

	my $fname;
	my($id,$name,$email) = @_;
	$fname = 'data.txt';

		open(MYFILE,">>". $fname) or die "Error: Can not open file";
			print MYFILE "$id:$name:$email\n";
			print "Succeffully data inserted! \n";

		close(MYFILE);
}

sub insertDetails {

	if ( @_ != 3 ){
		exit 1;
	}

	my $fname;
	my($id,$grd1,$grd2) = @_;
	$fname = 'details.txt';

		open(MYFILE,">>". $fname) or die "Error: Can not open file";
			print MYFILE "$id:$grd1:$grd2\n";
			print "Succeffully data inserted! \n";

		close(MYFILE);
}

sub deleteById {

	my $fname1='data.txt';
	my $fname2 ='details.txt';
	my $idn = @_[0];

	fileDelete($idn, $fname2);
	fileDelete($idn, $fname1);

}

sub printFile {
	my $fname1='data.txt';
	my $fname2='details.txt';
	my $idn = @_[0];
	my $id, $res, $line;
	my @arr;

	open(MYFILE,"<". $fname1) or die "Error: Can not open file";
	open(MYFILED,"<". $fname2) or die "Error: Can not open file";

	while( $line=<MYFILE> ) {
		($id)=split(":",$line);
		if($id == $idn){
			chomp $line;
			push(@arr,$line);
	}
	}

	while( $line=<MYFILED> ) {
		($id)=split(":",$line);
		if($id == $idn){
			chomp $line;
			$res = "Main Data(id:name:email) =>  $arr[0]\nGrades Data(id:grade1:grade2) =>  $line";
		}
	}

	if($res){
		print "$res\n";
	}elsif($arr[0]){
		print "$arr[0]\n";
	}else{
		print "No data to print! \n";
	}

	close(MYFILE);
	close(MYFILED);
}

sub checkIfIdExist {

		my $fname='data.txt';
		my $idn = @_[0];
		my $id;
		open(MYFILE,"<". $fname) or die "Error: Can not open file";
		foreach (<MYFILE> ){
			chomp;
			($id)=split(":",$_);
			if($id == $idn){
				close(MYFILE);
				return 1;
			}
		}
		close(MYFILE);
		return 0;
}

sub fileDelete {

	my @lines;
	my $idn, $id, $fname1;
	$idn = @_[0];
	$fname1 = @_[1];

	open(MYFILE,"<". $fname1) or die "Error: Can not open file";
	open(MYTFILE,">>". "mytemp") or die "Error: Can not open file";
	while(<MYFILE>) {
		chomp;
		($id)=split(":",$_);
		if ( $id != $idn ) {
			print MYTFILE "$_\n";
		}
	}
	close(MYTFILE);
	close(MYFILE);
	### Delete the original file
	unlink($fname1);
	## Rename the temp file to be the original file name
	rename("mytemp",$fname1);
}

1;
