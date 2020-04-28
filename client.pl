#!/usr/bin/perl
#Script create a tcp client, connects to the server to port 7777
use Socket;
use strict;
my $TOPORT=7777;
my $TPIP="127.0.0.1";
my $name;
my $email;
my $passwd;
my $choose;
$choose = 1;

socket(MYSOCKET,PF_INET,SOCK_STREAM,getprotobyname("tcp"));
connect(MYSOCKET,sockaddr_in($TOPORT,inet_aton($TPIP))) or die "Can not connect to server ERR:500 $! \n";

while ( $choose != 3 ) {

	print "1. Register \n";
	print "2. Login \n";
	print "3. Exit \n";
	print "Choose a Num.(1-3): ";
	$choose = <>;
	chomp $choose;

	if( $choose == 1 ){
		print "Enter Your Name: ";
		$name = <>;
		chomp $name;
		while($email !~ /^[A-Za-z0-9.]+\@[a-z0-9.-]+$/){
			print "Enter Your Email: ";
			$email = <>;
			chomp $email;
			if($email !~ /^[A-Za-z0-9.]+\@[a-z0-9.-]+$/){print "Please enter correct Email, ";}
		}
		print "Enter Your Password: ";
		$passwd = <>;
		chomp $passwd;

		if($name && $email && $passwd){
			# chomp;
			syswrite MYSOCKET,"$name:$email:$passwd\n";
			print "Data Sent to Server Succuessffully..\n";
		}else{
			print "Can't Send Data To Server!";
		}

	}elsif( $choose == 2){
		print "Enter Your Name: ";
		$name = <>;
		chomp $name;

		print "Enter Your Password: ";
		$passwd = <>;
		chomp $passwd;
		
		if($name && $passwd){
			# chomp;
			syswrite MYSOCKET,"$name:$passwd\n";
			print "Data Sent to Server Succuessffully..\n";
		}else{
			print "Can't Send Data To Server!";
		}

	}elsif($choose == 3){
		print "Are you sure (y/n)? ";
		$choose = <>;
		chomp $choose;
		if ( $choose eq 'y' || $choose eq 'Y') { 
			exit 0;
		}
	}
}

close(MYSOCKET);
