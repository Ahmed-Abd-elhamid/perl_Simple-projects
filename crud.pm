#!/usr/bin/perl
package crud;

use strict;
use DBI;
my %DBSETTINGS;

readDBSettings();

sub checkIfNotExist {
	my $name=@_[0];
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	my $Rec;
	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
	$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});
	$SQLSTMT=$DBH->prepare("SELECT * FROM users where name='$name'") or die "$DBH->errstr()";
	$SQLSTMT->execute() or die "$DBH->errstr()";
	$Rec=$SQLSTMT->fetchrow_hashref();
	$SQLSTMT->finish;

	if($Rec){
		return 0;
	}else {
		return 1;
	}
}

sub login {
	my $name=@_[0];
	my $passwd=@_[1];
	my $DSN;
	my $DBH;
	my $SQLSTMT;
	my $Rec;
	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
	$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});
	$SQLSTMT=$DBH->prepare("SELECT * FROM users where name='$name' and  passwd='$passwd'") or die "$DBH->errstr()";
	$SQLSTMT->execute() or die "$DBH->errstr()";
	$Rec=$SQLSTMT->fetchrow_hashref();
	$SQLSTMT->finish;

	if($Rec){
		return 1;
	}else {
		return 0;
	}
}

sub register {
	my $name=@_[0];
	my $email=@_[1];
	my $passwd=@_[2];
	my $DSN;
	my $DBH;
	my $SQLSTMT;

	$DSN="DBI:mysql:database=$DBSETTINGS{'DBNAME'};host=$DBSETTINGS{'DBHOST'}";
	$DBH=DBI->connect($DSN,$DBSETTINGS{"DBUSER"},$DBSETTINGS{"DBPASS"});

	$SQLSTMT=$DBH->prepare("INSERT INTO users(name, email, passwd) VALUES('$name','$email','$passwd')") or die "$DBH->errstr()";
	$SQLSTMT->execute() or die "$DBH->errstr()";
	$SQLSTMT->finish;
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
