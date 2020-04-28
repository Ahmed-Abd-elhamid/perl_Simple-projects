#!/usr/bin/perl
##### Script to query table in mysql
#########################
package db;
use strict;
use DBI;
my %DBSETTINGS;

readDBSettings();

sub NotExist {
	my $id=@_[0];
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	my $Rec;
	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
	$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});
	$SQLSTMT=$DBH->prepare("SELECT * FROM users where id=$id") or die "$DBH->errstr()";
	$SQLSTMT->execute() or die "$DBH->errstr()";
	$Rec=$SQLSTMT->fetchrow_hashref();
	$SQLSTMT->finish;
	if($Rec){
		return 0;
	}else {
		return 1;
	}
}

sub getUser {
	my $id=@_[0];
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	my $Rec;
	if(!NotExist($id)){
	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
		$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});
		$SQLSTMT=$DBH->prepare("SELECT * FROM users where id=$id") or die "$DBH->errstr()";
		$SQLSTMT->execute() or die "$DBH->errstr()";
		$Rec=$SQLSTMT->fetchrow_hashref();
		$SQLSTMT->finish;
		if($Rec){
				print "Name : " . $Rec->{"name"} . "\n";
				print "EMAIL : " . $Rec->{"email"} . "\n";
				return 0;
		}else {
			print "This id:$id not exist";
			return 1;
		}
	}else{
		print "This id:$id not exist";
	}
}

sub delUser {
	my $id=@_[0];
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	my $Rec;
	if(!NotExist($id)){
	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
		$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});
		$SQLSTMT=$DBH->prepare("DELETE FROM details where id=$id") or die "$DBH->errstr()";
		$SQLSTMT->execute() or die "$DBH->errstr()";
		$SQLSTMT=$DBH->prepare("DELETE FROM users where id=$id") or die "$DBH->errstr()";
		$SQLSTMT->execute() or die "$DBH->errstr()";
		$SQLSTMT->finish;
		print "This id:$id deleted successfully!\n";
	}else{
		print "This id:$id not exist";
	}
}

sub insertUser {
	my($id,$name,$email) = @_;
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	if(NotExist($id)){
		$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
		$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});

		$SQLSTMT=$DBH->prepare("INSERT INTO users(id, name, email) VALUES($id, '$name','$email')") or die "$DBH->errstr()";

		$SQLSTMT->execute() or die "$DBH->errstr()";
		$SQLSTMT->finish;
		print "This data($id:$name:$email) inserted successfully!\n";
	}else{
		print "This id:$id is exist, we can insert it.. choose another Id!\n"
	}
	exit 0;
}

sub insertDetails {
	my($id,$grd1,$grd2) = @_;
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	unless( NotExist($id)){

		$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
		$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});

		$SQLSTMT=$DBH->prepare("INSERT INTO details(id, grade1, grade2) VALUES($id, $grd1,$grd2)") or die "$DBH->errstr()";

		$SQLSTMT->execute() or die "$DBH->errstr()";
		$SQLSTMT->finish;
		print "This data($id:$grd1:$grd2) inserted successfully!\n";

	}else{
		print "This id:$id is not exist, to add more details about it!\n"
	}
	exit 0;
}

sub readDBSettings {
	my @lines;
	my $VAR;
	my $VAL;
	open(FH,"< appsettings") or die "Cannot open db settings file\n";
	@lines=<FH>;
	close(FH);
	foreach (@lines) {
		chomp;
		($VAR,$VAL)=split("=",$_);
		$DBSETTINGS{$VAR}=$VAL;
	}
}
1;