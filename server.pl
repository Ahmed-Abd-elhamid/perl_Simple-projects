#!/usr/bin/perl
#Script create a server that listen on port 7777
use Socket;
use strict;
use crud;

my $SERVERPORT=7777;
my $SERVERIP="127.0.0.1";
my $PAADDR;
my $id;
#SERVERD : Socket Descriptor
#PF_INET: IP V4
#SOCK_STREAM: TCP
#
socket(SERVERD,PF_INET,SOCK_STREAM,getprotobyname("tcp"));
bind(SERVERD,sockaddr_in($SERVERPORT,inet_aton($SERVERIP))) or die "Can not bind $! \n";
listen(SERVERD,SOMAXCONN) or die "Can not listen";
while ( $PAADDR=accept(CLIENTD,SERVERD) ) {
	print "Incoming connection .. \n";
	$id=fork();
	if ( $id == 0 ) {	##Child
		while ( <CLIENTD> ) {
			chomp;
			my @ARR;
			my $len;
			@ARR=split(":",$_);
			$len = @ARR;
			if ( $len == 3) {

				my $name;
				my $email;
				my $passwd;
				$name = $ARR[0];
				$email = $ARR[1];
				$passwd = $ARR[2];

				if( crud::checkIfNotExist($name) ){
					crud::register($name,$email,$passwd);
					print "Client:$name has been registered succcessfully! \n";
				}else{
					print "Client:$name Existed, we can't insert it! \n";
				}

			} else {
				my $name;
				my $passwd;
				$name = $ARR[0];
				$passwd = $ARR[1];
				if (crud::login($name, $passwd)) {
					print "Successfully login \n";
				} else {
					print "Failed to login! \n";
				}
			}
			print "Request Data: $_ \n";
		}
		close(CLIENTD);
	}

}
close(SERVERD);
exit 0;
